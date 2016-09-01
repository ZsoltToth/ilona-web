package uni.miskolc.ips.ilona.tracking.controller.track;

import java.io.InputStream;
import java.util.Collection;

import javax.xml.parsers.DocumentBuilderFactory;

import org.jgrapht.UndirectedGraph;
import org.jgrapht.graph.DefaultEdge;
import org.jgrapht.graph.SimpleGraph;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class GraphFunctionsImp implements GraphFunctions {

	private UndirectedGraph<String, DefaultEdge> groundFloor = new SimpleGraph<String, DefaultEdge>(DefaultEdge.class);
	private UndirectedGraph<String, DefaultEdge> firstFloor = new SimpleGraph<String, DefaultEdge>(DefaultEdge.class);
	private UndirectedGraph<String, DefaultEdge> secondFloor = new SimpleGraph<String, DefaultEdge>(DefaultEdge.class);

	public GraphFunctionsImp() {
		try {

			fillElementsIntoGraph(firstFloor, "graphFirstFloor.xml");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Collection<String> generateShortestPath(String from, String to) {

		return null;
	}

	private void fillElementsIntoGraph(UndirectedGraph<String, DefaultEdge> graph, String elementsFilePath)
			throws Exception {
		/*
		 * Load graph
		 */
		ClassLoader loader = getClass().getClassLoader();
		InputStream inputStream = loader.getResourceAsStream(elementsFilePath);
		Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(inputStream);

		Element root = document.getDocumentElement();
		Element nodesElement = (Element) root.getElementsByTagName("graph:nodes").item(0);

		NodeList nodes = nodesElement.getElementsByTagName("graph:node");
		int length = nodes.getLength();
		for (int i = 0; i < length; i++) {
			Element item = (Element)nodes.item(i);		
			System.out.println(item.getElementsByTagName("graph:name").item(0).getTextContent().trim());
		}

	}

}
