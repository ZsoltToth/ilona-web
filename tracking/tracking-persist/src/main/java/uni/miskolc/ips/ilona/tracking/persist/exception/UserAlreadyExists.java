package uni.miskolc.ips.ilona.tracking.persist.exception;

public class UserAlreadyExists extends TrackingDAOException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9204254472889191153L;

	public UserAlreadyExists() {
		
	}
	
	public UserAlreadyExists(String message) {
		super(message);
	}
	
	public UserAlreadyExists(String message, Throwable exception) {
		super(exception, message);
	}
}
