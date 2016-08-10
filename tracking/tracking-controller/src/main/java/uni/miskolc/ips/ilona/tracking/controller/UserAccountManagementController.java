package uni.miskolc.ips.ilona.tracking.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.model.UserBaseDetailsDTO;
import uni.miskolc.ips.ilona.tracking.controller.model.UserSecurityDetails;
import uni.miskolc.ips.ilona.tracking.controller.util.ValidateUserData;
import uni.miskolc.ips.ilona.tracking.controller.util.WebpageInformationProvider;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.UserAndDeviceDAO;
import uni.miskolc.ips.ilona.tracking.util.validate.ValidityStatusHolder;

@Controller
@RequestMapping(value = "/tracking/user")
public class UserAccountManagementController {

	@Autowired
	private UserAndDeviceDAO userDeviceDAO;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@RequestMapping(value = "/homepage", method = { RequestMethod.POST })
	public ModelAndView createUserMainpageHandler() {
		ModelAndView mav = new ModelAndView("tracking/user/userMainpage");

		return mav;
	}

	@RequestMapping(value = "/accountmanagement", method = { RequestMethod.POST })
	public ModelAndView createAccountManagementHandler() {
		ModelAndView mav = new ModelAndView("tracking/user/accountManagement");
		fillModelAndViewPageDetails(mav);
		return mav;
	}

	@RequestMapping(value = "/accmanchangeuserdetails", method = { RequestMethod.POST })
	public ModelAndView changerUserDetailsHandler(@ModelAttribute() UserBaseDetailsDTO newUserDetails) {
		ModelAndView mav = new ModelAndView("tracking/user/accountManagement");

		if (newUserDetails == null) {
			fillModelAndViewPageDetails(mav);
			mav.addObject("userDetailsChangeError", "Error occured!");
			return mav;
		}

		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();

		if (newUserDetails.getUserid() == null || !newUserDetails.getUserid().equals(userDetails.getUserid())) {
			fillModelAndViewPageDetails(mav);
			mav.addObject("userDetailsChangeError", "Error occured!");
			return mav;
		}

		/*
		 * Validation
		 */

		ValidityStatusHolder errors = new ValidityStatusHolder();
		errors.appendValidityStatusHolder(ValidateUserData.validateUsername(newUserDetails.getUsername()));
		errors.appendValidityStatusHolder(ValidateUserData.validateEmail(newUserDetails.getEmail()));

		if (!errors.isValid()) {
			fillModelAndViewPageDetails(mav);
			mav.addObject("changeDetailsErrors", errors.getErrors());
			return mav;
		}

		/*
		 * Update User data
		 */
		try {
			UserData updatedUserDetails = userDeviceDAO.getUser(newUserDetails.getUserid());
			updatedUserDetails.setUsername(newUserDetails.getUsername());
			updatedUserDetails.setEmail(newUserDetails.getEmail());
			userDeviceDAO.updateUser(updatedUserDetails);

		} catch (Exception e) {
			fillModelAndViewPageDetails(mav);
			mav.addObject("changeDetailsErrors", "UserDatase error, update failed!");
			return mav;
		}

		/*
		 * Update principal
		 */
		userDetails.setEmail(newUserDetails.getEmail());
		userDetails.setUsername(newUserDetails.getUsername());

		/*
		 * Account management page with updated details
		 */
		fillModelAndViewPageDetails(mav);
		mav.addObject("successfulDetailsModification", "The update was successful!");

		return mav;
	}

	@RequestMapping(value = "/accmanchangepassword", method = { RequestMethod.POST })
	public ModelAndView changeUserPasswordHandler(@ModelAttribute() UserBaseDetailsDTO user) {
		ModelAndView mav = new ModelAndView("tracking/user/accountManagement");
		
		if (user == null) {
			fillModelAndViewPageDetails(mav);
			mav.addObject("userDetailsChangeError", "Error occured!");
			return mav;
		}
		
		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();

		if (user.getUserid() == null || !user.getUserid().equals(userDetails.getUserid())) {
			fillModelAndViewPageDetails(mav);
			mav.addObject("userDetailsChangeError", "Error occured!");
			return mav;
		}
		
		ValidityStatusHolder errors = new ValidityStatusHolder();
		errors.appendValidityStatusHolder(ValidateUserData.validateRawPassword(user.getPassword()));
		
		if(!errors.isValid()) {
			fillModelAndViewPageDetails(mav);
			mav.addObject("passwordErrors", errors.getErrors());
			return mav;
		}
		
		String hashedPassword = null;
		try {
			UserData updatedUserDetails = userDeviceDAO.getUser(user.getUserid());
			hashedPassword = passwordEncoder.encode(user.getPassword());
			updatedUserDetails.setPassword(hashedPassword);
			userDeviceDAO.updateUser(updatedUserDetails);
		} catch (Exception e) {
			fillModelAndViewPageDetails(mav);
			mav.addObject("changeDetailsErrors", "UserDatase error, update failed!");
			return mav;
		}
		
		/*
		 * Update principal
		 */
		userDetails.setPassword(hashedPassword);

		/*
		 * Account management page with updated details
		 */
		fillModelAndViewPageDetails(mav);
		mav.addObject("successfulPasswordModification", "The update was successful!");
		
		return mav;
	}

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

	public void setUserDeviceDAO(UserAndDeviceDAO userDeviceDAO) {
		this.userDeviceDAO = userDeviceDAO;
	}

	public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}

}
