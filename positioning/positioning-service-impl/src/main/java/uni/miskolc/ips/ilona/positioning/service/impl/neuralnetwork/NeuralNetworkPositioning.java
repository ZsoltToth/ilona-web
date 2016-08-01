package uni.miskolc.ips.ilona.positioning.service.impl.neuralnetwork;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Enumeration;
import java.util.List;
import java.util.Set;
import java.util.UUID;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import uni.miskolc.ips.ilona.positioning.service.impl.neuralnetwork.*;
import uni.miskolc.ips.ilona.measurement.model.measurement.BluetoothTags;
import uni.miskolc.ips.ilona.measurement.model.measurement.Magnetometer;
import uni.miskolc.ips.ilona.measurement.model.measurement.Measurement;
import uni.miskolc.ips.ilona.measurement.model.position.Position;
import uni.miskolc.ips.ilona.measurement.model.position.Zone;
import uni.miskolc.ips.ilona.measurement.service.PositionService;
import uni.miskolc.ips.ilona.measurement.service.ZoneService;
import uni.miskolc.ips.ilona.positioning.service.PositioningService;
import weka.classifiers.Classifier;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.core.Attribute;
import weka.core.DenseInstance;
import weka.core.Instance;
import weka.core.Instances;

public class NeuralNetworkPositioning implements PositioningService {
	private NeuralNetwork neuralNetwork;
	private ZoneService zoneService;
	private static final Logger LOG = LogManager.getLogger(NeuralNetworkPositioning.class);

	public NeuralNetworkPositioning(ZoneService zoneService, String serializedMultilayerPerceptron) {
		super();
		this.neuralNetwork = deserializeNeuralNetwork(serializedMultilayerPerceptron);
		this.zoneService = zoneService;

	}

	public Position determinePosition(Measurement measurement) {

		Position result;
		MultilayerPerceptron mlp = neuralNetwork.getMultilayerPerceptron();
		Instance instance = convertMeasurementToInstance(measurement);
		double cls;
		try {
			cls = mlp.classifyInstance(instance);
			Zone zoneresult = zoneService.getZone(UUID.fromString(instance.classAttribute().value((int) cls)));
			result = new Position(zoneresult);
		} catch (Exception e) {
			result = new Position(Zone.UNKNOWN_POSITION);
		}
		LOG.info(String.format("The incoming measurement is " + measurement.toString()
				+ ". The determined position for this is " + result.toString()));
		return result;
	}

	private NeuralNetwork deserializeNeuralNetwork(String serializedPath) {
		NeuralNetwork result;
		try {
			FileInputStream fileIn = new FileInputStream(serializedPath);
			ObjectInputStream in = new ObjectInputStream(fileIn);
			result = (NeuralNetwork) in.readObject();
			in.close();
			fileIn.close();
		} catch (IOException i) {
			i.printStackTrace();// ezt is logolni
			result = null;
		} catch (ClassNotFoundException c) {
			LOG.info("Serialised Neural Network not found on " + serializedPath + " "); // logra
																						// kiírni
			c.printStackTrace();
			result = null;
		}

		return result;

	}

	private Instance convertMeasurementToInstance(Measurement meas) {
		ArrayList<Attribute> header = getHeader(neuralNetwork.getMultilayerPerceptron());

		Instance instance = new DenseInstance(header.size());
		List<Attribute> attributes = new ArrayList<Attribute>();
		for (int i = 0; i < header.size(); i++) {
			attributes.add(new Attribute(header.get(i).name()));
		}
		LOG.info("The attributes are " + attributes.toString());
		for (int i = 0; i < attributes.size(); i++) {
			if (attributes.get(i).name().equals("measx")) {
				instance.setValue(i, meas.getMagnetometer().getxAxis());
			} else if (attributes.get(i).name().equals("measy")) {
				instance.setValue(i, meas.getMagnetometer().getyAxis());
			} else if (attributes.get(i).name().equals("measz")) {
				instance.setValue(i, meas.getMagnetometer().getzAxis());
			} else if (attributes.get(i).name().contains(":")) {
				instance.setValue(i, measurementSeeBluetooth(meas, attributes.get(i).name()));
			} else if (attributes.get(i).name().equals(attributes.get(attributes.size() - 1))) {
				instance.setValue(i, -1);
			} else {
				instance.setValue(i, measurementHowSeeWiFi(meas, attributes.get(i).name()));
			}

		}
		LOG.info("The created instance is " + instance);
		return instance;
	}

	private int measurementSeeBluetooth(Measurement meas, String bluetooth) {
		String hardwareAddress = getBluetoothHardwareAddress(bluetooth);
		if(meas.getBluetoothTags() != null){
		Set<String> measurementBluetoothTags = meas.getBluetoothTags().getTags();
		for (String bl : measurementBluetoothTags) {
			if (bl.toUpperCase().contains(hardwareAddress.toUpperCase())) {
				return 1;
			}
		}}
		return 0;
	}

	private double measurementHowSeeWiFi(Measurement meas, String wifi) {
		if(meas.getWifiRSSI()!= null){
		if (meas.getWifiRSSI().getRssiValues().containsKey(wifi)) {
			return meas.getWifiRSSI().getRSSI(wifi);
		}}
		return -100;
	}

	private String getBluetoothHardwareAddress(String bluetooth) {
		String[] bluetoothAddress = bluetooth.split(":");
		StringBuilder builder = new StringBuilder();
		builder.append(bluetoothAddress[0].substring(bluetoothAddress[0].length() - 2, bluetoothAddress[0].length()));
		builder.append(":");
		for (int i = 1; i < bluetoothAddress.length; i++) {
			builder.append(bluetoothAddress[i]);
			builder.append(":");
		}
		builder.setLength(builder.length() - 1);
		String result = builder.toString();
		return result;
	}

	/*
	 * private ArrayList<String> getClassValues(MultilayerPerceptron mlp){ try {
	 * Field field = MultilayerPerceptron.class.getDeclaredField("m_instances");
	 * field.setAccessible(true); Object value = field.get(mlp);
	 * field.setAccessible(false); Instances header = (Instances) value;
	 * 
	 * ArrayList<Attribute> attributes = new ArrayList<Attribute>(); for (int i
	 * = 0; i < header.numAttributes(); i++) {
	 * attributes.add(header.attribute(i)); } int classIndex =
	 * header.classIndex(); Enumeration<Object> values =
	 * attributes.get(classIndex).enumerateValues(); ArrayList<String>
	 * classValues = new ArrayList<String>(); while(values.hasMoreElements()){
	 * classValues.add(values.nextElement().toString()); } return classValues; }
	 * catch (NoSuchFieldException e) { throw new RuntimeException(e); } catch
	 * (IllegalAccessException e) { throw new RuntimeException(e); } }
	 */

	private ArrayList<Attribute> getHeader(MultilayerPerceptron mlp) {
		try {
			Field field = MultilayerPerceptron.class.getDeclaredField("m_instances");
			field.setAccessible(true);
			Object value = field.get(mlp);
			field.setAccessible(false);
			Instances header = (Instances) value;

			ArrayList<Attribute> attributes = new ArrayList<Attribute>();
			for (int i = 0; i < header.numAttributes(); i++) {
				attributes.add(header.attribute(i));
			}
			return attributes;
		} catch (NoSuchFieldException e) {
			throw new RuntimeException(e);
		} catch (IllegalAccessException e) {
			throw new RuntimeException(e);
		}
	}

}