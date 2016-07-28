package uni.miskolc.ips.ilona.tracking.model.database;

/**
 * 
 * @author Patrik / A5USL0
 *
 */
public final class DatabaseDeviceDatas {

	/**
	 * 
	 */
	private String userid;

	/**
	 * 
	 */
	private String deviceid;

	/**
	 * 
	 */
	private String deviceName; // My device

	/**
	 * 
	 */
	private String deviceTypeName; // e.g: samsung z1321321

	/**
	 * 
	 */
	private String deviceType; // mobil, pc, tablet, other

	/**
	 * 
	 */
	public DatabaseDeviceDatas() {

	}

	public DatabaseDeviceDatas(String userid, String deviceid, String deviceName, String deviceTypeName,
			String deviceType) {
		super();
		this.userid = userid;
		this.deviceid = deviceid;
		this.deviceName = deviceName;
		this.deviceTypeName = deviceTypeName;
		this.deviceType = deviceType;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getDeviceid() {
		return deviceid;
	}

	public void setDeviceid(String deviceid) {
		this.deviceid = deviceid;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getDeviceTypeName() {
		return deviceTypeName;
	}

	public void setDeviceTypeName(String deviceTypeName) {
		this.deviceTypeName = deviceTypeName;
	}

	public String getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((deviceName == null) ? 0 : deviceName.hashCode());
		result = prime * result + ((deviceType == null) ? 0 : deviceType.hashCode());
		result = prime * result + ((deviceTypeName == null) ? 0 : deviceTypeName.hashCode());
		result = prime * result + ((deviceid == null) ? 0 : deviceid.hashCode());
		result = prime * result + ((userid == null) ? 0 : userid.hashCode());
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
		DatabaseDeviceDatas other = (DatabaseDeviceDatas) obj;
		if (deviceName == null) {
			if (other.deviceName != null)
				return false;
		} else if (!deviceName.equals(other.deviceName))
			return false;
		if (deviceType == null) {
			if (other.deviceType != null)
				return false;
		} else if (!deviceType.equals(other.deviceType))
			return false;
		if (deviceTypeName == null) {
			if (other.deviceTypeName != null)
				return false;
		} else if (!deviceTypeName.equals(other.deviceTypeName))
			return false;
		if (deviceid == null) {
			if (other.deviceid != null)
				return false;
		} else if (!deviceid.equals(other.deviceid))
			return false;
		if (userid == null) {
			if (other.userid != null)
				return false;
		} else if (!userid.equals(other.userid))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "DatabaseDeviceDatas [userid=" + userid + ", deviceid=" + deviceid + ", deviceName=" + deviceName
				+ ", deviceTypeName=" + deviceTypeName + ", deviceType=" + deviceType + "]";
	}

}
