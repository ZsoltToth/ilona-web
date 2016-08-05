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

import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;

import uni.miskolc.ips.ilona.tracking.model.DeviceData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.UserAndDeviceDAO;
import uni.miskolc.ips.ilona.tracking.persist.exception.DeviceAlreadyExistsException;
import uni.miskolc.ips.ilona.tracking.persist.exception.DeviceNotFoundException;
import uni.miskolc.ips.ilona.tracking.persist.exception.OperationExecutionErrorException;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserAlreadyExistsException;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserNotFoundException;
import uni.miskolc.ips.ilona.tracking.persist.mysql.mappers.UserAndDeviceMapper;

public class MySqlAndMybatisUserAndDeviceDAOImplementation implements UserAndDeviceDAO {

	SqlSessionFactory sessionFactory;

	/*
	 * !! SECURITY LAYER AMI AZ EGYES IGAZOLTATÁSOKAT VÉGEZNÉ MÉG MIELŐTT
	 * LEFUTNA AZ ADOTT PARANCS !!!
	 */

	public MySqlAndMybatisUserAndDeviceDAOImplementation() {

	}

	public MySqlAndMybatisUserAndDeviceDAOImplementation(final String configFilePath, final String host, final int port,
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

	/*
	 * USER CRUD PART
	 */

	@Override
	public void createUser(UserData user) throws UserAlreadyExistsException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			UserAndDeviceMapper mapper = session.getMapper(UserAndDeviceMapper.class);
			mapper.createUserBaseData(user);
			mapper.eraseUserRoles(user.getUserid());
			mapper.createUserRoles(user);
			// mapper.storeLoginAttempts(user); // még ránézni
			session.commit();

		} catch (Exception e) {
			if (e instanceof MySQLIntegrityConstraintViolationException) {
				throw new UserAlreadyExistsException("User already exists: " + user.getUserid());
			}
			throw new OperationExecutionErrorException(e.getMessage());
		} finally {
			session.close();
		}
	}

	@Override
	public UserData getUser(String userid) throws UserNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		UserData user = null;
		try {
			UserAndDeviceMapper mapper = session.getMapper(UserAndDeviceMapper.class);
			user = mapper.getUserBaseData(userid);
			user.setRoles(mapper.getUserRoles(userid));

			user.setBadLogins(mapper.readLoginAttempts(userid));
			user.setDevices(mapper.getUserDevices(user));
			// mapper.deleteLoginAttempts(userid, new Date());
			// session.commit();
			// Map<String, String> roles = mapper.getAllUsersRoles();
			/*
			 * for(Object o : roles) {
			 * System.out.println(o.getClass().getName()); }
			 */

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return user;
	}

	@Override
	public Collection<UserData> getAllUsers() throws OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		Collection<UserData> users = new ArrayList<UserData>();
		try {
			UserAndDeviceMapper mapper = session.getMapper(UserAndDeviceMapper.class);
			users = mapper.getAllUsersBaseData();
			for (UserData user : users) {
				user.setRoles(mapper.getUserRoles(user.getUserid()));
				user.setBadLogins(mapper.readLoginAttempts(user.getUserid()));
				user.setDevices(mapper.getUserDevices(user));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return users;
	}

	@Override
	public void updateUser(UserData user) throws UserNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			UserAndDeviceMapper mapper = session.getMapper(UserAndDeviceMapper.class);
			int values = mapper.updateUserBase(user);
			if (values == 0) {
				throw new UserNotFoundException();
			}
			session.commit();
		} catch (UserNotFoundException e) {
			throw new UserNotFoundException("This user is not exists: " + user.getUserid());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	@Override
	public void deleteUser(String userid) throws UserNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		int deletedUsers = 0;
		try {
			UserAndDeviceMapper mapper = session.getMapper(UserAndDeviceMapper.class);
			deletedUsers = mapper.deleteUser(userid);
			if (deletedUsers == 0) {
				throw new UserNotFoundException();
			}
			session.commit();
		} catch (UserNotFoundException e) {
			throw new UserNotFoundException("Error: User cannot be deleted because not found, userid: " + userid);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	/*
	 * DEVICE CRUD
	 */

	@Override
	public void storeDevice(DeviceData device, UserData user)
			throws DeviceAlreadyExistsException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			UserAndDeviceMapper mapper = session.getMapper(UserAndDeviceMapper.class);
			mapper.storeDevice(device, user);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	@Override
	public Collection<DeviceData> readUserDevices(UserData user) throws OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		Collection<DeviceData> devices = new ArrayList<DeviceData>();
		try {
			UserAndDeviceMapper mapper = session.getMapper(UserAndDeviceMapper.class);
			devices = mapper.getUserDevices(user);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return devices;
	}

	@Override
	public void updateDevice(DeviceData device, UserData user)
			throws DeviceNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			UserAndDeviceMapper mapper = session.getMapper(UserAndDeviceMapper.class);
			mapper.updateDevice(device, user);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

	@Override
	public void deleteDevice(DeviceData device, UserData user)
			throws DeviceNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			UserAndDeviceMapper mapper = session.getMapper(UserAndDeviceMapper.class);
			mapper.deleteDevice(device, user);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
	}

}
