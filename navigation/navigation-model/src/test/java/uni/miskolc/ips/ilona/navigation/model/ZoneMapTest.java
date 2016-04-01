package uni.miskolc.ips.ilona.navigation.model;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import static org.junit.Assert.*;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.junit.Before;
import org.junit.Test;

import uni.miskolc.ips.ilona.measurement.model.position.Zone;

public class ZoneMapTest {
	
	static Collection<Zone> testZones;
    static Map<Zone, Set<String>> testAttributes;
	static Set<String> firstSet;
	static Set<String> secondSet;
	static Set<String> thirdSet;
	static Zone firstZone;
    static Zone secondZone;
    static Zone thirdZone;
    static ZoneMap testMap;
    static Zone testZone;
    static Set<String> testSet;
    
	@Before
	public void setUp(){
		firstSet = new HashSet<String>();
		secondSet = new HashSet<String>();
		thirdSet = new HashSet<String>();
		firstZone = new Zone("first");
		secondZone = new Zone("second");
		thirdZone = new Zone("third");
		testAttributes = new HashMap<>();
		testZones = new HashSet<Zone>();
		
	     firstSet.add("a");
	     firstSet.add("b");
	     firstSet.add("c");
	     secondSet.add("a");
	     thirdSet.add("c");
		 
	     testZones.add(firstZone);
	     testZones.add(secondZone);
	     testZones.add(thirdZone);
		 
	     testAttributes.put(firstZone, firstSet);
	     testAttributes.put(secondZone, secondSet);
	     testAttributes.put(thirdZone, thirdSet);
	     
	     testMap= new ZoneMap(testZones, testAttributes);
	     
	     testMap.addPath(firstZone, secondZone);
	     testMap.addPath(secondZone, thirdZone);
	     
	}
	
	@Test
	public void ZoneMapVertexTest(){
	boolean expected = testMap.getZoneGraph().containsVertex(firstZone);
	assertTrue(expected);
	}
	
	@Test
	public void ZoneMapEdgeTest(){
	boolean expected = testMap.getZoneGraph().containsEdge(firstZone, secondZone);
	assertTrue(expected);
	}
	
	@Test
	public void areNeighboursTest(){
		boolean actual=testMap.areNeighbours(firstZone, secondZone);
		assertTrue(actual);
		
	}
	
	@Test
	public void isConnectedTest(){
		boolean actual=testMap.isConnected(secondZone, thirdZone);
		assertTrue(actual);
	}
	
	@Test
	public void howFarItIsTest(){
		int actual= testMap.howFarItIs(firstZone, thirdZone);
		int distanceOfTheTwoZones=2;
		assertEquals( distanceOfTheTwoZones, actual);
	}
	
	@Test
	public void addZoneTest(){
		testZone = new Zone("test");
		testMap.addZone(testZone, firstSet);
		assertTrue(testMap.getZoneGraph().containsVertex(testZone));
	}
	
	@Test
	public void addAttributeTest(){
		testMap.addAttribute(firstZone, "test");
		assertTrue(testMap.getAttributes().get(firstZone).contains("test"));
	}
	
	@Test
	public void addPathTest(){
		testMap.addPath(firstZone, thirdZone);;
		assertTrue(testMap.getZoneGraph().containsEdge(thirdZone, firstZone));
	}
	
	@Test
	public void removeZoneTest(){
		testMap.removeZone(firstZone);
		assertFalse(testMap.getZoneGraph().containsVertex(firstZone));;
	}
	
	@Test
	public void removeAttributeTest(){
		testMap.removeAttribute(firstZone, "b");
		assertFalse(testMap.getAttributes().get(firstZone).contains("b"));;
	}
	
	@Test
	public void removePathTest(){
		testMap.removePath(firstZone, secondZone);
		assertFalse(testMap.getZoneGraph().containsEdge(firstZone, secondZone));;
	}
	
	@Test
	public void hasAttributeTest(){
		assertTrue(testMap.hasAttribute(firstZone, "b"));
	}
	
	@Test
	public void getZonesWithAttributeTest(){
		String actual = testMap.getZonesWithAttribute("b").toString();
		assertEquals("["+firstZone.toString()+"]", actual);
	}
	
	@Test(expected=NoSuchZoneException.class)
	public void NoSuchZoneExceptionTest(){
		testMap.hasAttribute(testZone, "a");
	}
	
	@Test(expected=NoPathAvailibleException.class)
	public void isConnectedNoPathAvailibleExceptionTest(){
		testZone = new Zone("test");
		testMap.addZone(testZone, firstSet);
		testMap.isConnected(firstZone, testZone);
	}
	
	@Test(expected=NoPathAvailibleException.class)
	public void howFarItIsNoPathAvailibleExceptionTest(){
		testZone = new Zone("test");
		testMap.addZone(testZone, firstSet);
		testMap.howFarItIs(firstZone, testZone);
	}
	
	@Test(expected=NoSuchAttributeException.class)
	public void NoSuchAttributeExceptionTest(){
		testMap.getZonesWithAttribute("notAnAttribute");
	}
	
	@Test
	public void hasAttributeFalseTest(){
		assertFalse(testMap.hasAttribute(firstZone, "notAnAttribute"));
	}
	
	@Test
	public void addAttributeNewZoneTest(){
		testMap.addAttribute(testZone, "test");
		assertTrue(testMap.hasAttribute(testZone, "test"));
	}
}
