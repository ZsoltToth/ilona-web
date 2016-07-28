package uni.miskolc.ips.ilona.tracking.persist;

import java.util.List;

import uni.miskolc.ips.ilona.tracking.model.UserDetails;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserNotFoundException;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserAlreadyExists;

/**
 * The common interface for user operations.
 * 
 * @author Patrik
 *
 */
public interface TrackingUserDAO {

	/**
	 * 
	 * @param user
	 * @exception TrackingUserAlreadyExists
	 */
	public void createUser(UserDetails user) throws UserAlreadyExists;

	/**
	 * 
	 * @param userID
	 * @return
	 */
	public UserDetails getUser(String userid) throws UserNotFoundException;

	/**
	 * 
	 * @param user
	 */
	public void updateUser(UserDetails user) throws UserNotFoundException;

	/**
	 * 
	 * @param userID
	 */
	public void deleteUser(String userid) throws UserNotFoundException;

	/**
	 * 
	 * @return
	 */
	public List<UserDetails> getAllUsers();

}
