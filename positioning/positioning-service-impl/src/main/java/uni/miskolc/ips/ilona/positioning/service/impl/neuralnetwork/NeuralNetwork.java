package uni.miskolc.ips.ilona.positioning.service.impl.neuralnetwork;


import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.Serializable;

import weka.classifiers.evaluation.Evaluation;
import weka.classifiers.functions.MultilayerPerceptron;
import weka.core.Instances;

public class NeuralNetwork implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7283677675909544183L;
	private final double learningRate;
	private final double momentum;
	private final int trainingTime;
	private final String hiddenLayers;
	private MultilayerPerceptron mlp;

	public NeuralNetwork(double learningRate, double momentum, int trainingTime, String hiddenLayers,
			String trainingfilepath) throws FileNotFoundException, IOException, Exception {
		super();
		this.learningRate = learningRate;
		this.momentum = momentum;
		this.trainingTime = trainingTime;
		this.hiddenLayers = hiddenLayers;
		this.mlp = buildMultilayerPerceptron(trainingfilepath);

	}

	public double getEvaluation(String filepath) throws Exception {
		Instances instances = readInstances(filepath);
		Evaluation eval = new Evaluation(instances);
		eval.evaluateModel(mlp, instances);
		double errorRate = eval.errorRate();
		double result = (1 - errorRate) * 100;
		return result;
	}

	private MultilayerPerceptron buildMultilayerPerceptron(String trainingfilepath)
			throws Exception {
		Instances trainingInstances =readInstances(trainingfilepath);
		trainingInstances.setClassIndex(trainingInstances.numAttributes() - 1);
		MultilayerPerceptron mlp = new MultilayerPerceptron();
		mlp.setLearningRate(learningRate);
		mlp.setMomentum(momentum);
		mlp.setTrainingTime(trainingTime);
		mlp.setHiddenLayers(hiddenLayers);
		try {
			mlp.buildClassifier(trainingInstances);
		} catch (Exception e) {

		}
		return mlp;

	}

	private Instances readInstances(String filepath) throws IOException, FileNotFoundException {
		FileReader instancesreader = new FileReader(filepath);
		Instances instances = new Instances(instancesreader);
		instances.setClassIndex(instances.numAttributes() - 1);
		return instances;
	}

	public double getLearningRate() {
		return learningRate;
	}

	public double getMomentum() {
		return momentum;
	}

	public int getTrainingTime() {
		return trainingTime;
	}

	public String getHiddenLayers() {
		return hiddenLayers;
	}
	public MultilayerPerceptron getMultilayerPerceptron() {
		return mlp;
	}
	
	public void serializeNeuralNetwork(String targetPath) throws FileNotFoundException, IOException, Exception{

		try {
			FileOutputStream fileOut = new FileOutputStream(targetPath);
			ObjectOutputStream out = new ObjectOutputStream(fileOut);
			out.writeObject(this);
			out.close();
			fileOut.close();
			System.out.printf("Serialized data is saved in "+targetPath);
		} catch (IOException i) {
			i.printStackTrace();
		}

	}

}