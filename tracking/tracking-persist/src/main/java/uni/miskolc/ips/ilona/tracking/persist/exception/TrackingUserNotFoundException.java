package uni.miskolc.ips.ilona.tracking.persist.exception;

public class TrackingUserNotFoundException extends TrackingDAOException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -712157348319823447L;

	public TrackingUserNotFoundException() {
		
	}
	
	public TrackingUserNotFoundException(String message) {
		super(message);
	}
	
	public TrackingUserNotFoundException(String message, Throwable exception) {
		super(exception, message);
	}
}
