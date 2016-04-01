/**
 * This package domain contains the measurement model class hierarchy.
 */
package uni.miskolc.ips.ilona.navigation.model;

import java.util.List;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jgrapht.Graph;
import org.jgrapht.alg.DijkstraShortestPath;
import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.graph.SimpleGraph;

import uni.miskolc.ips.ilona.measurement.model.position.Zone;

/**
 * The ZoneMap class defines graph related methods.
 * 
 * @author teket
 */

public class ZoneMap {

	/**
	 * Logger.
	 */
	private static final Logger LOG = LogManager.getLogger(ZoneMap.class);

	/**
	 * 
	 */
	private Map<Zone, Set<String>> attributes;
	private Graph<Zone, DefaultEdge> zoneGraph;

	public ZoneMap(Collection<Zone> zones, Map<Zone, Set<String>> attributes) {

		this.attributes = attributes;
		this.zoneGraph = new SimpleGraph<Zone, DefaultEdge>(DefaultEdge.class);

		for (Zone zone : zones) {

			this.zoneGraph.addVertex(zone);

			LOG.info(zone.getName() + " added to the graph");

		}

	}

	@Override
	public String toString() {
		return "ZoneMap [attributes=" + attributes + ", zoneGraph=" + zoneGraph + "]";
	}

	public Map<Zone, Set<String>> getAttributes() {
		return attributes;
	}

	public void setAttributes(Map<Zone, Set<String>> attributes) {
		this.attributes = attributes;
	}

	public Graph<Zone, DefaultEdge> getZoneGraph() {
		return zoneGraph;
	}

	public void setZoneGraph(Graph<Zone, DefaultEdge> zoneGraph) {
		this.zoneGraph = zoneGraph;
	}

	public void addZone(Zone zone, Set<String> addedAttributes) {
		zoneGraph.addVertex(zone);
		this.attributes.put(zone, addedAttributes);

		LOG.info(zone.getName() + " has been added.");
	}

	public void addPath(Zone sourceZone, Zone targetZone) {
		zoneGraph.addEdge(sourceZone, targetZone);
		LOG.info("Path between " + sourceZone.getName() + " and " + targetZone.getName() + " added.");
	}

	public void addAttribute(Zone zone, String attribute) {
		if (attributes.containsKey(zone) == false) {
			attributes.put(zone, new HashSet<String>());
		}
		attributes.get(zone).add(attribute);
		LOG.info(attribute + " attribute added to " + zone.getName());
	}

	public void removeZone(Zone zone) {
		zoneGraph.removeVertex(zone);
		LOG.info(zone.getName() + " removed");
	}

	public void removePath(Zone source, Zone target) {
		zoneGraph.removeEdge(source, target);
		LOG.info("path between " + source.getName() + " and " + target.getName() + " removed");
	}

	public void removeAttribute(Zone zone, String attribute) {
		Set<String> result = attributes.get(zone);
		result.remove(attribute);
		attributes.put(zone, result);
		LOG.info(attribute + " from" + zone.getName() + " removed");
	}

	public boolean hasAttribute(Zone zone, String attribute) throws NoSuchZoneException {
		if (attributes.containsKey(zone)) {
			return attributes.get(zone).contains(attribute);
		} else {

			NoSuchZoneException ex = new NoSuchZoneException();
			LOG.error("exception thrown:", ex);
			throw ex;

		}
	}

	public Set<Zone> getZonesWithAttribute(String attribute) throws NoSuchAttributeException {
		Set<Zone> result = new HashSet<Zone>();
		for (Zone zone : attributes.keySet()) {
			if (hasAttribute(zone, attribute)) {
				result.add(zone);
			}
		}
		if (result.isEmpty()) {
			NoSuchAttributeException ex = new NoSuchAttributeException();
			LOG.error("exception thrown:", ex);
			throw ex;
		}

		LOG.info("the following zones have the " + attribute + " attribute:", result);
		return result;

	}

	public boolean areNeighbours(Zone sourceZone, Zone TargetZone) {
		return zoneGraph.containsEdge(sourceZone, TargetZone);

	}

	public boolean isConnected(Zone sourceZone, Zone TargetZone) throws NoPathAvailibleException {
		try {
			return !DijkstraShortestPath.findPathBetween(zoneGraph, sourceZone, TargetZone).equals(null);
		} catch (NullPointerException e) {
			NoPathAvailibleException ex = new NoPathAvailibleException();
			LOG.error("exception thrown:", ex);
			throw ex;
		}
	}

	public int howFarItIs(Zone sourceZone, Zone targetZone) throws NoPathAvailibleException {
		if (isConnected(sourceZone, targetZone)) {
			List<DefaultEdge> result = DijkstraShortestPath.findPathBetween(zoneGraph, sourceZone, targetZone);
			LOG.info("The distance between " + sourceZone.getName() + " and " + targetZone.getName() + " is "
					+ Integer.toString(result.size()));
			return result.size();
		} else {
			NoPathAvailibleException ex = new NoPathAvailibleException();
			LOG.error("Exception thrown:", ex);
			throw ex;
		}

	}
}