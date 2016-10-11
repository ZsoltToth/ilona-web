package uni.miskolc.ips.ilona.navigation.service.impl;

import java.lang.reflect.Method;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import org.easymock.EasyMock;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import static org.junit.Assert.*;
import static org.hamcrest.CoreMatchers.*;
import org.semanticweb.owlapi.model.OWLOntology;

import uni.miskolc.ips.ilona.measurement.model.position.Zone;
import uni.miskolc.ips.ilona.measurement.persist.ZoneDAO;
import uni.miskolc.ips.ilona.measurement.persist.exceptions.RecordNotFoundException;
import uni.miskolc.ips.ilona.navigation.model.Gateway;
import uni.miskolc.ips.ilona.navigation.model.ZoneMap;
import uni.miskolc.ips.ilona.navigation.persist.OntologyDAO;
import uni.miskolc.ips.ilona.navigation.persist.OntologyDAO.GatewayRestriction;
import uni.miskolc.ips.ilona.navigation.persist.OntologyDAO.ZoneRestriction;
import uni.miskolc.ips.ilona.navigation.service.NoRouteAvailableException;
import uni.miskolc.ips.ilona.navigation.service.WayfindingService;
import uni.miskolc.ips.ilona.navigation.service.WayfindingService.Restriction;

public class WayfindingServiceImplementationTest {
	private static WayfindingServiceImpl test;

	@Test
	public void testGenerateRoute() throws RecordNotFoundException, NoRouteAvailableException{
		ZoneDAO zoneDAOMock = EasyMock.createMock(ZoneDAO.class);
		OntologyDAO ontoDAO = EasyMock.createMock(OntologyDAO.class);
		Zone za = new Zone("za");
		Zone zb = new Zone("zb");
		Zone zc = new Zone("zc");
		UUID a = za.getId();
		UUID b=zb.getId();
		UUID c =zc.getId();
		Set<UUID> set = new HashSet<>();
		set.add(c);
		set.add(b);
		set.add(a);
		Set<Gateway> paths = new HashSet<>();
		paths.add(new Gateway(a, b));
		paths.add(new Gateway(b, c));
		ZoneMap map = new ZoneMap(set, paths);
		
		EasyMock.expect(ontoDAO.createGraphWithoutRestrictions()).andReturn(map).anyTimes();
		EasyMock.expect(zoneDAOMock.readZone(a)).andReturn(za);
		EasyMock.expect(zoneDAOMock.readZone(b)).andReturn(zb);
		EasyMock.expect(zoneDAOMock.readZone(c)).andReturn(zc);
		EasyMock.replay(zoneDAOMock);
		EasyMock.replay(ontoDAO);
		
		
		WayfindingService test = new WayfindingServiceImpl(ontoDAO, zoneDAOMock);
		
		List<Zone> results = test.generateRoute(za, zc);
		
		assertThat(results, hasItems(za,zb,zc));
	}
	
	@Test
	public void testGenerateRouteWithRestrictions() throws RecordNotFoundException, NoRouteAvailableException{
		Set<Restriction> input = new HashSet<>();
		input.add(Restriction.NO_ELEVATOR);
		input.add(Restriction.NO_DOOR);
		input.add(Restriction.DUMMY_ZONERESTRICTION);
		
		ZoneDAO zoneDAOMock = EasyMock.createMock(ZoneDAO.class);
		OntologyDAO ontoDAO = EasyMock.createMock(OntologyDAO.class);
		Zone za = new Zone("za");
		Zone zb = new Zone("zb");
		Zone zc = new Zone("zc");
		UUID a = za.getId();
		UUID b=zb.getId();
		UUID c =zc.getId();
		Set<UUID> set = new HashSet<>();
		set.add(c);
		set.add(b);
		set.add(a);
		Set<Gateway> paths = new HashSet<>();
		paths.add(new Gateway(a, b));
		paths.add(new Gateway(b, c));
		ZoneMap map = new ZoneMap(set, paths);
		
		Set<GatewayRestriction> gatewayRestrictions = new HashSet();
		gatewayRestrictions.add(GatewayRestriction.NO_ELEVATOR);
		gatewayRestrictions.add(GatewayRestriction.NO_DOOR);
		
		Set<ZoneRestriction> zoneRestrictions = new HashSet<>();
		zoneRestrictions.add(ZoneRestriction.DUMMY_ZONERESTRICTION);
		
		EasyMock.expect(ontoDAO.createGraph(gatewayRestrictions, zoneRestrictions)).andReturn(map).anyTimes();
		EasyMock.expect(zoneDAOMock.readZone(a)).andReturn(za);
		EasyMock.expect(zoneDAOMock.readZone(b)).andReturn(zb);
		EasyMock.expect(zoneDAOMock.readZone(c)).andReturn(zc);
		EasyMock.replay(zoneDAOMock);
		EasyMock.replay(ontoDAO);
		
		
		WayfindingService test = new WayfindingServiceImpl(ontoDAO, zoneDAOMock);
		
		List<Zone> results = test.generateRoute(za, zc, input);
		
		assertThat(results, hasItems(za,zb,zc));
	}
	
