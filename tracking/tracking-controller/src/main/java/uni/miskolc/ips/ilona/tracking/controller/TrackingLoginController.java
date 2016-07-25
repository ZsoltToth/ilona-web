package uni.miskolc.ips.ilona.tracking.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.model.UsernameAndPasswordLoginData;

@Controller
@RequestMapping(value = "/tracking")
public class TrackingLoginController {

	/**
	 * This method will authenticate the current user.<br>
	 * If the given user is present in the system:<br>
	 * This method will send back a web page depends on the maximum authority of the current user:<br>
	 * - admin page or user page<br>
	 * if the current user is not present in the system, the method will send back a login page.
	 * @return
	 */
	@RequestMapping(value = "/baseAuthenticate", method = {RequestMethod.GET})
	public ModelAndView authenticateWithUsernameAndPasswordWithForm(@ModelAttribute() UsernameAndPasswordLoginData logindata) {
		if (logindata.getUserid().equals("bela")) {
			return new ModelAndView("tracking/adminMainpage");
		}
		ModelAndView pageDecision = new ModelAndView();
		return new ModelAndView("tracking/loginpage");
	}
}
