package uni.miskolc.ips.ilona.tracking.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.exception.InvalidUserRegistration;
import uni.miskolc.ips.ilona.tracking.controller.model.UserCreationDTO;
import uni.miskolc.ips.ilona.tracking.controller.util.ValidateUserData;
import uni.miskolc.ips.ilona.tracking.controller.util.WebpageInformationProvider;
import uni.miskolc.ips.ilona.tracking.model.DeviceData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.service.UserAndDeviceService;
import uni.miskolc.ips.ilona.tracking.service.exceptions.DuplicatedUserException;
import uni.miskolc.ips.ilona.tracking.service.exceptions.ServiceGeneralErrorException;
import uni.miskolc.ips.ilona.tracking.util.TrackingModuleCentralManager;
import uni.miskolc.ips.ilona.tracking.util.validate.ValidityStatusHolder;

/*
* Content:
* 
* 0) dependencies
* 1) Entrypoint mapper
* 2) mainpage mappers
* 3) exception handlers
* 4) setters/getters
*/

/**
 * This controller is responsible for the main page requests in the ILONA
 * System. This class can:<br>
 * - load the main page navigation bar<br>
 * - load the main page home page<br>
 * - load the main page login page<br>
 * - load the main page registration page
 * 
 * @author Patrik / A5USL0
 *
 */
@Controller(value = "trackingEntryPointController")
@RequestMapping(value = "/tracking")
public class TrackingEntryPointController {

	private static Logger logger = LogManager.getLogger(TrackingEntryPointController.class);

	@Autowired
	private UserAndDeviceService userDeviceService;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private TrackingModuleCentralManager centralManager;

