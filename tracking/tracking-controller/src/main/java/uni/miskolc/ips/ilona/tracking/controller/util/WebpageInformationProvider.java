package uni.miskolc.ips.ilona.tracking.controller.util;

public class WebpageInformationProvider {

	/*
	 * Titles
	 */
	
	private static final String useridTitle = "The userid can contain the following characters:";
	
	private static final String usernameTitle = "The username can contain the following characters:";
	
	private static final String passwordTitle = "The password can contain the following characters:";
	
	
	/*
	 * Restrictions
	 */

	private static final String useridRestrictionMessage = "<b>The userid maximum length is 20 characters!</b><br><br><b>"
			+ "The minimum length is 5 characters!</b><br><br>The userid can contaion letters from the english alphabet,"
			+ "any other letters are restricted like é á ő ű ú ö ü ó<br><br>The userid must <b>start with</b>"
			+ "a letter <b>a-z or A-Z</b> <br><br> after that can contain the following letters: a-z, A-Z, 0-9"
			+ "<br><br> The userid cannot contain any special characters like ? : - ! %";

	private static final String usernameRestrictionMessage = "<b>The username maximum length is 30 characters!"
			+ "</b><br><br><b>The minimum length is 5 characters!</b><br><br>"
			+ "The username can contain any english alphabet letters and these letters:<br><br>  öüóőúéáű and ÖÜÓŐÚŰÁÉ";

	private static final String passwordRestrictionMessage = "<b>The password maximum length is 30 characters!"
			+ "</b><br><br><b>The minimum length is 6 characters!</b>";

	private static final String emailRestrictionMessage = "The email address must be a valid address!";

	private static final String enabledCreationMessage = "If true, then the user will be enabled!";

	private static final String UserRoleCreationMessage = "If true, then the user will be admin!";

	/*
	 * Field patterns!
	 */

	private static final String useridPattern = "^[a-zA-Z][a-zA-Z0-9]{4,19}$";

	private static final String usernamePattern = "^[a-zA-ZöüóőúéáűÖÜÓŐÚŰÁÉ][a-zA-ZöüóőúéáűÖÜÓŐÚŰÁÉ0-9]{4,30}$";

	private static final String passwordPattern = "^.{5,30}$";

	private static final String emailPattern = null; // This value is restrited
														// by the default
														// pattern?!

	public static String getUseridRestrictionMessage() {
		return useridRestrictionMessage;
	}

	public static String getUsernameRestrictionMessage() {
		return usernameRestrictionMessage;
	}

	public static String getPasswordRestrictionMessage() {
		return passwordRestrictionMessage;
	}

	public static String getEmailRestrictionMessage() {
		return emailRestrictionMessage;
	}

	public static String getEnabledcreationmessage() {
		return enabledCreationMessage;
	}

	public static String getUserrolecreationmessage() {
		return UserRoleCreationMessage;
	}

	public static String getUseridpattern() {
		return useridPattern;
	}

	public static String getUsernamepattern() {
		return usernamePattern;
	}

	public static String getPasswordpattern() {
		return passwordPattern;
	}

}
