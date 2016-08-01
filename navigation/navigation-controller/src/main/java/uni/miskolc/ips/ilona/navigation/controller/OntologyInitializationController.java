package uni.miskolc.ips.ilona.navigation.controller;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import uni.miskolc.ips.ilona.navigation.service.OntologyGenerationService;


@Controller

public class OntologyInitializationController 
{
	/**
	 * Logger.
	 */
	private static final Logger LOG = LogManager.getLogger(OntologyInitializationController.class.getName());
	
	@Autowired
	private OntologyGenerationService ontologyGenerationService;
	
	@RequestMapping(value = {"/navigation/ontology/init"})
	@ResponseBody
	public String initOntology(){
		StringBuffer result = new StringBuffer();
		
		try {
			String line;
			BufferedReader br = new BufferedReader(new FileReader(ontologyGenerationService.baseOntology()));
			while((line = br.readLine()) != null){
				result.append(line);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result.toString();
	}
}
