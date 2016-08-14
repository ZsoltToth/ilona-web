package uni.miskolc.ips.ilona.tracking.model;

import java.util.Date;

/**
 * 
 * @author Patrik
 *
 */
public class PasswordRecoveryToken {

	private String userid;

	private String token;

	private Date tokenValidUntil;

	public PasswordRecoveryToken() {

	}

	public PasswordRecoveryToken(String userid, String token, Date tokenValidUntil) {
		super();
		this.userid = userid;
		this.token = token;
		this.tokenValidUntil = tokenValidUntil;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public Date getTokenValidUntil() {
		return tokenValidUntil;
	}

	public void setTokenValidUntil(Date tokenValidUntil) {
		this.tokenValidUntil = tokenValidUntil;
	}

	@Override
	public String toString() {
		return "PasswordRecoveryToken [userid=" + userid + ", token=" + token + ", tokenValidUntil=" + tokenValidUntil
				+ "]";
	}
}
