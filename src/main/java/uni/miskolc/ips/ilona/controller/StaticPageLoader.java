package uni.miskolc.ips.ilona.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.measurement.model.measurement.Measurement;

@Controller
public class StaticPageLoader {
	
	@RequestMapping("/")
	public ModelAndView loadHomePage() {
		ModelAndView result = new ModelAndView("index");
		return result;
	}

}
