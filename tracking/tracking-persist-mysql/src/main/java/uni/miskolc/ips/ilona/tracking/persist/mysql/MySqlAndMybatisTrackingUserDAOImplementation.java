package uni.miskolc.ips.ilona.tracking.persist.mysql;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.Collection;
import java.util.List;
import java.util.Properties;

import javax.xml.ws.RespectBinding;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Repository;

import uni.miskolc.ips.ilona.tracking.model.TrackingLoginUserData;
import uni.miskolc.ips.ilona.tracking.model.UserDetails;
import uni.miskolc.ips.ilona.tracking.persist.TrackingUserDAO;
import uni.miskolc.ips.ilona.tracking.persist.exception.TrackingUserAlreadyExists;
import uni.miskolc.ips.ilona.tracking.persist.exception.TrackingUserNotFoundException;

/**
 * 
 * @author ilona
 *
 */
@Repository()
public class MySqlAndMybatisTrackingUserDAOImplementation implements TrackingUserDAO {

	private static Logger logger = LogManager.getLogger(MySqlAndMybatisTrackingUserDAOImplementation.class);

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
	public MySqlAndMybatisTrackingUserDAOImplementation(final String configFilePath, final String host, final int port,
			final String database, final String user, final String password) throws FileNotFoundException {
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
	public void createUser(UserDetails user) throws TrackingUserAlreadyExists {
		SqlSession session = sessionFactory.openSession();
		try {
			TrackingUserMapper usermapper = session.getMapper(TrackingUserMapper.class);
			usermapper.createUser(user);
			usermapper.insertUserRoles(user);
			// TrackingMapper mapper = session.getMapper(TrackingMapper.class);
			// mapper.createUser(user);
			session.commit();
		} finally {
			session.close();
		}
	}

	@Override
	public UserDetails getUser(String userid) throws TrackingUserNotFoundException {

		SqlSession session = sessionFactory.openSession();
		UserDetails userdetails = null;
		try {
			TrackingUserMapper mapper = session.getMapper(TrackingUserMapper.class);
			userdetails = mapper.getUser(userid);
		} finally {
			session.close();
		}
		return userdetails;
	}

	@Override
	public void updateUser(UserDetails user) throws TrackingUserNotFoundException {

	}

	@Override
	public void deleteUser(String userID) throws TrackingUserNotFoundException {

	}

	@Override
	public List<UserDetails> getAllUsers() {
		SqlSession session = sessionFactory.openSession();
		List<UserDetails> userList = null;
		try {
			TrackingUserMapper mapper = session.getMapper(TrackingUserMapper.class);
			userList = mapper.getAllUsers();
		} finally {
			session.close();
		}
		return userList;
	}

}
