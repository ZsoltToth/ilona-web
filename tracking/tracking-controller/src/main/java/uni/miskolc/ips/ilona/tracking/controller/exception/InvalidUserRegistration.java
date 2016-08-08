package uni.miskolc.ips.ilona.tracking.controller.exception;

import uni.miskolc.ips.ilona.tracking.util.validate.ValidityStatusHolder;

public class InvalidUserRegistration extends EntryPointException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private ValidityStatusHolder validityErrors;

	public InvalidUserRegistration() {
		super();
	}

	public InvalidUserRegistration(String message) {
		super(message);
	}

	public InvalidUserRegistration(Throwable cause) {
		super(cause);
	}

	public InvalidUserRegistration(String message, ValidityStatusHolder validityErrors) {
		super(message);
		this.validityErrors = validityErrors;
	}

	public InvalidUserRegistration(String message, Throwable cause) {
		super(message, cause);
	}

	public InvalidUserRegistration(String message, Throwable cause, ValidityStatusHolder validityErrors) {
		super(message, cause);
		this.validityErrors = validityErrors;
	}

	public ValidityStatusHolder getValidityErrors() {
		return validityErrors;
	}
	
	
}