	/**
	 * This method sends back the actual tracking content.<br>
	 * <dl>
	 * <dt>If the user is not authenticated:</dt>
	 * <dd>- Sends back the start page of the tracking modul.</dd>
	 * <dd>- This page contains the login and the sign up functions.</dd>
	 * <dt>If the user is authenticated</dt>
	 * <dd>- Sends back the logged in user main page</dd>
	 * <dd>- If the user has the authority admin, the return page is the admin
	 * main page</dd>
	 * <dd>- If the user has the authority user, the return page is the user
	 * main page</dd>
	 * </dl>
	 * 
	 * @return The actual tracking content depends on the actual login status
	 *         and/or the actual authority of the current user.
	 */
	@RequestMapping(value = "/maincontentdecision", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView createTrackingContentpage(Authentication authentication) {
		/*
		 * 
		 * RETURN PAGE DEPENDS ON THE ACTUAL AUTHENTICATION! anonymousUser
		 */

		/*
		 * Get the actual authenticaton.
		 */
		authentication = SecurityContextHolder.getContext().getAuthentication();

		/*
		 * Check if the current user is anonymous user? Theoretically the
		 * authentication cannot be null.
		 */

		if (authentication == null) {
			logger.info("Anonymus authentication request!");
			return new ModelAndView("tracking/mainpageHome");
		}

		/*
		 * If the current user is not autthenticated (anonymus) the returned
		 * page will be the tracking login page.
		 */
		if (authentication != null) {
			logger.info("Anonymus authentication request!");

			for (GrantedAuthority role : authentication.getAuthorities()) {
				if (role.getAuthority().equals("ROLE_ANONYMOUS")) {
					return new ModelAndView("tracking/mainpageHome");
				}
			}
		}

		/**
		 * Chech for admin rights
		 */
		for (GrantedAuthority auth : authentication.getAuthorities()) {
			if (auth.getAuthority().equals("ROLE_ADMIN")) {
				logger.info("Admin page authentication request!" + authentication.getName());
				return new ModelAndView("tracking/admin/mainpage");
			}
		}

		/**
		 * Return user page
		 */
		return new ModelAndView("tracking/user/userMainpage");
	}

	/**
	 * This method sends back the login page for the tracking main page.
	 * 
	 * @return
	 * 
	 * @RequestMapping(value = "/login", method = { RequestMethod.GET,
	 *                       RequestMethod.POST }) public ModelAndView
	 *                       loadTrackingLoginpage() { ModelAndView loginpage =
	 *                       new ModelAndView("tracking/loginpage"); return
	 *                       loginpage; }
	 */

	@RequestMapping(value = "/getmainpagehome", method = { RequestMethod.POST })
	public ModelAndView generateMainpageHome() {
		return new ModelAndView("tracking/mainpageHome");
	}

	@RequestMapping(value = "/getmainpagesignup", method = { RequestMethod.POST })
	public ModelAndView generateMainpageSignup() {
		ModelAndView mav = new ModelAndView("tracking/mainpageSignup");

		mav.addObject("useridRestriction", WebpageInformationProvider.getUseridRestrictionMessage());
		mav.addObject("usernameRestriction", WebpageInformationProvider.getUsernameRestrictionMessage());
		mav.addObject("passwordRestriction", WebpageInformationProvider.getPasswordRestrictionMessage());
		mav.addObject("emailRestriction", WebpageInformationProvider.getEmailRestrictionMessage());

		mav.addObject("useridPattern", WebpageInformationProvider.getUseridpattern());
		mav.addObject("usernamePattern", WebpageInformationProvider.getUsernamepattern());
		mav.addObject("passwordPattern", WebpageInformationProvider.getPasswordpattern());

		return mav;
	}

	@RequestMapping(value = "/getloginpage", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView generateLoginpage(@RequestParam(value = "error", required = false) String error) {
		ModelAndView mav = new ModelAndView("tracking/loginpage");
		mav.addObject("error", error);
		return mav;
	}

	@RequestMapping(value = "/registeruser", method = { RequestMethod.POST })
	@ResponseBody
	public Collection<String> registerUser(@ModelAttribute(name = "user") UserCreationDTO user)
			throws InvalidUserRegistration {
		// ModelAndView mav = new ModelAndView("tracking/mainpageSignup");
		/*
		 * Validity check.
		 */
		ValidityStatusHolder errors = new ValidityStatusHolder();
		errors = ValidateUserData.validateUserid(user.getUserid());
		errors.appendValidityStatusHolder(ValidateUserData.validateUsername(user.getUsername()));
		errors.appendValidityStatusHolder(ValidateUserData.validateEmail(user.getEmail()));
		errors.appendValidityStatusHolder(ValidateUserData.validateRawPassword(user.getPassword()));

		/*
		 * Empty error/success holder.
		 */
		Collection<String> returnValues = new ArrayList<String>();

		if (errors.isValid()) {
			try {
				/*
				 * Password encoding.
				 */
				String encodedPassword = passwordEncoder.encode(user.getPassword());
				/*
				 * ROLES setup.
				 */
				ArrayList<String> roles = new ArrayList<String>();
				roles.add("ROLE_USER");

				/*
				 * Credentials validity setup.
				 */
				Date passwordExpired = new Date(new Date().getTime() + centralManager.getCredentialsValidityPeriod());

				/*
				 * Setup other still null fields.
				 */
				Collection<Date> badLogins = new ArrayList<Date>();
				Collection<DeviceData> devices = new ArrayList<DeviceData>();
				/*
				 * Create user with the given details. The account will be
				 * enabled and non locked and the last login date is the account
				 * creation time.
				 */
				UserData userDB = new UserData(user.getUserid(), user.getUsername(), user.getEmail(), encodedPassword,
						true, roles, new Date(), passwordExpired, new Date(), true, badLogins, devices);
				/*
				 * 
				 */
				this.userDeviceService.createUser(userDB);
			} catch (DuplicatedUserException e) {
				logger.error("Duplicated userid: " + user.getUserid() + "  Error: " + e.getMessage());
				returnValues.add("Duplicated user with this userid: " + user.getUserid());
				return returnValues;
			} catch (ServiceGeneralErrorException e) {
				logger.error("Error: " + e.getMessage());
				returnValues.add("There has been an error with the service, the account is not created!");
				return returnValues;
			} catch (Exception e) {
				logger.error("Error: " + e.getMessage());
				returnValues.add("There has been an error with the service, the account is not created!");
				return returnValues;
			}
		} else {
			logger.info("User creation failed with values " + user.toString());
			returnValues.addAll(errors.getErrors());
			return returnValues;
		}
		returnValues.add("The account has been successfully created!");
		return returnValues;
	}

	@RequestMapping(value = "/resetpassword", method = { RequestMethod.POST })
	@ResponseBody
	public String trackingResetPasswordHandler(@RequestParam(value = "userid", required = false) String userid) {
		//ModelAndView mav = new ModelAndView("tracking/passwordReset");
		if(userid == null) {
			return "Invalid userid!";
		}
		return "OK!";
	}

	@ExceptionHandler(value = { InvalidUserRegistration.class })
	public ModelAndView userRegistrationInvalidityHandler(Throwable error) {
		if (error instanceof InvalidUserRegistration) {
			InvalidUserRegistration invReg = (InvalidUserRegistration) error;
			ModelAndView mav = new ModelAndView("/tracking/mainpageSignup");
			mav.addObject("errors", invReg.getValidityErrors().getErrors());
			return mav;
		} else {
			return new ModelAndView("tracking/mainpageSignup");
		}
	}

	public void setUserDeviceService(UserAndDeviceService userDeviceService) {
		this.userDeviceService = userDeviceService;
	}

	public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}

	public void setCentralManager(TrackingModuleCentralManager centralManager) {
		this.centralManager = centralManager;
	}

}