	@Test
	public void testGenerateRouteWithEmptyRestrictionSet() throws RecordNotFoundException, NoRouteAvailableException{
		ZoneDAO zoneDAOMock = EasyMock.createMock(ZoneDAO.class);
		OntologyDAO ontoDAO = EasyMock.createMock(OntologyDAO.class);
		Zone za = new Zone("za");
		Zone zb = new Zone("zb");
		Zone zc = new Zone("zc");
		UUID a = za.getId();
		UUID b=zb.getId();
		UUID c =zc.getId();
		Set<UUID> set = new HashSet<>();
		set.add(c);
		set.add(b);
		set.add(a);
		Set<Gateway> paths = new HashSet<>();
		paths.add(new Gateway(a, b));
		paths.add(new Gateway(b, c));
		ZoneMap map = new ZoneMap(set, paths);
		
		EasyMock.expect(ontoDAO.createGraphWithoutRestrictions()).andReturn(map).anyTimes();
		EasyMock.expect(zoneDAOMock.readZone(a)).andReturn(za);
		EasyMock.expect(zoneDAOMock.readZone(b)).andReturn(zb);
		EasyMock.expect(zoneDAOMock.readZone(c)).andReturn(zc);
		EasyMock.replay(zoneDAOMock);
		EasyMock.replay(ontoDAO);
		
		
		WayfindingService test = new WayfindingServiceImpl(ontoDAO, zoneDAOMock);
		
		List<Zone> results = test.generateRoute(za, zc, new HashSet<>());
		
		assertThat(results, hasItems(za,zb,zc));
	}
	
	@Ignore
	@Test(expected=RecordNotFoundException.class)
	public void testGenerateRouteRecordNotFound() throws RecordNotFoundException, NoRouteAvailableException{
		ZoneDAO zoneDAOMock = EasyMock.createMock(ZoneDAO.class);
		OntologyDAO ontoDAO = EasyMock.createMock(OntologyDAO.class);
		Zone za = new Zone("za");
		Zone zb = new Zone("zb");
		Zone zc = new Zone("zc");
		UUID a = za.getId();
		UUID b=zb.getId();
		UUID c =zc.getId();
		Set<UUID> set = new HashSet<>();
		set.add(c);
		set.add(b);
		set.add(a);
		Set<Gateway> paths = new HashSet<>();
		paths.add(new Gateway(a, b));
		paths.add(new Gateway(b, c));
		ZoneMap map = new ZoneMap(set, paths);
		
		EasyMock.expect(ontoDAO.createGraphWithoutRestrictions()).andReturn(map).anyTimes();
		EasyMock.expect(zoneDAOMock.readZone(a)).andReturn(za);
		EasyMock.expect(zoneDAOMock.readZone(b)).andReturn(zb);
		EasyMock.expect(zoneDAOMock.readZone(c)).andThrow(new RecordNotFoundException());
		EasyMock.replay(zoneDAOMock);
		EasyMock.replay(ontoDAO);
		
		
		WayfindingService test = new WayfindingServiceImpl(ontoDAO, zoneDAOMock);
		
		test.generateRoute(za, zc, new HashSet<>());
		
	}
	
