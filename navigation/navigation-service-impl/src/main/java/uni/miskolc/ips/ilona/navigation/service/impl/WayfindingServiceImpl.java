package uni.miskolc.ips.ilona.navigation.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.semanticweb.owlapi.model.OWLOntologyCreationException;

import uni.miskolc.ips.ilona.measurement.model.position.Zone;
import uni.miskolc.ips.ilona.measurement.persist.ZoneDAO;
import uni.miskolc.ips.ilona.navigation.model.ZoneMap;
import uni.miskolc.ips.ilona.navigation.persist.OntologyDAO;
import uni.miskolc.ips.ilona.navigation.persist.ontology.OntologyDAOImpl;
import uni.miskolc.ips.ilona.navigation.service.NoRouteAvailableException;
import uni.miskolc.ips.ilona.navigation.service.WayfindingService;

public class WayfindingServiceImpl implements WayfindingService {

	public WayfindingServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public List<Zone> generateRoute(Zone from, Zone to) throws NoRouteAvailableException, OWLOntologyCreationException {
		List<Zone> result=new ArrayList<>();
		OntologyDAOImpl ontologyDao = new OntologyDAOImpl("basepath", "navigationpath");
		ZoneDAO zoneDao = null;
		ZoneMap map = ontologyDao.createGraphWithoutRestrictions(ontologyDao.getNavigationOntology());
		for(UUID id : map.findPath(from.getId(), to.getId())){
		}
		return null;
	}

	@Override
	public List<Zone> generateRoute(Zone from, Zone to, Restriction[] restrictions) throws NoRouteAvailableException {
		// TODO Auto-generated method stub
		return null;
	}

}
