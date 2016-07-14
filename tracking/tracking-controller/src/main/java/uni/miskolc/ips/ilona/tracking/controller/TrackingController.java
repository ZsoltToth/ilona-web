package uni.miskolc.ips.ilona.tracking.controller;

import java.awt.PageAttributes.MediaType;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.model.TrackingLoginUserData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.model.Usermodel;
import uni.miskolc.ips.ilona.tracking.service.TrackingLoginService;
import uni.miskolc.ips.ilona.tracking.service.exceptions.DatabaseUnavailableException;
import uni.miskolc.ips.ilona.tracking.service.exceptions.DuplicatedUserException;
import uni.miskolc.ips.ilona.tracking.service.exceptions.InvalidDataException;
import uni.miskolc.ips.ilona.tracking.service.exceptions.NoSuchUserException;
import uni.miskolc.ips.ilona.tracking.service.exceptions.UnenabledUserException;

/**
 * Tracking module
 * 
 * @author Patrik
 *
 */
@Controller
@RequestMapping(value = "/tracking")
public class TrackingController {

	private static Logger logger = LogManager.getLogger(TrackingController.class);

	// @Autowired
	// private TrackingLoginService trackingLoginService;

	/**
	 * This method gives back the index page of the tracking modul. Login or
	 * registration.
	 * 
	 * @return The tracking index jsp page.
	 */
	@RequestMapping(value = "/index", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView loadingStartpage() {
		logger.info("Tracking index page request.");
		// ModelAndView back = new ModelAndView("trackingIndex");
		ModelAndView mav = new ModelAndView();
		mav.addObject("message", SecurityContextHolder.getContext().getAuthentication().getName());
		// back.addObject("message", "Üzenetátadva!");
		mav.setViewName("trackingIndex");
		return mav;
	}

	/**
	 * This method gives back the registration page. New user registration.
	 * 
	 * @return
	 */
	@RequestMapping(value = "/registration", method = RequestMethod.GET)
	public ModelAndView loadLoginPage() {
		logger.info("Tracking login page request.");
		ModelAndView mav = new ModelAndView("trackingRegistration");
		mav.addObject("message", "");
		return mav;
	}

	/**
	 * MAjd lesz itt valamit komment.. .valamikor... esetleg
	 * 
	 * @return
	 */
	@RequestMapping(value = "/main", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView loginProcess() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("authenticated", SecurityContextHolder.getContext().getAuthentication().getName());
		mav.addObject("rolenumber", SecurityContextHolder.getContext().getAuthentication().getAuthorities().size());
		return new ModelAndView("trackingMainpage");
	}

	@RequestMapping(value = "/createuserpage", method = RequestMethod.GET)
	public ModelAndView createuserpage() {
		return new ModelAndView("CreateTrackingUser");
	}

	/*
	 * @RequestMapping(value = "/createuser/{username}/{password}/{enabled}",
	 * method = { RequestMethod.POST }) public ModelAndView
	 * userCreateProcess(@RequestParam(value = "username", required=false)
	 * String username,
	 * 
	 * @RequestParam(value = "password") String password, @RequestParam(value =
	 * "enabled") boolean enabled) { System.out.println("user: " + username +
	 * "  password: " + password + "  enabled:" + enabled); return new
	 * ModelAndView(""); }
	 */

	@RequestMapping(value = "/createuser", method = { RequestMethod.POST,
			RequestMethod.GET }, consumes = org.springframework.http.MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView userCreateProcess(@RequestBody Usermodel userdata) {
		return new ModelAndView("");
	}

	@RequestMapping(value = "/logout", method = { RequestMethod.GET, RequestMethod.POST })
	public String logoutHandler() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("trackingIndex");
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) {
			mav.addObject("message", auth.getPrincipal().toString());
		} else {
			mav.addObject("message", "Nincs felhasznalo!");
		}
		mav.addObject("message", auth.getPrincipal().toString());
		return "redirect:/tracking/index";
	}

	/**
	 * CSAK PRÓBÁLGATÁSRA!!!
	 * 
	 * @return
	 */
	@RequestMapping(value = "/probalgatasok", method = RequestMethod.GET)
	public ModelAndView progaltasokToltese() {
		return new ModelAndView("Probalgatasok");
	}
	/*
	 * @RequestMapping(value = "/getUser/{userID}", method = RequestMethod.GET)
	 * 
	 * @ResponseBody public UserData getUser(@RequestParam(value="userID",
	 * required=true)String userID) { UserData data = null;
	 * 
	 * try { trackingLoginService.getUser(userID); } catch
	 * (DatabaseUnavailableException e) {
	 * 
	 * e.printStackTrace(); } catch (NoSuchUserException e) {
	 * 
	 * e.printStackTrace(); } catch (UnenabledUserException e) {
	 * 
	 * e.printStackTrace(); } return data; }
	 * 
	 * @RequestMapping(value = "/createUser", method = RequestMethod.POST)
	 * public ModelAndView createUser(@RequestBody(required = true) UserData
	 * userData) { ModelAndView mav = null; try {
	 * trackingLoginService.createUser(userData); } catch
	 * (DatabaseUnavailableException e) { mav = new
	 * ModelAndView("tracking_registration"); mav.addObject("message",
	 * "Az adatbazis nem elerheto!"); return mav; //e.printStackTrace(); } catch
	 * (InvalidDataException e) { mav = new
	 * ModelAndView("tracking_registration"); mav.addObject("message",
	 * "Hibas adat(ok)!"); return mav; //e.printStackTrace(); } catch
	 * (DuplicatedUserException e) { mav = new
	 * ModelAndView("tracking_registration"); mav.addObject("message",
	 * "Mar van ilyen felhasznalo!"); return mav; //e.printStackTrace(); } //
	 * after successful registration tracking main page? mav = new
	 * ModelAndView("tracking_index"); mav.addObject("message",
	 * "Sikeres regisztracio"); return mav; }
	 */

}