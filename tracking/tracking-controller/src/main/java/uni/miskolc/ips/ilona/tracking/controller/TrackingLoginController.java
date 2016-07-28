package uni.miskolc.ips.ilona.tracking.controller;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.HttpServletBean;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.exception.LoginpageInvalidLoginException;
import uni.miskolc.ips.ilona.tracking.model.UsernameAndPasswordLoginData;
import uni.miskolc.ips.ilona.tracking.util.validate.ValidateUsernameAndPasswordLoginData;
import uni.miskolc.ips.ilona.tracking.util.validate.ValidityStatusHolder;

@Controller
@RequestMapping(value = "/tracking")
public class TrackingLoginController {

	/**
	 * This method will authenticate the current user.<br>
	 * If the given user is present in the system:<br>
	 * This method will send back a web page depends on the maximum authority of
	 * the current user:<br>
	 * - admin page or user page<br>
	 * if the current user is not present in the system, the method will send
	 * back a login page.
	 * 
	 * @return
	 */
	@RequestMapping(value = "/baseAuthenticate", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView authenticateWithUsernameAndPasswordWithForm(
			@ModelAttribute(name = "logindata") UsernameAndPasswordLoginData logindata) {

		ValidityStatusHolder statusHolder = ValidateUsernameAndPasswordLoginData.ValidateLoginData(logindata);
		/*
		 * If the login is invalid
		 */
		if (statusHolder.isValid() == false) {

			throw new LoginpageInvalidLoginException("error message is invalid", statusHolder);

			//errorDiv.addObject("errors", statusHolder.getErrors());
			//return errorDiv;
		}
		/*
		 * if (logindata.getUserid().equals("bela")) { return new
		 * ModelAndView("tracking/adminMainpage"); }
		 */
		ModelAndView pageDecision = new ModelAndView();
		return new ModelAndView("tracking/adminMainpage");
	}
	
	@ExceptionHandler(LoginpageInvalidLoginException.class)
	@ResponseStatus(HttpStatus.EXPECTATION_FAILED)
	public ModelAndView hibaProba(LoginpageInvalidLoginException loginError) {
		ModelAndView errorPagePart = new ModelAndView("tracking/errorDisplayPagepart");
		errorPagePart.addObject("errors", loginError.getStatusHolder().getErrors());
		return errorPagePart;
	}
}
