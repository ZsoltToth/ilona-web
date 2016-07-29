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

	/**
	 * 
	 * @param userid
	 * @return
	 */
	Collection<DatabaseDeviceDatas> getDeviceByUserid(String userid);

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
	 * @param deviceid
	 */
	void deleteDevice(DatabaseDeviceDatas device);

	/**
	 * 
	 * @return
	 */
	//Position getPositionByUUID();

	/**
	 * 
	 * @param deviceid
	 * @return
	 */
	//List<Position> getDevicesPositions(DatabaseDeviceDatas device);

	/*
	 * 
	 * INSERT INTO tbl_name (a,b,c) VALUES (1,2,3), (4,5,6), (7,8,9);
	 */
	/**
	 * 
	 * @param devices
	 * @param userid
	 */
	// void storeDevices(Collection<DatabaseDeviceDatas> devices);

	/**
	 * 
	 * @param devices
	 */
	// void updateDevices(Collection<DatabaseDeviceDatas> devices);

	/**
	 * 
	 * @param deviceids
	 * @param userid
	 */
	// void deleteDevices(Collection<DatabaseDeviceDatas> devices);

}
