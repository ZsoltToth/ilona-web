package uni.miskolc.ips.ilona.navigation.service.impl;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyCreationException;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.model.parameters.OntologyCopy;

import uni.miskolc.ips.ilona.measurement.model.position.Zone;
import uni.miskolc.ips.ilona.measurement.persist.ZoneDAO;
import uni.miskolc.ips.ilona.navigation.persist.OntologyDAO;
import uni.miskolc.ips.ilona.navigation.service.OntologyGenerationService;

public class OntologyGenerationServiceImpl implements OntologyGenerationService {

	private OntologyDAO ontologyDAO;
	private ZoneDAO zoneDAO;

	

	public OntologyGenerationServiceImpl(OntologyDAO ontologyDAO, ZoneDAO zoneDAO) {
		super();
		this.ontologyDAO = ontologyDAO;
		this.zoneDAO = zoneDAO;
	}

	@Override
	public File baseOntology() {
		OWLOntology ontology = ontologyDAO.getBaseOntology();
		try {
			File tempFile = File.createTempFile("ontology", "owl");
			FileWriter writer = new FileWriter(tempFile);
			writer.write(ontology.toString());
			writer.close();
			return tempFile;
		} catch (IOException e) {
			//TODO Log
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public File generateRawOntology() {
		OWLOntologyManager manager = OWLManager.createOWLOntologyManager();
		try {
			manager.copyOntology(ontologyDAO.getBaseOntology(), OntologyCopy.DEEP );

			for(Zone zone : zoneDAO.readZones()){
				//TODO add zones from zoneDAO				
			}
		} catch (OWLOntologyCreationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}

}
