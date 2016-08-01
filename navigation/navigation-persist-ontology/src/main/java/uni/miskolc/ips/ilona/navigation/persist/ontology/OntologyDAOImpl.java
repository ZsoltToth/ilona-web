package uni.miskolc.ips.ilona.navigation.persist.ontology;

import java.io.File;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.OWLOntology;
import org.semanticweb.owlapi.model.OWLOntologyCreationException;
import org.semanticweb.owlapi.model.OWLOntologyManager;

import uni.miskolc.ips.ilona.navigation.persist.OntologyDAO;

public class OntologyDAOImpl implements OntologyDAO {

	private final OWLOntology baseOntology;
	private final OWLOntology navigationOntology;

	public OntologyDAOImpl(String baseOntologyPath, String navigationOntologyPath) throws OWLOntologyCreationException {
		super();
		File baseOntologyFile = new File(baseOntologyPath);
		File navigationOntologyFile = new File(navigationOntologyPath);
		this.baseOntology = readOntologyFromFile(baseOntologyFile);
		this.navigationOntology = navigationOntologyFile.exists() ? readOntologyFromFile(navigationOntologyFile) : null;
	}

	private OWLOntology readOntologyFromFile(File input) throws OWLOntologyCreationException {
		OWLOntology result;
		OWLOntologyManager manager = OWLManager.createOWLOntologyManager();
		result = manager.loadOntologyFromOntologyDocument(input);
		return result;
	}

	@Override
	public OWLOntology getBaseOntology() {
		return baseOntology;
	}

	@Override
	public OWLOntology getNavigationOntology() {
		return navigationOntology;
	}

}
