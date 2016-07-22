package uni.miskolc.ips.ilona.tracking.persist;

import java.util.Collection;

import uni.miskolc.ips.ilona.tracking.model.TrackingLoginUserData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.exception.TrackingUserAlreadyExists;
import uni.miskolc.ips.ilona.tracking.persist.exception.TrackingUserNotFoundException;

/**
 * The common interface for user operations.
 * Create / 
 * @author Patrik
 *
 */
public interface TrackingUserDAO2 {

	
	/**
	 * 
	 * @param user 
	 * @exception TrackingUserAlreadyExists 
	 */
	public void createUser(UserData user) throws TrackingUserAlreadyExists;
	
	/**
	 * 
	 * @param userID
	 * @return
	 */
	public TrackingLoginUserData getUser(String userid) throws TrackingUserNotFoundException;
	
	/**
	 * 
	 * @param user
	 */	
	public void updateUser(UserData user) throws TrackingUserNotFoundException;
	
	/**
	 * 
	 * @param userID
	 */
	public void deleteUser(String userID) throws TrackingUserNotFoundException;
	
	/**
	 * 
	 * @return
	 */
	public Collection<String> getAllUsers();
	
}