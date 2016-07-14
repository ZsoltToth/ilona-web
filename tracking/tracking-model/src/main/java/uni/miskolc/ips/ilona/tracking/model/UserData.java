package uni.miskolc.ips.ilona.tracking.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 
 * @author Patrik
 *
 */
public class UserData implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4360136533208118793L;
	
	private String userID;
	private String password;
	private boolean enabled;
	private Date joinDate;
	private List<String> roles;

	public UserData() {
		
	}
	
	/**
	 * 
	 * @param userID
	 * @param password
	 * @param enabled
	 * @param joinDate
	 * @param role
	 */
	public UserData(String userID, String password, boolean enabled, Date joinDate, List<String> roles) {
		super();
		this.userID = userID;
		this.password = password;
		this.enabled = enabled;
		this.joinDate = joinDate;
		this.roles = roles;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
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

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public List<String> getRoles() {
		return roles;
	}

	public void setRoles(List<String> roles) {
		this.roles = roles;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((userID == null) ? 0 : userID.hashCode());
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
		UserData other = (UserData) obj;
		if (userID == null) {
			if (other.userID != null)
				return false;
		} else if (!userID.equals(other.userID))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "UserData [userID=" + userID + ", enabled=" + enabled + ", joinDate=" + joinDate + ", role=" + roles.toString()
				+ "]";
	}

}