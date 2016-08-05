package uni.miskolc.ips.ilona.tracking.model.database;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.Collection;
import java.util.Date;

/**
 * 
 * @author Patrik / A5USL0
 *
 */
public final class DatabaseUserDatas implements Comparable<DatabaseUserDatas> {

	/**
	 * 
	 */
	private String userid;

	/**
	 * 
	 */
	private String username;

	/**
	 * 
	 */
	private String email;

	/**
	 * 
	 */
	private String password;

	/**
	 * 
	 */
	private boolean enabled;

	/*
	 * 
	 */
	private Date nonExpired;

	/**
	 * 
	 */
	private int loginAttempts;

	/**
	 * 
	 */
	private Date firstBadLoginAttempt;

	/**
	 * 
	 */
	private Date credentialsNonExpired;

	/**
	 * 
	 */
	private Collection<String> roles;

	/**
	 * 
	 */
	public DatabaseUserDatas() {

	}

	/**
	 * 
	 * @param userid
	 * @param username
	 * @param email
	 * @param password
	 * @param enabled
	 * @param nonExpired
	 * @param loginAttempts
	 * @param firstBadLoginAttempt
	 * @param credentialsNonExpired
	 * @param roles
	 */
	public DatabaseUserDatas(String userid, String username, String email, String password, boolean enabled,
			Date nonExpired, int loginAttempts, Date firstBadLoginAttempt, Date credentialsNonExpired,
			Collection<String> roles) {
		super();
		this.userid = userid;
		this.username = username;
		this.email = email;
		this.password = password;
		this.enabled = enabled;
		this.nonExpired = nonExpired;
		this.loginAttempts = loginAttempts;
		this.firstBadLoginAttempt = firstBadLoginAttempt;
		this.credentialsNonExpired = credentialsNonExpired;
		this.roles = roles;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public Date getNonExpired() {
		return nonExpired;
	}

	public void setNonExpired(Date nonExpired) {
		this.nonExpired = nonExpired;
	}

	public int getLoginAttempts() {
		return loginAttempts;
	}

	public void setLoginAttempts(int loginAttempts) {
		this.loginAttempts = loginAttempts;
	}

	public Date getFirstBadLoginAttempt() {
		return firstBadLoginAttempt;
	}

	public void setFirstBadLoginAttempt(Date firstBadLoginAttempt) {
		this.firstBadLoginAttempt = firstBadLoginAttempt;
	}

	public Date getCredentialsNonExpired() {
		return credentialsNonExpired;
	}

	public void setCredentialsNonExpired(Date credentialsNonExpired) {
		this.credentialsNonExpired = credentialsNonExpired;
	}

	public Collection<String> getRoles() {
		return roles;
	}

	public void setRoles(Collection<String> roles) {
		this.roles = roles;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((credentialsNonExpired == null) ? 0 : credentialsNonExpired.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + (enabled ? 1231 : 1237);
		result = prime * result + ((firstBadLoginAttempt == null) ? 0 : firstBadLoginAttempt.hashCode());
		result = prime * result + loginAttempts;
		result = prime * result + ((nonExpired == null) ? 0 : nonExpired.hashCode());
		result = prime * result + ((password == null) ? 0 : password.hashCode());
		result = prime * result + ((roles == null) ? 0 : roles.hashCode());
		result = prime * result + ((userid == null) ? 0 : userid.hashCode());
		result = prime * result + ((username == null) ? 0 : username.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		DatabaseUserDatas other = (DatabaseUserDatas) obj;
		if (credentialsNonExpired == null) {
			if (other.credentialsNonExpired != null)
				return false;
		} else if (!credentialsNonExpired.equals(other.credentialsNonExpired))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (enabled != other.enabled)
			return false;
		if (firstBadLoginAttempt == null) {
			if (other.firstBadLoginAttempt != null)
				return false;
		} else if (!firstBadLoginAttempt.equals(other.firstBadLoginAttempt))
			return false;
		if (loginAttempts != other.loginAttempts)
			return false;
		if (nonExpired == null) {
			if (other.nonExpired != null)
				return false;
		} else if (!nonExpired.equals(other.nonExpired))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		if (roles == null) {
			if (other.roles != null)
				return false;
		} else if (!roles.equals(other.roles))
			return false;
		if (userid == null) {
			if (other.userid != null)
				return false;
		} else if (!userid.equals(other.userid))
			return false;
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}

	public DatabaseUserDatas createShallowCopy() {
		try {
			return (DatabaseUserDatas) this.clone();
		} catch (CloneNotSupportedException e) {
			return null;
		}

	}

	public DatabaseUserDatas createDeepCopy() {

		ByteArrayOutputStream bos = null;
		ObjectOutputStream out = null;
		ObjectInputStream ois = null;
		ByteArrayInputStream bis = null;
		DatabaseUserDatas userdetails = null;

		try {
			/*
			 * Serialization part.
			 */
			bos = new ByteArrayOutputStream();
			out = new ObjectOutputStream(bos);
			out.writeObject(this);
			out.flush();
			// out.close();

			/*
			 * Deserialization part.
			 */
			bis = new ByteArrayInputStream(bos.toByteArray());
			ois = new ObjectInputStream(bis);
			userdetails = (DatabaseUserDatas) ois.readObject();

		} catch (Exception e) {
			userdetails = null;
			if (bos != null) {
				try {
					bos.close();
				} catch (Exception a) {

				}
			}

			if (out != null) {
				try {
					out.close();
				} catch (Exception a) {

				}
			}

			if (ois != null) {
				try {
					ois.close();
				} catch (Exception a) {

				}
			}

			if (bis == null) {
				try {
					bis.close();
				} catch (Exception a) {

				}
			}
		}

		return userdetails;
	}

	@Override
	public String toString() {
		return "DatabaseUserDatas [userid=" + userid + ", username=" + username + ", email=" + email + ", password="
				+ "[PROTECTED]" + ", enabled=" + enabled + ", nonExpired=" + nonExpired + ", loginAttempts="
				+ loginAttempts + ", firstBadLoginAttempt=" + firstBadLoginAttempt + ", credentialsNonExpired="
				+ credentialsNonExpired + ", roles=" + roles + "]";
	}

	@Override
	public int compareTo(DatabaseUserDatas o) {
		if (this.userid == null) {
			if (o.userid == null) {
				return 0;
			}
			return -1;
		}
		return this.userid.compareTo(o.userid);
	}

}
