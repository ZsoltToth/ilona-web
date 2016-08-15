package uni.miskolc.ips.ilona.tracking.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/tracking/admin")
public class AdminpageCentralManagementController {

	@RequestMapping(value = "/centralmanagement", method = { RequestMethod.POST })
	public ModelAndView generateAdminCentralManagementpage() {
		ModelAndView mav = new ModelAndView("tracking/admin/centralManagement");

		return mav;
	}
}
