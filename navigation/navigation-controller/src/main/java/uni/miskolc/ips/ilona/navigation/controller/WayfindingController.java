package uni.miskolc.ips.ilona.navigation.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import uni.miskolc.ips.ilona.measurement.model.position.Zone;
import uni.miskolc.ips.ilona.navigation.service.NoRouteAvailableException;
import uni.miskolc.ips.ilona.navigation.service.WayfindingService;

@Controller
public class WayfindingController {

	@Autowired
	private WayfindingService wayfindingService;

	@RequestMapping(value = "/navigation/ontology/getpath")
	@ResponseBody
	public List<Zone> getNavigationPath(@RequestParam("start") Zone start,
			@RequestParam("destination") Zone destination,
			@RequestParam("restrictions") Collection<String> restrictions) {
		List<Zone> result = new ArrayList<>();
		try {
			result = wayfindingService.generateRoute(start, destination);
		} catch (NoRouteAvailableException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return result;
	}

}
