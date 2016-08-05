package uni.miskolc.ips.ilona.tracking.persist.mysql;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Properties;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import uni.miskolc.ips.ilona.tracking.model.database.DatabaseDeviceDatas;
import uni.miskolc.ips.ilona.tracking.model.database.DatabaseUserDatas;
import uni.miskolc.ips.ilona.tracking.persist.exception.DatabaseProblemException;
import uni.miskolc.ips.ilona.tracking.persist.exception.OperationExecutionErrorException;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserAlreadyExistsException;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserNotFoundException;
import uni.miskolc.ips.ilona.tracking.persist.mysql.mappers.TrackingUserManagementAndServiceMapper;

/**
 * 
 * @author Patrik / A5USL0
 *
 */
public class MySqlAndMybatisTrackingUserAndTrackingServiceDAOImplementation {

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

	public void createUser(DatabaseUserDatas userdata)
			throws UserAlreadyExistsException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			TrackingUserManagementAndServiceMapper mapper = session
					.getMapper(TrackingUserManagementAndServiceMapper.class);
			mapper.createUser(userdata);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}

	}

	public DatabaseUserDatas getUser(String userid) throws UserNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		DatabaseUserDatas data = null;
		try {
			TrackingUserManagementAndServiceMapper mapper = session
					.getMapper(TrackingUserManagementAndServiceMapper.class);
			data = mapper.getUser("user1");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return data;
	}

	public Collection<DatabaseUserDatas> getAllUsers()
			throws DatabaseProblemException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		Collection<DatabaseUserDatas> users = new ArrayList<DatabaseUserDatas>();
		try {
			TrackingUserManagementAndServiceMapper mapper = session
					.getMapper(TrackingUserManagementAndServiceMapper.class);
			users = mapper.getAllUsers();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return users;
	}

	public void updateUser(DatabaseUserDatas userdata) throws UserNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			TrackingUserManagementAndServiceMapper mapper = session
					.getMapper(TrackingUserManagementAndServiceMapper.class);
			mapper.updateUser(userdata);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	public void deleteUser(String userid) throws UserNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			TrackingUserManagementAndServiceMapper mapper = session
					.getMapper(TrackingUserManagementAndServiceMapper.class);
			mapper.deleteUser(userid);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}

	}

	public void storeDevice(DatabaseDeviceDatas deviceData) {
		SqlSession session = sessionFactory.openSession();
		try {
			TrackingUserManagementAndServiceMapper mapper = session
					.getMapper(TrackingUserManagementAndServiceMapper.class);
			mapper.storeDevice(deviceData);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}

	}

	public Collection<DatabaseDeviceDatas> getDeviceByUserid(String userid) {
		SqlSession session = sessionFactory.openSession();
		Collection<DatabaseDeviceDatas> devices = new ArrayList<DatabaseDeviceDatas>();
		try {
			TrackingUserManagementAndServiceMapper mapper = session
					.getMapper(TrackingUserManagementAndServiceMapper.class);
			devices = mapper.getDevicesByUserid(userid);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return devices;
	}

	public Collection<DatabaseDeviceDatas> getAllDevices() {
		SqlSession session = sessionFactory.openSession();
		Collection<DatabaseDeviceDatas> devices = new ArrayList<DatabaseDeviceDatas>();
		try {
			TrackingUserManagementAndServiceMapper mapper = session
					.getMapper(TrackingUserManagementAndServiceMapper.class);
			devices = mapper.getAllDevices();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return devices;
	}

	public void updateDevice(DatabaseDeviceDatas device) {
		SqlSession session = sessionFactory.openSession();
		try {
			TrackingUserManagementAndServiceMapper mapper = session
					.getMapper(TrackingUserManagementAndServiceMapper.class);
			mapper.updateDevice(device);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}

	}

	public void deleteDevice(DatabaseDeviceDatas device) {
		SqlSession session = sessionFactory.openSession();
		try {
			TrackingUserManagementAndServiceMapper mapper = session
					.getMapper(TrackingUserManagementAndServiceMapper.class);
			mapper.deleteDevice(device);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}

	}

}
