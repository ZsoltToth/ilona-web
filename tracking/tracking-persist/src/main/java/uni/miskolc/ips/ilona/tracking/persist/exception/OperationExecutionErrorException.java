package uni.miskolc.ips.ilona.tracking.persist.exception;

public class OperationExecutionErrorException extends TrackingDAOException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public OperationExecutionErrorException() {
		
	}
	
	public OperationExecutionErrorException(String message) {
		super(message);
	}

	public OperationExecutionErrorException(String message, Throwable exception) {
		super(exception, message);
	}
}
