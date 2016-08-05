package uni.miskolc.ips.ilona.tracking.persist;

import java.util.Collection;

import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.exception.OperationExecutionErrorException;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserAlreadyExistsException;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserNotFoundException;

/**
 * 
 * @author Patrik / A5USL0
 *
 */
public interface UserManagementDAO {

	/*
	 * USER CRUD
	 */

	void createUser(UserData user) throws UserAlreadyExistsException, OperationExecutionErrorException;

	UserData getUser(String userid) throws UserNotFoundException, OperationExecutionErrorException;

	Collection<UserData> getAllUsers() throws OperationExecutionErrorException;

	void updateUser(UserData user) throws UserNotFoundException, OperationExecutionErrorException;

	void deleteUser(String userid) throws UserNotFoundException, OperationExecutionErrorException;
}
