package uni.miskolc.ips.ilona.tracking.persist.mysql;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.Collection;
import java.util.List;
import java.util.Properties;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import uni.miskolc.ips.ilona.measurement.model.position.Position;
import uni.miskolc.ips.ilona.tracking.model.database.DatabaseDeviceDatas;
import uni.miskolc.ips.ilona.tracking.model.database.DatabaseUserDatas;
import uni.miskolc.ips.ilona.tracking.persist.TrackingUserManagementAndTrackingServiceDAO;
import uni.miskolc.ips.ilona.tracking.persist.exception.DatabaseProblemException;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserAlreadyExists;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserNotFoundException;
import uni.miskolc.ips.ilona.tracking.persist.mysql.mappers.TrackingUserManagementAndServiceMapper;

/**
 * 
 * @author Patrik / A5USL0
 *
 */
public class MySqlAndMybatisTrackingUserAndTrackingServiceDAOImplementation
		implements TrackingUserManagementAndTrackingServiceDAO {

	private static Logger logger = LogManager
			.getLogger(MySqlAndMybatisTrackingUserAndTrackingServiceDAOImplementation.class);

	private SqlSessionFactory sessionFactory;

	public MySqlAndMybatisTrackingUserAndTrackingServiceDAOImplementation() {
		// TODO Auto-generated constructor stub
	}

	public MySqlAndMybatisTrackingUserAndTrackingServiceDAOImplementation(final String configFilePath,
			final String host, final int port, final String database, final String user, final String password)
			throws FileNotFoundException {
		File configFile = new File(configFilePath);
		// new File("src/main/resources/mybatis-configuration.xml");
		InputStream inputStream = new FileInputStream(configFile);
		String urlPattern = "jdbc:mysql://%s:%s/%s";
		String connectionURL = String.format(urlPattern, host, port, database);
		Properties props = new Properties();
		props.put("driver", "com.mysql.jdbc.Driver");
		props.put("url", connectionURL);
		props.put("username", user);
		props.put("password", password);

		this.sessionFactory = (new SqlSessionFactoryBuilder()).build(inputStream, props);
	}

	@Override
	public void createUser(DatabaseUserDatas userdata) throws UserAlreadyExists {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void createUsers(Collection<DatabaseUserDatas> users) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public DatabaseUserDatas getUser(String userid) throws UserNotFoundException {
		SqlSession session = sessionFactory.openSession();
		DatabaseUserDatas data = null;
		try {
			TrackingUserManagementAndServiceMapper mapper = session
					.getMapper(TrackingUserManagementAndServiceMapper.class);
			data = mapper.getUser("user1");
		} finally {
			session.close();
		}
		return data;
	}

	@Override
	public Collection<DatabaseUserDatas> getUsers(Collection<String> users) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Collection<DatabaseUserDatas> getAllUsers() throws DatabaseProblemException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateUser(DatabaseUserDatas userdata) throws UserNotFoundException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateUsers(Collection<DatabaseUserDatas> userdatas) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteUser(String userid) throws UserNotFoundException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delelteUsers(Collection<String> userids) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void storeDevice(DatabaseDeviceDatas deviceData) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void storeDevices(Collection<DatabaseDeviceDatas> devices) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public DatabaseDeviceDatas getDeviceByUserid(String userid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<DatabaseDeviceDatas> getUserDevicesByUserid(String userid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Collection<DatabaseDeviceDatas> getAllDevices() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateDevice(DatabaseDeviceDatas device) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateDevices(Collection<DatabaseDeviceDatas> devices) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteDevice(DatabaseDeviceDatas device) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteDevices(Collection<DatabaseDeviceDatas> devices) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Position getPositionByUUID() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Position> getDevicesPositions(DatabaseDeviceDatas device) {
		// TODO Auto-generated method stub
		return null;
	}

	

}
