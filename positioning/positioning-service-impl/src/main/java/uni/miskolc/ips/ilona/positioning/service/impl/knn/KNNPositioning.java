package uni.miskolc.ips.ilona.positioning.service.impl.knn;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import uni.miskolc.ips.ilona.measurement.model.measurement.Measurement;
import uni.miskolc.ips.ilona.measurement.model.measurement.MeasurementDistanceCalculator;
import uni.miskolc.ips.ilona.measurement.model.position.Position;
import uni.miskolc.ips.ilona.measurement.persist.MeasurementDAO;
import uni.miskolc.ips.ilona.measurement.persist.PositionDAO;
import uni.miskolc.ips.ilona.positioning.service.PositioningService;

public class KNNPositioning implements PositioningService {

	private static final Logger LOG = LogManager
			.getLogger(KNNPositioning.class);

	private PositionDAO zoneDAO;
	private MeasurementDAO measurementDAO;
	private MeasurementDistanceCalculator distanceCalculator;
	private int k;

	public KNNPositioning(PositionDAO zoneDAO, MeasurementDAO measurementDAO,
			MeasurementDistanceCalculator distanceCalculator, int k) {
		super();
		this.zoneDAO = zoneDAO;
		this.measurementDAO = measurementDAO;
		this.distanceCalculator = distanceCalculator;
		this.k = k;
	}

	public int getK() {
		return k;
	}

	public void setK(int k) {
		LOG.info(String.format("k has bet set from %d to %d", this.k, k));
		this.k = k;
	}

	public Position determinePosition(Measurement measurement) {
		// TODO Auto-generated method stub
		return null;
	}

}
