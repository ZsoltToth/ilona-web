package uni.miskolc.ips.ilona.tracking.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * This controller is responsible for the main page requests in the ILONA System.
 * This class can:<br>
 * - load the main page navigation bar<br>
 * - load the main page home page<br>
 * - load the main page login page<br>
 * - load the main page registration page
 * @author Patrik / A5USL0
 *
 */
@Controller
@RequestMapping(value="/tracking")
public class TrackingPageController {

	/**
	 * This method sends back the main page navigation bar with the default content.
	 * @return The main page of the tracking subsystem of ILONA.
	 */
	@RequestMapping(value = "/mainpage", method = {RequestMethod.GET})
	public ModelAndView createTrackingMainpage() {
		ModelAndView mainpage = new ModelAndView();
		mainpage.setViewName("tracking/mainpage");
		return mainpage;
	}
	
	/**
	 * This method sends back the login page for the tracking main page.
	 * @return
	 */
	@RequestMapping(value = "login", method = {RequestMethod.GET})
	public ModelAndView loadTrackingLoginpage() {
		ModelAndView loginpage = new ModelAndView();
		loginpage.setViewName("tracking/loginpage");
		return loginpage;
	}
}
