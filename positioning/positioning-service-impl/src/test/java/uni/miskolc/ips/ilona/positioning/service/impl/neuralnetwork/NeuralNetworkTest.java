package uni.miskolc.ips.ilona.positioning.service.impl.neuralnetwork;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.UUID;

import org.easymock.EasyMock;
import org.json.JSONObject;
import org.junit.Ignore;
import org.junit.Test;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import uni.miskolc.ips.ilona.measurement.model.measurement.BluetoothTags;
import uni.miskolc.ips.ilona.measurement.model.measurement.Magnetometer;
import uni.miskolc.ips.ilona.measurement.model.measurement.Measurement;
import uni.miskolc.ips.ilona.measurement.model.measurement.MeasurementBuilder;
import uni.miskolc.ips.ilona.measurement.model.measurement.RFIDTags;
import uni.miskolc.ips.ilona.measurement.model.measurement.WiFiRSSI;
import uni.miskolc.ips.ilona.measurement.model.position.Position;
import uni.miskolc.ips.ilona.measurement.model.position.Zone;
import uni.miskolc.ips.ilona.measurement.service.ZoneService;
import uni.miskolc.ips.ilona.measurement.service.exception.DatabaseUnavailableException;
import uni.miskolc.ips.ilona.measurement.service.exception.ZoneNotFoundException;
import weka.core.converters.JSONLoader;
import weka.core.json.JSONInstances;

import org.apache.logging.log4j.core.config.json.*;

public class NeuralNetworkTest {
	Zone zone1, zone2, zone3,zone4,zone5,zone6,zone7,zone8,zone9,zone10,zone11,zone12,zone13,zone14,zone15,zone16,zone17,zone18,zone19,zone20,zone21;

	@Ignore
	public void determinePositionTest() throws FileNotFoundException, IOException, Exception {
		NeuralNetwork neuralnetwork = new NeuralNetwork(0.6, 0.7, 140, "13",
				"/home/ilona/probaworkspace/neuralnetwork/test.arff");
		String serializedPath = "/home/ilona/probaworkspace/neuralnetwork/neuralnetwork.ser";
		neuralnetwork.serializeNeuralNetwork(serializedPath);
		ZoneService zoneService = mockingZoneService();
		NeuralNetworkPositioning neuralNetworkPositioning = new NeuralNetworkPositioning(zoneService, serializedPath);
		Measurement measurement = createMeasurement();
		Position result = neuralNetworkPositioning.determinePosition(measurement);
		System.out.println("\n" + result.toString());

	}
	
	
	

	@Test
	public void determinePositionOfJSONTest() throws FileNotFoundException, IOException, Exception {
		NeuralNetwork neuralnetwork = new NeuralNetwork(0.9, 0.7, 280, "18",
				"/home/ilona/probaworkspace/neuralnetwork/trainingset.txt");
		String serializedPath = "/home/ilona/probaworkspace/neuralnetwork/neuralnetwork.ser";
		neuralnetwork.serializeNeuralNetwork(serializedPath);
		ZoneService zoneService = mockingZoneService();
		NeuralNetworkPositioning neuralNetworkPositioning = new NeuralNetworkPositioning(zoneService, serializedPath);
		Measurement measurement = instanceFromJSON();
		Position result = neuralNetworkPositioning.determinePosition(measurement);
		System.out.println("\n" + result.toString());

	}
	

