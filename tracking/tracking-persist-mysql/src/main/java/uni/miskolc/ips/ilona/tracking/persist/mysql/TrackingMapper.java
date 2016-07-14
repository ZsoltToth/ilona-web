package uni.miskolc.ips.ilona.tracking.persist.mysql;

import uni.miskolc.ips.ilona.tracking.model.TrackingLoginUserData;
import uni.miskolc.ips.ilona.tracking.model.UserData;

public interface TrackingMapper {

	public void createUser(UserData user);

	public TrackingLoginUserData getUser(String userID);

	public void updateUser(UserData user);

	public void deleteUser(String userID);
}