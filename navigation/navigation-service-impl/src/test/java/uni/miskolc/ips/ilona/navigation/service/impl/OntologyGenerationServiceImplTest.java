package uni.miskolc.ips.ilona.navigation.service.impl;

import static org.junit.Assert.*;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.junit.Test;
import org.semanticweb.HermiT.Reasoner;
import org.semanticweb.HermiT.Reasoner.ReasonerFactory;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLEntity;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyCreationException;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.reasoner.InferenceType;
import org.semanticweb.owlapi.reasoner.Node;
import org.semanticweb.owlapi.reasoner.NodeSet;
import org.semanticweb.owlapi.reasoner.OWLReasoner;
import org.easymock.EasyMock;

import uni.miskolc.ips.ilona.measurement.model.position.Zone;
import uni.miskolc.ips.ilona.measurement.persist.ZoneDAO;
import uni.miskolc.ips.ilona.navigation.persist.OntologyDAO;
import uni.miskolc.ips.ilona.navigation.persist.ontology.IlonaIRIs;
import uni.miskolc.ips.ilona.navigation.persist.ontology.OntologyDAOImpl;

public class OntologyGenerationServiceImplTest {

	@Test
	public void testGenerateRawOntology() throws OWLOntologyCreationException {
		ZoneDAO zoneDAOMock = EasyMock.createMock(ZoneDAO.class);
		OntologyDAO ontologyDAOMock = EasyMock.createMock(OntologyDAO.class);
		OntologyDAO odao = new OntologyDAOImpl("resources/ILONABASE.owl", "resources/ILONA.owl");
		Collection<Zone> zones = new ArrayList<Zone>();
		zones.add(new Zone("test #One"));
		zones.add(new Zone("test #Two"));
		OWLOntologyManager manager = OWLManager.createOWLOntologyManager();
		OWLDataFactory factory = manager.getOWLDataFactory();

		EasyMock.expect(ontologyDAOMock.getBaseOntology())
				.andReturn(manager.loadOntologyFromOntologyDocument(new File("resources/ILONABASE.owl")));
		EasyMock.expect(zoneDAOMock.readZones()).andReturn(zones);
		EasyMock.replay(zoneDAOMock);
		EasyMock.replay(ontologyDAOMock);

		OntologyGenerationServiceImpl test = new OntologyGenerationServiceImpl(odao, zoneDAOMock);
		
		OWLOntologyManager newManager = OWLManager.createOWLOntologyManager();
		OWLOntology generated = newManager.loadOntologyFromOntologyDocument(test.generateRawOntology());
		
		OWLReasoner reasoner = new Reasoner.ReasonerFactory().createReasoner(generated);
		NodeSet<OWLNamedIndividual> zoneQuery = reasoner.getInstances(factory.getOWLClass(IlonaIRIs.ZONE));
		List<String> result = new ArrayList<String>();
		for (Node<OWLNamedIndividual> individualNode : zoneQuery) {
			OWLNamedIndividual individual = individualNode.getRepresentativeElement();
			result.add(individual.getIRI().getShortForm());

		}
		List<String> expected = new ArrayList<String>();
		expected.add("test_One");
		expected.add("test_Two");
		assertEquals(result, expected);

	}

}
