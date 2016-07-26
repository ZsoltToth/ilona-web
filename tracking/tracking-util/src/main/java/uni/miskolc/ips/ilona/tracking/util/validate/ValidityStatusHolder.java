package uni.miskolc.ips.ilona.tracking.util.validate;

import java.util.LinkedList;
import java.util.List;

/**
 * THIS CLASS IS NO THREADSAFE!
 * 
 * @author Patrik / A5USL0
 *
 */
public class ValidityStatusHolder {

	private List<String> errors;

	public ValidityStatusHolder() {
		errors = new LinkedList<String>();
	}

	public boolean isValid() {
		if (errors.size() == 0) {
			return true;
		} else {
			return false;
		}

	}

	public void appendValidityStatusHolder(ValidityStatusHolder statusHolder) {
		if (statusHolder == null) {
			return;
		}

		List<String> externalErrors = statusHolder.getErrors();
		if (externalErrors == null) {
			return;
		}

		for (String error : externalErrors) {
			errors.add(error);
		}
	}

	public void addValidityError(String validityError) {
		errors.add(validityError);
	}

	public String getErrorsAsString() {
		StringBuilder builder = new StringBuilder();
		for (String error : errors) {
			builder.append(error);
		}
		return builder.toString();
	}

	public List<String> getErrors() {
		return errors;
	}
}
