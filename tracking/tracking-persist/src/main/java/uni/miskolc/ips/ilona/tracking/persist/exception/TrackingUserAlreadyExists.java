package uni.miskolc.ips.ilona.tracking.persist.exception;

public class TrackingUserAlreadyExists extends TrackingDAOException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -9204254472889191153L;

	public TrackingUserAlreadyExists() {
		
	}
	
	public TrackingUserAlreadyExists(String message) {
		super(message);
	}
	
	public TrackingUserAlreadyExists(String message, Throwable exception) {
		super(exception, message);
	}
}
