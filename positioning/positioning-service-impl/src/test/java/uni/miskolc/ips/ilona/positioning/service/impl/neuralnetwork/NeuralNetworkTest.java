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
import org.junit.Test;

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

public class NeuralNetworkTest {
	Zone zone1,zone2,zone3;
	
	@Test
	public void determinePositionTest() throws FileNotFoundException, IOException, Exception{
		NeuralNetwork neuralnetwork = new NeuralNetwork(0.2, 0.1, 2000, "20,40",
				"/home/ilona/probaworkspace/neuralnetwork/test.arff");
		String serializedPath = "/home/ilona/probaworkspace/neuralnetwork/neuralnetwork.ser";
		neuralnetwork.serializeNeuralNetwork(serializedPath);
		ZoneService zoneService = mockingZoneService();
		NeuralNetworkPositioning neuralNetworkPositioning = new NeuralNetworkPositioning(zoneService, serializedPath);
		Measurement measurement = createMeasurement();
		Position result = neuralNetworkPositioning.determinePosition(measurement);
		System.out.println(result.toString());
		
		
	}
	
	
	private ZoneService mockingZoneService() throws DatabaseUnavailableException, ZoneNotFoundException{
		zone1 = new Zone("Lab101");
		zone1.setId(UUID.fromString("07a25de0-a013-486d-9463-404a348e05ee"));
		zone2 = new Zone("Lab102");
		zone2.setId(UUID.fromString("07a25de0-a013-486d-9463-404a348e05e1"));
		zone3 = new Zone("Lab103");
		zone3.setId(UUID.fromString("07a25de0-a013-486d-9463-404a348e05e2"));
		Collection<Zone> zones = new ArrayList<Zone>(){{add(zone1);add(zone2);add(zone3); }}; 
		
		ZoneService zoneService = EasyMock.createMock(ZoneService.class);
		EasyMock.expect(zoneService.getZone(zone1.getId())).andReturn(zone1);
		EasyMock.expect(zoneService.getZone(zone2.getId())).andReturn(zone2);
		EasyMock.expect(zoneService.getZone(zone3.getId())).andReturn(zone3);
		EasyMock.expect(zoneService.getZones()).andReturn(zones);
		EasyMock.replay(zoneService);
		return zoneService;
	}
	
	
	private Measurement createMeasurement(){
		MeasurementBuilder measbuilder = new MeasurementBuilder();

		BluetoothTags bluetooth = new BluetoothTags(
				new HashSet<String>(Arrays.asList(new String[] { "00:16:53:4c:fa:67", "00:16:53:4c:f5:2d", "00:10:60:AA:36:F2" })));
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
	
}
