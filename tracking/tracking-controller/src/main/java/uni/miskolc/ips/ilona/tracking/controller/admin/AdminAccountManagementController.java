package uni.miskolc.ips.ilona.tracking.controller.admin;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.model.UserBaseDetailsDTO;
import uni.miskolc.ips.ilona.tracking.controller.model.UserSecurityDetails;
import uni.miskolc.ips.ilona.tracking.controller.util.ValidateUserData;
import uni.miskolc.ips.ilona.tracking.controller.util.WebpageInformationProvider;
import uni.miskolc.ips.ilona.tracking.util.validate.ValidityStatusHolder;

@Controller
@RequestMapping(value = "/tracking/admin")
public class AdminAccountManagementController {

	@RequestMapping(value = "/accountmanagement", method = { RequestMethod.POST })
	public ModelAndView createAdminAccountManagementpage() {
		ModelAndView mav = new ModelAndView("tracking/admin/accountManagement");

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
		
		return mav;
	}

	@RequestMapping(value = "/accountchangepassword", method = { RequestMethod.POST })
	public ModelAndView changeAccountPasswordHandler(@ModelAttribute() UserBaseDetailsDTO user) {
		ModelAndView mav = new ModelAndView("tracking/admin/accountManagement");

		ValidityStatusHolder errors = new ValidityStatusHolder();
		errors.appendValidityStatusHolder(ValidateUserData.validateRawPassword(user.getPassword()));

		if (errors.isValid()) {
			mav.addObject("passwordErrors", "A jelszó feldolgozása megtörtént!");
		} else {
			mav.addObject("passwordErrors", errors.getErrors());
		}

		return mav;
	}

	@RequestMapping(value = "/accountchangedetails", method = { RequestMethod.POST })
	public ModelAndView changeAccountDetailsHandler(@ModelAttribute() UserBaseDetailsDTO user) {
		ModelAndView mav = new ModelAndView("tracking/admin/accountManagement");

		ValidityStatusHolder errors = new ValidityStatusHolder();
		errors.appendValidityStatusHolder(ValidateUserData.validateUsername(user.getUsername()));
		errors.appendValidityStatusHolder(ValidateUserData.validateEmail(user.getEmail()));

		if (errors.isValid()) {
			mav.addObject("successfulModification", "Account modification was successful!");
		} else {
			mav.addObject("changeDetailsErrors", errors.getErrors());
		}
		
		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();

		mav.addObject("useridValue", userDetails.getUserid());
		mav.addObject("usernameValue", userDetails.getUsername());
		mav.addObject("emailValue", userDetails.getEmail());
		
		return mav;
	}
}
