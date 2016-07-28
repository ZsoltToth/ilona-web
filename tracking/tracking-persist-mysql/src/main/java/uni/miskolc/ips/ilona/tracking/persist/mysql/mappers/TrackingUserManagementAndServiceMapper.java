package uni.miskolc.ips.ilona.tracking.persist.mysql.mappers;

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
	void createUser(DatabaseUserDatas userdata);

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
	void updateUser(DatabaseUserDatas userdata);

	/**
	 * 
	 * @param userid
	 * @throws UserNotFoundException
	 */
	void deleteUser(String userid);

	/**
	 * 
	 * @return
	 * @throws DatabaseProblemException
	 */
	List<DatabaseUserDatas> getAllUsers();

	/**
	 * 
	 * @param deviceData
	 */
	void storeDevice(DatabaseDeviceDatas deviceData);

	/**
	 * 
	 * @param deviceid
	 */
	void deleteDeviceByDeviceid(String deviceid);

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
	List<Position> getDevicesPositions(String deviceid);
}
