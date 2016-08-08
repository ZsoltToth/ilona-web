package uni.miskolc.ips.ilona.tracking.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/tracking/admin")
public class AdminpageTrackingController {

	@RequestMapping(value = "/trackingmainpage", method = { RequestMethod.POST })
	public ModelAndView createTrackingMainpage() {
		ModelAndView mav = new ModelAndView("tracking/admin/tracking");

		return mav;
	}
}
