package uni.miskolc.ips.ilona.tracking.controller.admin;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.jgrapht.Graph;
import org.jgrapht.UndirectedGraph;
import org.jgrapht.alg.DijkstraShortestPath;
import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.graph.SimpleGraph;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.track.GraphFunctions;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.UserAndDeviceDAO;

@Controller
@RequestMapping(value = "/tracking/admin")
public class AdminpageTrackingController {

	@Autowired
	private UserAndDeviceDAO userAndDeviceDAO;

	@Resource(name = "graphFunctions")
	private GraphFunctions graphFunctions;

	@RequestMapping(value = "/trackingmainpage", method = { RequestMethod.POST })
	public ModelAndView createTrackingMainpage() {
		ModelAndView mav = new ModelAndView("tracking/admin/tracking");
		try {
			Collection<UserData> users = userAndDeviceDAO.getAllUsers();
			Collection<String> userids = new ArrayList<String>(users.size());
			for (UserData user : users) {
				userids.add(user.getUserid());
			}
			mav.addObject("userids", userids);
		} catch (Exception e) {

		}
		return mav;
	}

	@RequestMapping(value = "/tracking/calculatedpath", method = { RequestMethod.POST })
	@ResponseBody
	public Collection<String> calculatePath(@RequestParam(value = "start") String start,
			@RequestParam(value = "end") String end) {

		return null;
	}

	public void setUserAndDeviceDAO(UserAndDeviceDAO userAndDeviceDAO) {
		this.userAndDeviceDAO = userAndDeviceDAO;
	}

	public void setGraphFunctions(GraphFunctions graphFunctions) {
		this.graphFunctions = graphFunctions;
	}

}