	private ZoneService mockingZoneService() throws DatabaseUnavailableException, ZoneNotFoundException {
		zone1 = new Zone("Lab101");
		zone1.setId(UUID.fromString("5e27bae6-076f-4e5d-acb0-11a2cc2b9e0d"));
		zone2 = new Zone("Lab102");
		zone2.setId(UUID.fromString("93f32509-0f74-4f2c-a45a-90858ca646d8"));
		zone3 = new Zone("Lab103");
		zone3.setId(UUID.fromString("8933b3c7-54ac-4fc3-a2e5-8c7fdc7bfae3"));
		zone4 = new Zone("1st Floor East Corridor");
		zone4.setId(UUID.fromString("07a25de0-a013-486d-9463-404a348e05ee"));
		zone5 = new Zone("2nd Floor East Corridor");
		zone5.setId(UUID.fromString("14fc835a-ee28-4b78-9c59-9ee0f759ce56"));
		zone6 = new Zone("Ground Floor East Corridor");
		zone6.setId(UUID.fromString("1501dc2f-55e3-44bd-8f15-8c26a8c7410d"));
		zone7 = new Zone("Lab 104");
		zone7.setId(UUID.fromString("43f5e995-b6f9-4e6f-b40a-9f6bca793ecd"));
		zone8 = new Zone("1st Floor West Corridor");
		zone8.setId(UUID.fromString("544bbbff-2c9c-4d7f-aad5-1742e2f26935"));
		zone9 = new Zone("Lab 115");
		zone9.setId(UUID.fromString("59376e57-9d03-4b9d-af9b-36d6f617a935"));
		zone10 = new Zone("1st Floor North Corridor");
		zone10.setId(UUID.fromString("5eed44d0-c401-46a0-935c-b3161177a00f"));
		zone11 = new Zone("2nd Floor North Corridor");
		zone11.setId(UUID.fromString("79d7a2dc-831e-4d07-98d7-327dbbad3884"));
		zone12 = new Zone("Ground Floor North Corridor");
		zone12.setId(UUID.fromString("7b8681b3-9d64-4b7e-918d-074bd146d9e6"));
		zone13 = new Zone("Ground Floor Lobby");
		zone13.setId(UUID.fromString("8e4181f2-8e1c-467d-8cc2-4580bf5cb76c"));
		zone14 = new Zone("Lab 106");
		zone14.setId(UUID.fromString("a377b162-49fb-4140-bfe1-2565a2260764"));
		zone15 = new Zone("Lecture Hall 205");
		zone15.setId(UUID.fromString("aa7b48e2-ab67-4888-b5c9-1edc21c13d63"));
		zone16 = new Zone("2nd Floor Lobby");
		zone16.setId(UUID.fromString("b33055ec-4fda-4cf1-ae44-b3fd54f94467"));
		zone17 = new Zone("Office 107b");
		zone17.setId(UUID.fromString("bef00f27-9e13-4416-a380-c04010c377cb"));
		zone18 = new Zone("Ground Floor West Corridor");
		zone18.setId(UUID.fromString("e2d1a25f-5496-49c6-85b7-ccb3601a9971"));
		zone19 = new Zone("1st Floor Lobby");
		zone19.setId(UUID.fromString("e48c8f34-716c-477f-a448-9c209d635fbf"));
		zone20 = new Zone("2nd Floor West Corridor");
		zone20.setId(UUID.fromString("f44d88f6-8067-4934-ac94-c38bfdc8bb7f"));
		zone21 = new Zone("Lecture Hall XXVI");
		zone21.setId(UUID.fromString("fff52967-5b13-4935-afa0-44c375cb84db"));
		
		
		Collection<Zone> zones = new ArrayList<Zone>() {
			{
				add(zone1);
				add(zone2);
				add(zone3);
				add(zone4);
				add(zone5);
				add(zone6);
				add(zone7);
				add(zone8);
				add(zone9);
				add(zone10);
				add(zone11);
				add(zone12);
				add(zone13);
				add(zone14);
				add(zone15);
				add(zone16);
				add(zone17);
				add(zone18);
				add(zone19);
				add(zone20);
				add(zone21);
			}
		};

		ZoneService zoneService = EasyMock.createMock(ZoneService.class);
		EasyMock.expect(zoneService.getZone(zone1.getId())).andReturn(zone1);
		EasyMock.expect(zoneService.getZone(zone2.getId())).andReturn(zone2);
		EasyMock.expect(zoneService.getZone(zone3.getId())).andReturn(zone3);
		EasyMock.expect(zoneService.getZone(zone4.getId())).andReturn(zone4);
		EasyMock.expect(zoneService.getZone(zone5.getId())).andReturn(zone5);
		EasyMock.expect(zoneService.getZone(zone6.getId())).andReturn(zone6);
		EasyMock.expect(zoneService.getZone(zone7.getId())).andReturn(zone7);
		EasyMock.expect(zoneService.getZone(zone8.getId())).andReturn(zone8);
		EasyMock.expect(zoneService.getZone(zone9.getId())).andReturn(zone9);
		EasyMock.expect(zoneService.getZone(zone10.getId())).andReturn(zone10);
		EasyMock.expect(zoneService.getZone(zone11.getId())).andReturn(zone11);
		EasyMock.expect(zoneService.getZone(zone12.getId())).andReturn(zone12);
		EasyMock.expect(zoneService.getZone(zone13.getId())).andReturn(zone13);
		EasyMock.expect(zoneService.getZone(zone14.getId())).andReturn(zone14);
		EasyMock.expect(zoneService.getZone(zone15.getId())).andReturn(zone15);
		EasyMock.expect(zoneService.getZone(zone16.getId())).andReturn(zone16);
		EasyMock.expect(zoneService.getZone(zone17.getId())).andReturn(zone17);
		EasyMock.expect(zoneService.getZone(zone18.getId())).andReturn(zone18);
		EasyMock.expect(zoneService.getZone(zone19.getId())).andReturn(zone19);
		EasyMock.expect(zoneService.getZone(zone20.getId())).andReturn(zone20);
		EasyMock.expect(zoneService.getZone(zone21.getId())).andReturn(zone21);
		EasyMock.expect(zoneService.getZones()).andReturn(zones);
		EasyMock.replay(zoneService);
		return zoneService;
	}

