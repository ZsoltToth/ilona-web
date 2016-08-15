package uni.miskolc.ips.ilona.tracking.controller;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import uni.miskolc.ips.ilona.tracking.controller.model.MobilDummy;

@Controller
@RequestMapping(value = "/tracking/mobile")
public class MobileRequestsController {

	@RequestMapping(value = "/proba", produces = "application/json")
	@ResponseBody
	public MobilDummy dummyHandlerDELETEDDONTUSERIT() {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		
		return new MobilDummy(auth.getName(), 19.245);
	}

}
