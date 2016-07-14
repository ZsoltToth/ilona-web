package uni.miskolc.ips.ilona.tracking.persist.mysql;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import java.util.Properties;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import uni.miskolc.ips.ilona.tracking.model.TrackingLoginUserData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.TrackingDAO;

public class MySQLTrackingDAO implements TrackingDAO {

	/**
	 * 
	 */
	private final Logger LOG = LogManager.getLogger(MySQLTrackingDAO.class);
	
	/**
	 * 
	 */
	private SqlSessionFactory sessionFactory;
	
	/**
	 * 
	 * @param configFilePath
	 * @param host
	 * @param port
	 * @param database
	 * @param user
	 * @param password
	 * @throws FileNotFoundException
	 */
	public MySQLTrackingDAO(final String configFilePath, final String host, final int port, final String database,
			final String user, final String password) throws FileNotFoundException {
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
	public void createUser(UserData user) {
		SqlSession session = sessionFactory.openSession();
		try {
			TrackingMapper mapper = session.getMapper(TrackingMapper.class);
			mapper.createUser(user);
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public TrackingLoginUserData getUser(String userID) {
		TrackingLoginUserData result = null;
		SqlSession session = sessionFactory.openSession();
		try {
			TrackingMapper mapper = session.getMapper(TrackingMapper.class);
			result = mapper.getUser(userID);
			// session.commit();
		} finally {
			session.close();
		}
		return result;
	}

	@Override
	public void updateUser(UserData user) {
		SqlSession session = sessionFactory.openSession();
		try {
			TrackingMapper mapper = session.getMapper(TrackingMapper.class);
			mapper.updateUser(user);
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public void deleteUser(String userID) {
		SqlSession session = sessionFactory.openSession();
		try {
			TrackingMapper mapper = session.getMapper(TrackingMapper.class);
			mapper.deleteUser(userID);
			session.commit();
		} finally {
			session.close();
		}
	}

}