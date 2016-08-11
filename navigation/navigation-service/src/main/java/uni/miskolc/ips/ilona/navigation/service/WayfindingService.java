package uni.miskolc.ips.ilona.navigation.service;

import java.util.List;

import uni.miskolc.ips.ilona.measurement.model.position.Zone;

public interface WayfindingService {
	
	public enum Restriction {
		NO_STAIRS,
		NO_DOOR,
		NO_ELEVATOR
	}
	
	public List<Zone> generateRoute(Zone from, Zone to, Restriction[] restrictions);

}