	private Measurement createMeasurement() {
		MeasurementBuilder measbuilder = new MeasurementBuilder();

		BluetoothTags bluetooth = new BluetoothTags(new HashSet<String>(
				Arrays.asList(new String[] { "00:16:53:4c:fa:67", "00:16:53:4c:f5:2d", "00:10:60:AA:36:F2" })));
		Magnetometer magneto = new Magnetometer(12, 32, 23, 0.5);
		RFIDTags rfid = new RFIDTags(new HashSet<byte[]>());
		rfid.addTag(new byte[] { (byte) 12 });
		WiFiRSSI wifi = new WiFiRSSI();
		wifi.setRSSI("ait-l15", -0.4);
		wifi.setRSSI("n", -1.2);
		wifi.setRSSI("bosch_telemetry", -3.2);
		measbuilder.setbluetoothTags(bluetooth);
		measbuilder.setMagnetometer(magneto);
		measbuilder.setRFIDTags(rfid);
		measbuilder.setWifiRSSI(wifi);
		Measurement result = measbuilder.build();
		return result;
	}

	private Measurement instanceFromJSON() throws JsonParseException, JsonMappingException, IOException {
		ObjectMapper mapper = new ObjectMapper();
		String json = "{\"id\":\"aded8741-7dae-4c72-b2b1-7f76f63db10c\",\"timestamp\":null"
				+ ",\"position\":{\"coordinate\":{\"x\":28.0,\"y\":9.0,\"z\":4.4},\"zone\":{\"id\":\"07a25de0-a013-486d-9463-404a348e05ee\",\"name\":null"
				+ "},\"uuid\":\"2ff85c99-ba99-429b-9453-c740d23fd4f2\"},\"wifiRSSI\":{\"rssiValues\":{\"IITAP2-GUEST\":-79.0,\"doa6\":-83.0,\"doa203\":-82.0,"
				+"\"aut-sams-1\":-80.0,\"IITAP2\":-78.0,\"IITAP1\":-55.0,\"IITAP3-GUEST\":-73.0,\"dd\":-83.0,\"IITAP3\":-74.0,\"109\":-70.0,\"GEIAKFSZ\":-63.0,\"KRZq\":-65.0"
				+",\"doa208\":-53.0,\"IITAP1-GUEST\":-57.0,\"doa207\":-74.0}},\"magnetometer\":{\"xAxis\":0.11991008371114731,"
				+ "\"yAxis\":-0.9326502084732056,\"zAxis\":0.04995839670300484,\"radian\":0.0},\"bluetoothTags\":{\"tags\":[\"DANI 6B:C2:26:12:62:60\",\"JOE 00:16:53:4C:F9:A4\",\"EV3BD 00:16:53:4C:F5:2D\",\"EV3 00:16:53:4C:FA:67\"]},\"gpsCoordinates\":null,\"rfidtags\":{\"tags\":[]}}";
		Measurement result = mapper.readValue(json, Measurement.class);
		return result;

	}

}