	@Test
	public void testGenerateRouteWithRestrictionsAndPerson() throws RecordNotFoundException, NoRouteAvailableException{
		Set<Restriction> input = new HashSet<>();
		input.add(Restriction.NO_ELEVATOR);
		input.add(Restriction.NO_DOOR);
		input.add(Restriction.DUMMY_ZONERESTRICTION);
		String person =new String("Dummy");
		
		ZoneDAO zoneDAOMock = EasyMock.createMock(ZoneDAO.class);
		OntologyDAO ontoDAO = EasyMock.createMock(OntologyDAO.class);
		Zone za = new Zone("za");
		Zone zb = new Zone("zb");
		Zone zc = new Zone("zc");
		UUID a = za.getId();
		UUID b=zb.getId();
		UUID c =zc.getId();
		Set<UUID> set = new HashSet<>();
		set.add(c);
		set.add(b);
		set.add(a);
		Set<Gateway> paths = new HashSet<>();
		paths.add(new Gateway(a, b));
		paths.add(new Gateway(b, c));
		ZoneMap map = new ZoneMap(set, paths);
		
		Set<GatewayRestriction> gatewayRestrictions = new HashSet();
		gatewayRestrictions.add(GatewayRestriction.NO_ELEVATOR);
		gatewayRestrictions.add(GatewayRestriction.NO_DOOR);
		
		Set<ZoneRestriction> zoneRestrictions = new HashSet<>();
		zoneRestrictions.add(ZoneRestriction.DUMMY_ZONERESTRICTION);
		
		EasyMock.expect(ontoDAO.createGraph(gatewayRestrictions, zoneRestrictions)).andReturn(map).anyTimes();
		EasyMock.expect(ontoDAO.getResidenceId(person)).andReturn(c);
		EasyMock.expect(zoneDAOMock.readZone(a)).andReturn(za);
		EasyMock.expect(zoneDAOMock.readZone(b)).andReturn(zb);
		EasyMock.expect(zoneDAOMock.readZone(c)).andReturn(zc);
		EasyMock.replay(zoneDAOMock);
		EasyMock.replay(ontoDAO);
		
		
		WayfindingService test = new WayfindingServiceImpl(ontoDAO, zoneDAOMock);
		
		List<Zone> results = test.generateRoute(za, person, input);
		
		assertThat(results, hasItems(za,zb,zc));
	}
	
	@Test
	public void testGenerateRouteWithPersonAndEmptyRestrictionSet() throws RecordNotFoundException, NoRouteAvailableException{
		ZoneDAO zoneDAOMock = EasyMock.createMock(ZoneDAO.class);
		OntologyDAO ontoDAO = EasyMock.createMock(OntologyDAO.class);
		String person = new String("Dummy");
		Zone za = new Zone("za");
		Zone zb = new Zone("zb");
		Zone zc = new Zone("zc");
		UUID a = za.getId();
		UUID b=zb.getId();
		UUID c =zc.getId();
		Set<UUID> set = new HashSet<>();
		set.add(c);
		set.add(b);
		set.add(a);
		Set<Gateway> paths = new HashSet<>();
		paths.add(new Gateway(a, b));
		paths.add(new Gateway(b, c));
		ZoneMap map = new ZoneMap(set, paths);
		
		EasyMock.expect(ontoDAO.createGraphWithoutRestrictions()).andReturn(map).anyTimes();
		EasyMock.expect(ontoDAO.getResidenceId(person)).andReturn(c);
		EasyMock.expect(zoneDAOMock.readZone(a)).andReturn(za);
		EasyMock.expect(zoneDAOMock.readZone(b)).andReturn(zb);
		EasyMock.expect(zoneDAOMock.readZone(c)).andReturn(zc);
		EasyMock.replay(zoneDAOMock);
		EasyMock.replay(ontoDAO);
		
		
		WayfindingService test = new WayfindingServiceImpl(ontoDAO, zoneDAOMock);
		
		List<Zone> results = test.generateRoute(za, person, new HashSet<>());
		
		assertThat(results, hasItems(za,zb,zc));
	}

}
