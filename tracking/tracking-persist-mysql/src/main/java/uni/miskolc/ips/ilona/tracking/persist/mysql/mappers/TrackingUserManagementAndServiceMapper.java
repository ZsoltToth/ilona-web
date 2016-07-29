package uni.miskolc.ips.ilona.tracking.persist.mysql.mappers;

import java.util.Collection;
import java.util.List;

import uni.miskolc.ips.ilona.measurement.model.position.Position;
import uni.miskolc.ips.ilona.tracking.model.database.DatabaseDeviceDatas;
import uni.miskolc.ips.ilona.tracking.model.database.DatabaseUserDatas;
import uni.miskolc.ips.ilona.tracking.persist.exception.DatabaseProblemException;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserAlreadyExists;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserNotFoundException;

public interface TrackingUserManagementAndServiceMapper {

	/*
	 * User CRUD
	 */

	/**
	 * 
	 * @param userdata
	 * @throws UserAlreadyExists
	 */
	int createUser(DatabaseUserDatas userdata);

	/**
	 * 
	 * @param userid
	 * @return
	 * @throws UserNotFoundException
	 */
	DatabaseUserDatas getUser(String userid);

	/**
	 * 
	 * @param userdata
	 * @throws UserNotFoundException
	 */
	int updateUser(DatabaseUserDatas userdata);

	/**
	 * 
	 * @param userid
	 * @throws UserNotFoundException
	 */
	int deleteUser(String userid);

	/**
	 * 
	 * @return
	 * @throws DatabaseProblemException
	 */
	Collection<DatabaseUserDatas> getAllUsers();

	/*
	 * DEVICE CRUD
	 */

	/**
	 * 
	 * @param deviceData
	 */
	int storeDevice(DatabaseDeviceDatas deviceData);

	/**
	 * 
	 * @param deviceid
	 */
	int deleteDevice(DatabaseDeviceDatas device);

	
	int updateDevice(DatabaseDeviceDatas device);
	/**
	 * 
	 * @param userid
	 * @return
	 */
	Collection<DatabaseDeviceDatas> getDevicesByUserid(String userid);
	
	Collection<DatabaseDeviceDatas> getAllDevices();

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
	//List<Position> getDevicesPositions(String deviceid);
}
