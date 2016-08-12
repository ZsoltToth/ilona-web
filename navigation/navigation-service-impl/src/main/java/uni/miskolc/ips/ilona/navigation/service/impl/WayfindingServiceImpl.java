package uni.miskolc.ips.ilona.navigation.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.semanticweb.owlapi.model.OWLOntologyCreationException;

import uni.miskolc.ips.ilona.measurement.model.position.Zone;
import uni.miskolc.ips.ilona.measurement.persist.ZoneDAO;
import uni.miskolc.ips.ilona.measurement.persist.exceptions.RecordNotFoundException;
import uni.miskolc.ips.ilona.measurement.persist.mysql.MySQLZoneDAO;
import uni.miskolc.ips.ilona.navigation.model.ZoneMap;
import uni.miskolc.ips.ilona.navigation.persist.OntologyDAO;
import uni.miskolc.ips.ilona.navigation.persist.ontology.OntologyDAOImpl;
import uni.miskolc.ips.ilona.navigation.service.NoRouteAvailableException;
import uni.miskolc.ips.ilona.navigation.service.WayfindingService;

public class WayfindingServiceImpl implements WayfindingService {

	private final OntologyDAO ontologyDAO;
	private final ZoneDAO ZoneDAO;
	
	

	public WayfindingServiceImpl(OntologyDAO ontologyDAO, uni.miskolc.ips.ilona.measurement.persist.ZoneDAO zoneDAO) {
		super();
		this.ontologyDAO = ontologyDAO;
		ZoneDAO = zoneDAO;
	}

	@Override
	public List<Zone> generateRoute(Zone from, Zone to) throws NoRouteAvailableException {
		List<Zone> result=new ArrayList<>();
		ZoneMap map = ontologyDAO.createGraphWithoutRestrictions();
		for(UUID id : map.findPath(from.getId(), to.getId())){
			try {
				result.add(ZoneDAO.readZone(id));
			} catch (RecordNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return result;
	}

	@Override
	public List<Zone> generateRoute(Zone from, Zone to, Restriction[] restrictions) throws NoRouteAvailableException {
		// TODO Auto-generated method stub
		return null;
	}

}
