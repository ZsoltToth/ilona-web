package uni.miskolc.ips.ilona.tracking.controller;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.model.database.DatabaseUserDatas;
import uni.miskolc.ips.ilona.tracking.service.TrackingUserManagementAndTrackingService;

/**
 * 
 * @author Patrik / A5USL0
 *
 */
@Controller
@RequestMapping(value = "/tracking")
public class TrackingAdminpageController {

	//@Autowired
	TrackingUserManagementAndTrackingService service;
	
	
	@RequestMapping(value = "/createusercreationpage", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView createAdminpageCreateUserpage() {
		ModelAndView createUserPage = new ModelAndView("tracking/adminCreateuser");
		return createUserPage;
	}

	@RequestMapping(value = "/listallusers")
	public ModelAndView createAdminpageListAlluserspage() {
		ModelAndView userlistPage = new ModelAndView("tracking/adminListAllusers");
		Collection<DatabaseUserDatas> users = new ArrayList<DatabaseUserDatas>();
		try {
			//List<UserDetails> users = trackingUserDAO.getAllUsers();
			//userlistPage.addObject("users", users);
			users = service.getAllUsers();
		} catch(Exception e) {
			
		}
		userlistPage.addObject("users", users);
		return userlistPage;
	}
	
	@RequestMapping(value="/adminhomepage", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getAdminHomepage() {
		return new ModelAndView("tracking/adminHomepage");
	}
	
	@RequestMapping(value = "/adminsettings", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getAdminSettingspage() {
		return new ModelAndView("tracking/adminSettings");
	}

	@RequestMapping(value = "/deleteuserbyid", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleteUserById(@RequestParam(value = "userid", required = false) String userid) {
		if(userid != null) {
			// hiba visszadobás
			service.deleteUser(userid);
		}
		System.out.println(userid);
		return "redirect:/tracking/listallusers";
	}
	
	public void setService(TrackingUserManagementAndTrackingService service) {
		this.service = service;
		
	}
	
	
	

}
