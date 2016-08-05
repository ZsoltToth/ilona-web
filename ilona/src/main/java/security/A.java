package security;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class A {

	public static void main(String[] Args) {
		BCryptPasswordEncoder enc = new BCryptPasswordEncoder(10);
		
		String encoded = enc.encode("user1");
		System.out.println(encoded.length() + "  " + encoded);

		System.out.println(enc.matches("ilona", encoded));
		
		GrantedAuthority ga = new SimpleGrantedAuthority("ROLE_ADMIN");
		
		System.out.println(ga.getAuthority());
	}
}
