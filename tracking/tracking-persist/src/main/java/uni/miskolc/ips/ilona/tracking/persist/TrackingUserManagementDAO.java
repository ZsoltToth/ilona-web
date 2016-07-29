package uni.miskolc.ips.ilona.tracking.persist;

import java.util.Collection;

import uni.miskolc.ips.ilona.tracking.model.database.DatabaseUserDatas;
import uni.miskolc.ips.ilona.tracking.persist.exception.DatabaseProblemException;
import uni.miskolc.ips.ilona.tracking.persist.exception.OperationExecutionErrorException;
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
	 * @throws OperationExecutionErrorException
	 */
	void createUser(DatabaseUserDatas userdata) throws UserAlreadyExists, OperationExecutionErrorException;

	/**
	 * 
	 * @param userid
	 * @return
	 * @throws UserNotFoundException
	 */
	DatabaseUserDatas getUser(String userid) throws UserNotFoundException, OperationExecutionErrorException;

	/**
	 * 
	 * @return
	 * @throws DatabaseProblemException
	 */
	Collection<DatabaseUserDatas> getAllUsers() throws DatabaseProblemException, OperationExecutionErrorException;

	/**
	 * 
	 * @param userdata
	 * @throws UserNotFoundException
	 */
	void updateUser(DatabaseUserDatas userdata) throws UserNotFoundException, OperationExecutionErrorException;

	/**
	 * 
	 * @param userid
	 * @throws UserNotFoundException
	 */
	void deleteUser(String userid) throws UserNotFoundException, OperationExecutionErrorException;


}
