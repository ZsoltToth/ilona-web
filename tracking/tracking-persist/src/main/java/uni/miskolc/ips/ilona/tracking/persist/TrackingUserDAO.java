package uni.miskolc.ips.ilona.tracking.persist;

import java.util.Collection;
import java.util.List;

import uni.miskolc.ips.ilona.tracking.model.TrackingLoginUserData;
import uni.miskolc.ips.ilona.tracking.model.UserDetails;
import uni.miskolc.ips.ilona.tracking.persist.exception.TrackingUserAlreadyExists;
import uni.miskolc.ips.ilona.tracking.persist.exception.TrackingUserNotFoundException;

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
	public void createUser(UserDetails user) throws TrackingUserAlreadyExists;

	/**
	 * 
	 * @param userID
	 * @return
	 */
	public UserDetails getUser(String userid) throws TrackingUserNotFoundException;

	/**
	 * 
	 * @param user
	 */
	public void updateUser(UserDetails user) throws TrackingUserNotFoundException;

	/**
	 * 
	 * @param userID
	 */
	public void deleteUser(String userID) throws TrackingUserNotFoundException;

	/**
	 * 
	 * @return
	 */
	public List<UserDetails> getAllUsers();

}
