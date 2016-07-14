package security;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import uni.miskolc.ips.ilona.tracking.model.TrackingLoginUserData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.TrackingDAO;
import uni.miskolc.ips.ilona.tracking.persist.exception.TrackingUserNotFoundException;

public class TrackingAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	TrackingDAO trackingDAO;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String name = authentication.getName();
		try {
		TrackingLoginUserData userdata = trackingDAO.getUser(name);
		if (userdata == null) {
			throw new TrackingUserNotFoundException();
		}
		
		for(String s : userdata.getRoles()) {
			System.out.println("role: " + s);
		}
		System.out.println(userdata.isEnabled());
		String password = authentication.getCredentials().toString();
		List<GrantedAuthority> grantedAuths = new ArrayList<>();
		grantedAuths.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
		String hashedPassword = userdata.getPassword();
		if (passwordEncoder.matches(password, hashedPassword)) {
		//if (enc.matches(password, enc.encode("ilona"))) {
			return new UsernamePasswordAuthenticationToken(name, password, grantedAuths);
		}
		
		} catch(TrackingUserNotFoundException e) {
			return null;
		}
		return null;
	}

	@Override
	public boolean supports(Class<?> arg0) {
		return arg0.equals(UsernamePasswordAuthenticationToken.class);
	}
	
	/**
	 * Autowire
	 * @param trackingDAO
	 */
	public void setTrackingDAO(TrackingDAO trackingDAO) {
		this.trackingDAO = trackingDAO;
	}

	public void setPasswordEncoder(BCryptPasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}
	
	
}
