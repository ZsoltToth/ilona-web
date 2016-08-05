package uni.miskolc.ips.ilona.tracking.model;

/**
 * 
 * @author Patrik / A5USL0
 *
 */
public class DeviceData {

	/**
	 * 
	 */
	private String deviceid;

	/**
	 * 
	 */
	private String deviceName;

	/**
	 * 
	 */
	private String deviceType;

	/**
	 * 
	 */
	private String deviceTypeName;
	
	public DeviceData() {
		
	}

	public DeviceData(String deviceid, String deviceName, String deviceType, String deviceTypeName) {
		super();
		this.deviceid = deviceid;
		this.deviceName = deviceName;
		this.deviceType = deviceType;
		this.deviceTypeName = deviceTypeName;
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

	public String getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(String deviceType) {
		this.deviceType = deviceType;
	}

	public String getDeviceTypeName() {
		return deviceTypeName;
	}

	public void setDeviceTypeName(String deviceTypeName) {
		this.deviceTypeName = deviceTypeName;
	}

	@Override
	public String toString() {
		return "DeviceData [deviceid=" + deviceid + ", deviceName=" + deviceName + ", deviceType=" + deviceType
				+ ", deviceTypeName=" + deviceTypeName + "]";
	}

}
