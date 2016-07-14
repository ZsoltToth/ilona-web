package uni.miskolc.ips.ilona.tracking.persist;

import uni.miskolc.ips.ilona.tracking.model.TrackingLoginUserData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.exception.TrackingUserAlreadyExists;
import uni.miskolc.ips.ilona.tracking.persist.exception.TrackingUserNotFoundException;

/**
 * 
 * @author Patrik
 *
 */
public interface TrackingDAO {

	
	/**
	 * 
	 * @param user
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
	
}