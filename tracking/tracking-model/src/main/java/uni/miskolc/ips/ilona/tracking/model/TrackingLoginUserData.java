package uni.miskolc.ips.ilona.tracking.model;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.List;

/**
 * 
 * @author kpatryk91
 *
 */
public class TrackingLoginUserData implements Serializable, Cloneable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String username;
	private String password;
	private boolean enabled;
	private List<String> roles;

	/**
	 * Parameterless constructor for serialization or other function.
	 */
	public TrackingLoginUserData() {
	}

	/**
	 * 
	 * @param username
	 *            The username of the current user, primary key int the table
	 * @param password
	 *            The raw password of the current user
	 */
	public TrackingLoginUserData(String username, String password, boolean enabled) {
		this.username = username;
		this.password = password;
		this.enabled = enabled;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
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

	public List<String> getRoles() {
		return roles;
	}

	public void setRoles(List<String> roles) {
		this.roles = roles;
	}

	/**
	 * Create a shallow copy(byte to byte copy) from the current object.
	 * 
	 * @return The shallow copied verison of the current object.
	 */
	public TrackingLoginUserData createShallowCopy() {
		try {
			return (TrackingLoginUserData) this.clone();
		} catch (CloneNotSupportedException e) {
			return null;
		}

	}

	/**
	 * Create a deep copy from the current object. This will serialize and
	 * deserialize the current object to make a completely new version from
	 * it.<br>
	 * 
	 * @return A total new copy of the current object. (except static of
	 *         course)<br>
	 *         if an error occurs, the return value will be null!
	 */
	public TrackingLoginUserData createDeepCopy() {
		try {
			/*
			 * 
			 */
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			ObjectOutputStream out = new ObjectOutputStream(bos);
			out.writeObject(this);
			out.flush();
			out.close();

			/*
			 * 
			 */
			ObjectInputStream in = new ObjectInputStream(new ByteArrayInputStream(bos.toByteArray()));
			return (TrackingLoginUserData) in.readObject();
		} catch (IOException e) {
			return null;
		} catch (ClassNotFoundException e) {
			return null;
		}
	}

	@Override
	public String toString() {
		return "TrackingLoginUserData [username=" + username + ", password=" + "[NonVisiblePassword]" + "]";
	}

}
