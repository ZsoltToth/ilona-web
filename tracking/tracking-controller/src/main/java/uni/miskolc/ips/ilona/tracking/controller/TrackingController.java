package uni.miskolc.ips.ilona.tracking.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.model.UserDetails;
import uni.miskolc.ips.ilona.tracking.model.database.DatabaseUserDatas;
import uni.miskolc.ips.ilona.tracking.persist.TrackingUserManagementAndTrackingServiceDAO;
import uni.miskolc.ips.ilona.tracking.persist.TrackingUserDAO;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserNotFoundException;
import java.util.*;

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

	//@Autowired
	private TrackingUserDAO trackingUserDAO;
	
	@Autowired
	private TrackingUserManagementAndTrackingServiceDAO trackingdao;

	@Autowired
	BCryptPasswordEncoder passwordencoder;
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
		//mav.addObject("message", SecurityContextHolder.getContext().getAuthentication().getName());
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

	@RequestMapping(value = "/logindecision", method = { RequestMethod.POST })
	public ModelAndView trackingLoginDecisionHandler(@ModelAttribute("username") String username,
			@ModelAttribute("password") String password) {

		ModelAndView mav = new ModelAndView();
		mav.addObject("username", username);
		mav.addObject("userid", password);
		mav.setViewName("Tracking/UserMainPage");
		try {

			UserDetails userDetails = trackingUserDAO.getUser(username);
			if (userDetails != null) {
				for (String role : userDetails.getRoles()) {
					if (role.equalsIgnoreCase("ROLE_ADMIN")) {
						mav.setViewName("Tracking/AdminMainPage");
					}
				}
			}

		} catch (UserNotFoundException e) {

		}

		return mav;
	}

	@RequestMapping(value = "/login1", method = { RequestMethod.GET })
	public String createLoginPage() {
		return "Tracking/TrackingLoginPage";
	}
/*
	@RequestMapping(value = "/createuserpage", method = RequestMethod.GET)
	public ModelAndView createuserpage() {
		return new ModelAndView("CreateTrackingUser");
	}
*/
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
	@RequestMapping(value = "/createuser", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public List<UserDetails> userCreateProcess(@RequestParam(value = "roleadmin", required = false) String roleadmin,
			Model model, @ModelAttribute UserDetails user1) {
		System.out.println(user1.toString());
		System.out.println(roleadmin);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("Probalgatasok");
		List<UserDetails> userList = new ArrayList<UserDetails>();
		try {
			// trackingUserDAO.createUser(userdetails);
			userList = trackingUserDAO.getAllUsers();
			for (UserDetails user : userList) {
				System.out.println(user.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("error", "Nem sikerült létrehozni az adott felhasználót!");
		}
		return userList;
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
	@RequestMapping(value = "/probalgatasok", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView progaltasokToltese(@ModelAttribute("roleadmin") String roleadmin,
			@ModelAttribute("userid") String userid, Model model, HttpEntity<byte[]> httpEntity) {
		System.out.println(userid);
		System.out.println(httpEntity.getHeaders().toString());
		boolean isEqual = "áááé".equals(userid);
		System.out.println("\n Egyezes " + isEqual);
		model.addAttribute("kijelzes", userid);
		try {
			DatabaseUserDatas data = trackingdao.getUser("user1");
			if(data != null) {
				System.out.println(data.toString());
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("Probalgatasok");
	}

	public void setTrackingUserDAO(TrackingUserDAO trackingUserDAO) {
		this.trackingUserDAO = trackingUserDAO;
	}

	public void setPasswordencoder(BCryptPasswordEncoder passwordencoder) {
		this.passwordencoder = passwordencoder;
	}

	public void setTrackingdao(TrackingUserManagementAndTrackingServiceDAO trackingdao) {
		this.trackingdao = trackingdao;
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