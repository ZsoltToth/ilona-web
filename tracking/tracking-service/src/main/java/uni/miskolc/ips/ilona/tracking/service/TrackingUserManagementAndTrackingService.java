package uni.miskolc.ips.ilona.tracking.service;

import java.util.Collection;

import uni.miskolc.ips.ilona.tracking.model.database.DatabaseDeviceDatas;
import uni.miskolc.ips.ilona.tracking.model.database.DatabaseUserDatas;

public interface TrackingUserManagementAndTrackingService {

	/*
	 * User CRUD part.
	 */

	void createUser(DatabaseUserDatas userdata);

	DatabaseUserDatas getUser(String userid);

	Collection<DatabaseUserDatas> getAllUsers();

	void updateUser(DatabaseUserDatas userdata);

	void deleteUser(String userid);

	/**
	 * Tracking service part.
	 */

	void storeDevice(DatabaseDeviceDatas deviceData);

	Collection<DatabaseDeviceDatas> getDeviceByUserid(String userid);

	Collection<DatabaseDeviceDatas> getAllDevices();

	void updateDevice(DatabaseDeviceDatas device);

	void deleteDevice(DatabaseDeviceDatas device);

}
