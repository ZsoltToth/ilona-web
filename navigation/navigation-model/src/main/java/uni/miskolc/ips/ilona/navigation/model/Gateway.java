package uni.miskolc.ips.ilona.navigation.model;

import org.jgrapht.graph.DefaultEdge;

public class Gateway<V> extends DefaultEdge {

	/**
	 * 
	 */

	public static final String ELEVATOR = "Elevator";
	public static final String VIRTUALGATEWAY = "VirtualGateway";
	public static final String STAIRCASE = "Staircase";
	public static final String DOOR = "Door";

	private String gateWayType;
	private V source;
	private V target;

	public Gateway(String gateWayType, V source, V target) {
		super();
		this.gateWayType = gateWayType;
		this.source = source;
		this.target = target;
	}

	public String getGateWayType() {
		return gateWayType;
	}

	public void setGateWayType(String gateWayType) {
		this.gateWayType = gateWayType;
	}

	public V getSource() {
		return source;
	}

	public void setSource(V source) {
		this.source = source;
	}

	public V getTarget() {
		return target;
	}

	public void setTarget(V target) {
		this.target = target;
	}

	@Override
	public String toString() {
		return "Gateway [gateWayType=" + gateWayType + ", source=" + source + ", target=" + target + "]";
	}

}
