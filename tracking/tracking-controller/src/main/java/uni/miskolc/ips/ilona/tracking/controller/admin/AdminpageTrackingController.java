package uni.miskolc.ips.ilona.tracking.controller.admin;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

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
			for (UserData user : users) {
				userids.add(user.getUserid());
			}
			mav.addObject("userids", userids);
		} catch (Exception e) {

		}
		return mav;
	}

	@RequestMapping(value = "/tracking/calculatedpath", method = { RequestMethod.POST})
	@ResponseBody
	public Collection<String> calculatePath(@RequestParam(value = "start") String start,
			@RequestParam(value = "end") String end) {
		Collection<String> pathElements = new ArrayList<>();
		UndirectedGraph<String, DefaultEdge> myGrapgh = new SimpleGraph<String, DefaultEdge>(DefaultEdge.class);
		myGrapgh.addVertex("point1");
		myGrapgh.addVertex("point2");
		myGrapgh.addVertex("point3");
		myGrapgh.addVertex("point4");
		myGrapgh.addVertex("point5");

		myGrapgh.addEdge("point1", "point2");
		myGrapgh.addEdge("point2", "point3");
		myGrapgh.addEdge("point3", "point4");
		myGrapgh.addEdge("point4", "point5");

		DijkstraShortestPath<String, DefaultEdge> dij = new DijkstraShortestPath<String, DefaultEdge>(myGrapgh, start,
				end);
		List<DefaultEdge> path = dij.getPathEdgeList();
		
		List<String> thePath = new ArrayList<String>();
		String startNode = start;
		String endNode = end;
		String node1 = null;
		String node2 = null;
		String commonNode = null;
		Graph<String, DefaultEdge> grap = myGrapgh;

		for (DefaultEdge edge : path) {
			node1 = myGrapgh.getEdgeSource(edge);
			node2 = myGrapgh.getEdgeTarget(edge);
			
			/*
			 * Start node managing
			 */
			if (node1.equals(startNode)) {
				if (thePath.size() == 0) {
					thePath.add(node1);
					thePath.add(node2);
					commonNode = node2;
					continue;

				} else {
					thePath.add(node2);
					thePath.add(node1);
					commonNode = node2;
					continue;
				}
			}
			
			if(node2.equals(startNode)) {
				if(thePath.size() == 0) {
					thePath.add(node2);
					thePath.add(node1);
					commonNode = node1;
					continue;
				} else {
					thePath.add(node1);
					thePath.add(node2);
					commonNode = node1;
					continue;
				}
			}
			
			/*
			 * End node managing
			 */
			if(node1.equals(endNode)) {
				if(thePath.size() == 0) {
					thePath.add(node1);
					thePath.add(node2);
					commonNode = node2;
					continue;
				} else {
					thePath.add(node2);
					thePath.add(node1);
					commonNode = node2;
					continue;
				}
			}
			
			if(node2.equals(endNode)) {
				if(thePath.size() == 0) {
					thePath.add(node2);
					thePath.add(node1);
					commonNode = node1;
					continue;
				} else {
					thePath.add(node1);
					thePath.add(node2);
					commonNode = node1;
					continue;
				}
			}
			
			/*
			 * Inner node
			 */
			if(commonNode.equals(node1)) {
				thePath.add(node2);
				commonNode = node2;
				continue;
			}
			
			if(commonNode.equals(node2)) {
				thePath.add(node1);
				commonNode = node1;
				continue;
			}
				
		}
		
		return thePath;
	}

	public void setUserAndDeviceDAO(UserAndDeviceDAO userAndDeviceDAO) {
		this.userAndDeviceDAO = userAndDeviceDAO;
	}

}
