package uni.miskolc.ips.ilona.tracking.persist;

import java.util.Collection;

import uni.miskolc.ips.ilona.tracking.model.database.DatabaseUserDatas;
import uni.miskolc.ips.ilona.tracking.persist.exception.DatabaseProblemException;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserAlreadyExists;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserNotFoundException;

/**
 * 
 * @author Patrik / A5USL0
 *
 */
public interface TrackingUserManagementDAO {

	/*
	 * User CRUD
	 */

	/**
	 * 
	 * @param userdata
	 * @throws UserAlreadyExists
	 */
	void createUser(DatabaseUserDatas userdata) throws UserAlreadyExists;

	/**
	 * 
	 * @param users
	 */
	void createUsers(Collection<DatabaseUserDatas> users);

	/**
	 * 
	 * @param userid
	 * @return
	 * @throws UserNotFoundException
	 */
	DatabaseUserDatas getUser(String userid) throws UserNotFoundException;

	/**
	 * 
	 * @param users
	 * @return
	 */
	Collection<DatabaseUserDatas> getUsers(Collection<String> users);

	/**
	 * 
	 * @return
	 * @throws DatabaseProblemException
	 */
	Collection<DatabaseUserDatas> getAllUsers() throws DatabaseProblemException;

	/**
	 * 
	 * @param userdata
	 * @throws UserNotFoundException
	 */
	void updateUser(DatabaseUserDatas userdata) throws UserNotFoundException;

	/**
	 * 
	 * @param userdatas
	 */
	void updateUsers(Collection<DatabaseUserDatas> userdatas);

	/**
	 * 
	 * @param userid
	 * @throws UserNotFoundException
	 */
	void deleteUser(String userid) throws UserNotFoundException;

	/**
	 * 
	 * @param userids
	 */
	void delelteUsers(Collection<String> userids);

}
