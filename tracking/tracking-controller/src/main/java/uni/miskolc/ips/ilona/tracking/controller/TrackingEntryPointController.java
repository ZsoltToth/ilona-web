package uni.miskolc.ips.ilona.tracking.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
	@RequestMapping(value = "/maincontentdecision", method = { RequestMethod.GET })
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
			logger.error("Anonymus authentication request!");
			return new ModelAndView("tracking/mainpageHome");
		}

		/*
		 * If the current user is not autthenticated (anonymus) the returned
		 * page will be the tracking login page.
		 */
		if (authentication != null) {
			logger.error("Anonymus authentication request!");
			if (authentication.getName().equalsIgnoreCase("anonymousUser")) {
				return new ModelAndView("tracking/mainpageHome");
			}
		}

		/**
		 * Chech for admin rights
		 */
		for (GrantedAuthority auth : authentication.getAuthorities()) {
			if (auth.getAuthority().equals("ROLE_ADMIN")) {
				logger.error("Admin page authentication request!" + authentication.getName());
				return new ModelAndView("tracking/admin/adminMainpage");
			}
		}

		return new ModelAndView("tracking/user/userMainpage");
	}

	/**
	 * This method sends back the login page for the tracking main page.
	 * 
	 * @return
	 */
	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView loadTrackingLoginpage() {
		ModelAndView loginpage = new ModelAndView("tracking/loginpage");
		return loginpage;
	}

	@RequestMapping(value = "/getmainpagehome", method = { RequestMethod.POST })
	public ModelAndView generateMainpageHome() {
		return new ModelAndView("tracking/mainpageHome");
	}

	@RequestMapping(value = "/getmainpagesignup", method = { RequestMethod.POST } )
	public ModelAndView generateMainpageSignup() {
		return new ModelAndView("tracking/mainpageSignup");
	}

	@RequestMapping(value = "/getloginpage", method = { RequestMethod.POST })
	public ModelAndView generateLoginpage() {
		return new ModelAndView("tracking/loginpage");
	}
}
