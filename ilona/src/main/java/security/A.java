package security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import uni.miskolc.ips.ilona.tracking.model.TrackingLoginUserData;

public class A {

	public static void main(String[] Args) {
		BCryptPasswordEncoder enc = new BCryptPasswordEncoder(10);
		
		String encoded = enc.encode("user1");
		System.out.println(encoded.length() + "  " + encoded);
		TrackingLoginUserData ud = new TrackingLoginUserData("bela", "belapass", true);
		TrackingLoginUserData ud2 = ud.createDeepCopy();
		ud2.setUsername("peti");
		System.out.println(ud.getUsername());
		System.out.println(ud2.getUsername());
		System.out.println(enc.matches("ilona", encoded));
		
		GrantedAuthority ga = new SimpleGrantedAuthority("ROLE_ADMIN");
		
		System.out.println(ga.getAuthority());
	}
}
