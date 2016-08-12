package uni.miskolc.ips.ilona.tracking.controller;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.UserAndDeviceDAO;

@Controller
@RequestMapping(value = "/tracking/admin")
public class AdminpageTrackingController {

	@Autowired
	private UserAndDeviceDAO userAndDeviceDAO;

	@RequestMapping(value = "/trackingmainpage", method = { RequestMethod.POST })
	public ModelAndView createTrackingMainpage() {
		ModelAndView mav = new ModelAndView("tracking/admin/tracking");
		try {
			Collection<UserData> users = userAndDeviceDAO.getAllUsers();
			Collection<String> userids = new ArrayList<String>(users.size());
			for(UserData user : users) {
				userids.add(user.getUserid());
			}
 			mav.addObject("userids", userids);
		} catch (Exception e) {

		}
		return mav;
	}

	public void setUserAndDeviceDAO(UserAndDeviceDAO userAndDeviceDAO) {
		this.userAndDeviceDAO = userAndDeviceDAO;
	}

}
