package uni.miskolc.ips.ilona.tracking.persist.exception;

public class DatabaseProblemException extends TrackingDAOException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public DatabaseProblemException() {
		
	}
	
	public DatabaseProblemException(String message) {
		super(message);
	}
	
	public DatabaseProblemException(String message, Throwable exception) {
		super(exception, message);
	}

}
