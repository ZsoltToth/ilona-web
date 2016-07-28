package uni.miskolc.ips.ilona.tracking.persist;

import java.util.Collection;
import java.util.List;

import uni.miskolc.ips.ilona.measurement.model.position.Position;
import uni.miskolc.ips.ilona.tracking.model.database.DatabaseDeviceDatas;

public interface TrackingServiceDAO {

	/*
	 * DEVICE CRUD
	 */

	/**
	 * 
	 * @param deviceData
	 * @param userid
	 */
	void storeDevice(DatabaseDeviceDatas deviceData);

	/*
	 * 
	 * INSERT INTO tbl_name (a,b,c) VALUES (1,2,3), (4,5,6), (7,8,9);
	 */
	/**
	 * 
	 * @param devices
	 * @param userid
	 */
	void storeDevices(Collection<DatabaseDeviceDatas> devices);

	
	/**
	 * 
	 * @param userid
	 * @return
	 */
	DatabaseDeviceDatas getDeviceByUserid(String userid);

	/**
	 * 
	 * @param userid
	 * @return
	 */
	List<DatabaseDeviceDatas> getUserDevicesByUserid(String userid);

	/*
	 * MySQL pattern delete from TrackingUsers where (userid) in ('user1',
	 * 'user3')
	 */
	Collection<DatabaseDeviceDatas> getAllDevices();
	
	/**
	 * 
	 * @param device
	 */
	void updateDevice(DatabaseDeviceDatas device);
	
	/**
	 * 
	 * @param devices
	 */
	void updateDevices(Collection<DatabaseDeviceDatas> devices);
	
	/**
	 * 
	 * @param deviceid
	 */
	void deleteDevice(DatabaseDeviceDatas device);

	/**
	 * 
	 * @param deviceids
	 * @param userid
	 */
	void deleteDevices(Collection<DatabaseDeviceDatas> devices);
	

	/**
	 * 
	 * @return
	 */
	Position getPositionByUUID();

	/**
	 * 
	 * @param deviceid
	 * @return
	 */
	List<Position> getDevicesPositions(DatabaseDeviceDatas device);

}
