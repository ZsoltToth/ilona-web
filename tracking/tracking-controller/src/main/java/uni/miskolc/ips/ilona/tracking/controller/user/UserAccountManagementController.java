package uni.miskolc.ips.ilona.tracking.controller.user;

import java.util.ArrayList;
import java.util.Collection;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.exception.UserChangeDetailsExecutionException;
import uni.miskolc.ips.ilona.tracking.controller.model.UserBaseDetailsDTO;
import uni.miskolc.ips.ilona.tracking.controller.model.UserSecurityDetails;
import uni.miskolc.ips.ilona.tracking.controller.util.ValidateUserData;
import uni.miskolc.ips.ilona.tracking.controller.util.WebpageInformationProvider;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.service.UserAndDeviceService;
import uni.miskolc.ips.ilona.tracking.util.validate.ValidityStatusHolder;

@Controller
@RequestMapping(value = "/tracking/user")
public class UserAccountManagementController {

	@Resource(name = "UserAndDeviceService")
	private UserAndDeviceService userDeviceService;

	@Resource(name = "trackingPasswordEncoder")
	private PasswordEncoder passwordEncoder;

	@RequestMapping(value = "/accountmanagement", method = { RequestMethod.POST })
	public ModelAndView createAccountManagementHandler() {
		ModelAndView mav = new ModelAndView("tracking/user/accountManagement");
		fillModelAndViewPageDetails(mav);
		return mav;
	}

	@RequestMapping(value = "/accountmanagement/changeuserdetails", method = { RequestMethod.POST })
	@ResponseBody
	public UserBaseDetailsDTO changerUserDetailsHandler(@ModelAttribute() UserBaseDetailsDTO newUserDetails)
			throws UserChangeDetailsExecutionException {

		ValidityStatusHolder errors = new ValidityStatusHolder();

		/*
		 * Request null check
		 */
		if (newUserDetails == null) {
			errors.addValidityError("The account is null!");
			throw new UserChangeDetailsExecutionException("The account is null!", errors);
		}

		/*
		 * Logged in user details
		 */
		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();

		/*
		 * The user only can't change other users data.
		 */
		if (newUserDetails.getUserid() == null || !newUserDetails.getUserid().equals(userDetails.getUserid())) {
			errors.addValidityError("Account authorization requirements failed!");
			throw new UserChangeDetailsExecutionException("Account authorization requirements failed!", errors);
		}

		/*
		 * Validation
		 */

		errors.appendValidityStatusHolder(ValidateUserData.validateUsername(newUserDetails.getUsername()));
		errors.appendValidityStatusHolder(ValidateUserData.validateEmail(newUserDetails.getEmail()));

		if (!errors.isValid()) {
			throw new UserChangeDetailsExecutionException("Account validity error!", errors);
		}

		/*
		 * Update User data
		 */
		try {
			UserData updatedUserDetails = userDeviceService.getUser(newUserDetails.getUserid());
			updatedUserDetails.setUsername(newUserDetails.getUsername());
			updatedUserDetails.setEmail(newUserDetails.getEmail());
			userDeviceService.updateUser(updatedUserDetails);

		} catch (Exception e) {
			errors.addValidityError("Tracking service error!");
			throw new UserChangeDetailsExecutionException("Tracking service error!", errors);
		}

		/*
		 * Update principal
		 */
		userDetails.setEmail(newUserDetails.getEmail());
		userDetails.setUsername(newUserDetails.getUsername());

		/*
		 * Return with the updated data.
		 */

		return newUserDetails;

	}

	@RequestMapping(value = "/accountmanagement/changepassword", method = { RequestMethod.POST })
	@ResponseBody
	public Collection<String> changeUserPasswordHandler(@ModelAttribute() UserBaseDetailsDTO user) {

		Collection<String> errors = new ArrayList<String>();
		if (user == null) {
			errors.add("Account error!");
			return errors;
		}

		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();

		if (user.getUserid() == null || !user.getUserid().equals(userDetails.getUserid())) {
			errors.add("User authorization error!");
			return errors;
		}

		ValidityStatusHolder valErrors = new ValidityStatusHolder();
		valErrors.appendValidityStatusHolder(ValidateUserData.validateRawPassword(user.getPassword()));

		if (!valErrors.isValid()) {
			return valErrors.getErrors();
		}

		String hashedPassword = null;
		try {
			UserData updatedUserDetails = userDeviceService.getUser(user.getUserid());
			hashedPassword = passwordEncoder.encode(user.getPassword());
			updatedUserDetails.setPassword(hashedPassword);
			userDeviceService.updateUser(updatedUserDetails);
		} catch (Exception e) {
			errors.add("Tracking serice error!");
			return errors;
		}

		/*
		 * Update principal
		 */
		userDetails.setPassword(hashedPassword);

		/*
		 * Account management page with updated details
		 */
		errors.add("The update was successful!");

		return errors;
	}

	/**
	 * 
	 * @param mav
	 */
	private void fillModelAndViewPageDetails(ModelAndView mav) {

		mav.addObject("useridRestriction", WebpageInformationProvider.getUseridRestrictionMessage());
		mav.addObject("usernameRestriction", WebpageInformationProvider.getUsernameRestrictionMessage());
		mav.addObject("passwordRestriction", WebpageInformationProvider.getPasswordRestrictionMessage());
		mav.addObject("emailRestriction", WebpageInformationProvider.getEmailRestrictionMessage());
		mav.addObject("enabledRestriction", WebpageInformationProvider.getEnabledcreationmessage());
		mav.addObject("userRoleRestriction", WebpageInformationProvider.getUserrolecreationmessage());

		mav.addObject("useridPattern", WebpageInformationProvider.getUseridpattern());
		mav.addObject("usernamePattern", WebpageInformationProvider.getUsernamepattern());
		mav.addObject("passwordPattern", WebpageInformationProvider.getPasswordpattern());

		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();

		mav.addObject("useridValue", userDetails.getUserid());
		mav.addObject("usernameValue", userDetails.getUsername());
		mav.addObject("emailValue", userDetails.getEmail());

	}

	@ExceptionHandler(UserChangeDetailsExecutionException.class)
	@ResponseBody
	@ResponseStatus(code = HttpStatus.BAD_REQUEST)
	public Collection<String> UserDetailsChangeErrorsHandler(UserChangeDetailsExecutionException error) {

		return error.getValidityErrors().getErrors();
	}

	public void setUserDeviceService(UserAndDeviceService userDeviceService) {
		this.userDeviceService = userDeviceService;
	}

	public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}

}
