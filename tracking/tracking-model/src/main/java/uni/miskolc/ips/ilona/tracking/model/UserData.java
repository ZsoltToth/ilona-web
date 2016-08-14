package uni.miskolc.ips.ilona.tracking.model;

import java.util.Collection;
import java.util.Date;
import java.util.Iterator;

/**
 * Dokumentáció készítése!
 * 
 * @author Patrik / A5USL0
 *
 */
public class UserData {

	/*
	 * User base fields.
	 */

	/**
	 * A unique id for the the current user.
	 */
	private String userid;

	/**
	 * An arbitrary username.
	 */
	private String username;

	/**
	 * This field is user for password recovery,
	 */
	private String email;

	/**
	 * A hashed password.
	 */
	private String password;

	/*
	 * Security fields.
	 */

	/**
	 * 
	 */
	private boolean enabled;

	/**
	 * ROLE_USER, ROLE_ADMIN stb.
	 */
	private Collection<String> roles;

	/**
	 * Utolsó belépési dátum => hosszú idő óta nem lépett be => lejárt account
	 */
	private Date lastLoginDate;

	/**
	 * 
	 */
	private Date credentialNonExpiredUntil;

	/**
	 * If the nonLocked is false, the account is locked until this date. The
	 * length of the lock is defined in the TracingCentral
	 */
	private Date lockedUntil;

	/**
	 * nincs lockolvan az adott adat!
	 */
	private boolean nonLocked;

	/**
	 * Hibás bejelentkezések
	 */
	private Collection<Date> badLogins;

	/**
	 * Eszközök az adott felhasználóhoz.
	 */
	private Collection<DeviceData> devices;

	public UserData() {

	}

	public UserData(String userid, String username, String email, String password, boolean enabled,
			Collection<String> roles, Date lastLoginDate, Date credentialNonExpiredUntil, Date lockedUntil,
			boolean nonLocked, Collection<Date> badLogins, Collection<DeviceData> devices) {
		super();
		this.userid = userid;
		this.username = username;
		this.email = email;
		this.password = password;
		this.enabled = enabled;
		this.roles = roles;
		this.lastLoginDate = lastLoginDate;
		this.credentialNonExpiredUntil = credentialNonExpiredUntil;
		this.lockedUntil = lockedUntil;
		this.nonLocked = nonLocked;
		this.badLogins = badLogins;
		this.devices = devices;
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

	public Collection<String> getRoles() {
		return roles;
	}

	public Collection<String> setRoles(Collection<String> roles) {
		if (roles != null) {
			this.roles = roles;
			return roles;
		}
		return null;
	}

	public String addRole(String role) {
		if (role == null) {
			return null;
		}
		boolean exists = false;
		for (String storedrole : roles) {
			if (storedrole.equals(role)) {
				exists = true;
			}
		}
		if (exists != true) {
			roles.add(role);
		}
		return role;
	}

	public String removeRole(String role) {
		if (role == null) {
			return null;
		}
		roles.remove(role);
		return role;
	}

	public Date getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public Date getCredentialNonExpiredUntil() {
		return credentialNonExpiredUntil;
	}

	public void setCredentialNonExpiredUntil(Date credentialNonExpiredUntil) {
		this.credentialNonExpiredUntil = credentialNonExpiredUntil;
	}

	public Date getLockedUntil() {
		return lockedUntil;
	}

	public void setLockedUntil(Date lockedUntil) {
		this.lockedUntil = lockedUntil;
	}

	public boolean isNonLocked() {
		return nonLocked;
	}

	public void setNonLocked(boolean nonLocked) {
		this.nonLocked = nonLocked;
	}

	public Collection<Date> getBadLogins() {
		return badLogins;
	}

	public Collection<Date> setBadLogins(Collection<Date> badLogins) {
		if (badLogins != null) {
			this.badLogins = badLogins;
			return badLogins;
		}
		return null;
	}

	public Date addBadLogin(Date login) {
		if (login == null) {
			return null;
		}
		boolean exists = false;
		for (Date storedLogin : this.badLogins) {
			if (storedLogin.getTime() == login.getTime()) {
				exists = true;
			}
		}
		if (exists != true) {
			this.badLogins.add(login);
		}
		return login;
	}

	public Date removeBadLogin(Date login) {
		if (login == null) {
			return null;
		}
		this.badLogins.remove(login);
		return login;
	}

	public Collection<DeviceData> getDevices() {
		return devices;
	}

	public Collection<DeviceData> setDevices(Collection<DeviceData> devices) {
		if (devices != null) {
			this.devices = devices;
			return devices;
		}
		return null;
	}

	public DeviceData addDevice(DeviceData newDevice) {
		if (newDevice == null) {
			return null;
		}
		/*
		 * Update
		 */
		for (DeviceData dev : this.devices) {
			if (dev.getDeviceid().equals(newDevice.getDeviceid())) {
				dev.setDeviceName(newDevice.getDeviceName());
				dev.setDeviceType(newDevice.getDeviceType());
				dev.setDeviceTypeName(newDevice.getDeviceTypeName());
				return newDevice;
			}
		}
		/*
		 * Not exists, add
		 */
		this.devices.add(newDevice);
		return newDevice;
	}

	public DeviceData removeDevice(DeviceData noDevice) {
		if (noDevice == null) {
			return null;
		}
		Iterator<DeviceData> devIt = this.devices.iterator();
		while (devIt.hasNext()) {
			DeviceData data = devIt.next();
			if (data.getDeviceid().equals(noDevice.getDeviceid())) {
				devIt.remove();
				return noDevice;
			}
		}
		return noDevice;
	}

	@Override
	public String toString() {
		return "UserData [userid=" + userid + ", username=" + username + ", email=" + email + ", password=" + password
				+ ", enabled=" + enabled + ", roles=" + roles + ", lastLoginDate=" + lastLoginDate
				+ ", credentialNonExpiredUntil=" + credentialNonExpiredUntil + ", lockedUntil=" + lockedUntil
				+ ", nonLocked=" + nonLocked + ", badLogins=" + badLogins + ", devices=" + devices + "]";
	}

}
