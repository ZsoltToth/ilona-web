package uni.miskolc.ips.ilona.tracking.controller.admin;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.util.TrackingModuleCentralManager;

@Controller
@RequestMapping(value = "/tracking/admin")
public class AdminpageCentralManagementController {

	@Resource(name = "trackingCentralManager")
	private TrackingModuleCentralManager centralManager;

	@RequestMapping(value = "/centralmanagement", method = { RequestMethod.POST })
	public ModelAndView generateAdminCentralManagementpage() {
		ModelAndView mav = new ModelAndView("tracking/admin/centralManagement");
		mav.addObject("accountExpiration", centralManager.getAccountExpirationTime());
		return mav;
	}

	public void setCentralManager(TrackingModuleCentralManager centralManager) {
		this.centralManager = centralManager;
	}

}
