package uni.miskolc.ips.ilona.tracking.persist.exception;

public class UserNotFoundException extends TrackingDAOException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -712157348319823447L;

	public UserNotFoundException() {
		
	}
	
	public UserNotFoundException(String message) {
		super(message);
	}
	
	public UserNotFoundException(String message, Throwable exception) {
		super(exception, message);
	}
}
