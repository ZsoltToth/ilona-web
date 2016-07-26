package uni.miskolc.ips.ilona.tracking.model;

/**
 * 
 * @author Patrik / A5USL0
 * 
 */
public class TrackingUserDAO {

	/**
	 * The user identification string. This is the primary key in the table.
	 * Must be different for each user.
	 */
	private String userid;

	private String username;

	/**
	 * 
	 */
	private String password;

	/**
	 * 
	 */
	private String email;

	/**
	 * 
	 */
	private boolean enabled;

	/**
	 * 
	 */
	private boolean accountNonExpired;

	/**
	 * 
	 */
	private boolean accountNonLocked;

	/**
	 * 
	 */
	private boolean credentialsNonExpired;

}
