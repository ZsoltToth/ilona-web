package uni.miskolc.ips.ilona.tracking.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.model.UserDetails;
import uni.miskolc.ips.ilona.tracking.persist.TrackingUserDAO;

/**
 * 
 * @author Patrik / A5USL0
 *
 */
@Controller
@RequestMapping(value = "/tracking")
public class TrackingAdminpageController {

	@Autowired
	TrackingUserDAO trackingUserDAO;
	
	@RequestMapping(value = "/createusercreationpage", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView createAdminpageCreateUserpage() {
		ModelAndView createUserPage = new ModelAndView("tracking/adminCreateuser");
		return createUserPage;
	}

	@RequestMapping(value = "/listallusers")
	public ModelAndView createAdminpageListAlluserspage() {
		ModelAndView userlistPage = new ModelAndView("tracking/adminListAllusers");
		try {
			List<UserDetails> users = trackingUserDAO.getAllUsers();
			userlistPage.addObject("users", users);
		} catch(Exception e) {
			
		}
		return userlistPage;
	}
	
	public void setTrackingUserDAO(TrackingUserDAO trackingUserDAO) {
		this.trackingUserDAO = trackingUserDAO;
	}

}
