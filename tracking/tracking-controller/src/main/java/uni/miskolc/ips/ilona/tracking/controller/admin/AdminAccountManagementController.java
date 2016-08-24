package uni.miskolc.ips.ilona.tracking.controller.admin;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.model.ExecutionResultDTO;
import uni.miskolc.ips.ilona.tracking.controller.model.UserBaseDetailsDTO;
import uni.miskolc.ips.ilona.tracking.controller.model.UserSecurityDetails;
import uni.miskolc.ips.ilona.tracking.controller.util.ValidateUserData;
import uni.miskolc.ips.ilona.tracking.controller.util.WebpageInformationProvider;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.service.UserAndDeviceService;
import uni.miskolc.ips.ilona.tracking.util.validate.ValidityStatusHolder;

@Controller
@RequestMapping(value = "/tracking/admin")
public class AdminAccountManagementController {

	@Resource(name = "UserAndDeviceService")
	private UserAndDeviceService userDeviceService;

	@Resource(name = "trackingPasswordEncoder")
	private PasswordEncoder passwordEncoder;

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
	@ResponseBody
	public ExecutionResultDTO changeAccountPasswordHandler(@ModelAttribute() UserBaseDetailsDTO user) {
		ExecutionResultDTO result = new ExecutionResultDTO(false, new ArrayList<String>());
		ValidityStatusHolder errors = new ValidityStatusHolder();

		if (user == null) {
			result.addMessage("User is null!");
			return result;
		}

		errors.appendValidityStatusHolder(ValidateUserData.validateRawPassword(user.getPassword()));
		errors.appendValidityStatusHolder(ValidateUserData.validateUserid(user.getUserid()));

		if (!errors.isValid()) {
			result.setMessages(errors.getErrors());
			return result;
		}

		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();

		if (!user.getUserid().equals(userDetails.getUserid())) {
			result.addMessage("Authorization constraint failed!");
			return result;
		}

		try {
			UserData userData = userDeviceService.getUser(user.getUserid());
			String hashedPassword = passwordEncoder.encode(user.getUserid());
			userData.setPassword(hashedPassword);
			userDeviceService.updateUser(userData);
		} catch (Exception e) {
			result.addMessage("Service error!");
			return result;
		}
		result.addMessage("Password modification is complete!");
		return result;
	}

	@RequestMapping(value = "/accountchangedetails", method = { RequestMethod.POST })
	@ResponseBody
	public ExecutionResultDTO changeAccountDetailsHandler(@ModelAttribute() UserBaseDetailsDTO user) {

		ExecutionResultDTO result = new ExecutionResultDTO(false, new ArrayList<String>());

		if (user == null) {
			result.addMessage("User is null!");
			return result;
		}

		ValidityStatusHolder errors = new ValidityStatusHolder();
		errors.appendValidityStatusHolder(ValidateUserData.validateUserid(user.getUserid()));
		errors.appendValidityStatusHolder(ValidateUserData.validateUsername(user.getUsername()));
		errors.appendValidityStatusHolder(ValidateUserData.validateEmail(user.getEmail()));

		if (!errors.isValid()) {
			result.setMessages(errors.getErrors());
			return result;
		}

		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();

		if (!userDetails.getUserid().equals(user.getUserid())) {
			result.addMessage("Authorization error!");
			return result;
		}

		try {
			UserData userData = userDeviceService.getUser(user.getUserid());
			userData.setEmail(user.getEmail());
			userData.setUsername(user.getUsername());
			userDeviceService.updateUser(userData);
		} catch (Exception e) {
			result.addMessage("Service error!");
			return result;
		}

		userDetails.setEmail(user.getEmail());
		userDetails.setUsername(user.getUsername());

		result.addMessage("Account has been updated!");
		return result;

	}

	public void setUserDeviceService(UserAndDeviceService userDeviceService) {
		this.userDeviceService = userDeviceService;
	}

	public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}

}
