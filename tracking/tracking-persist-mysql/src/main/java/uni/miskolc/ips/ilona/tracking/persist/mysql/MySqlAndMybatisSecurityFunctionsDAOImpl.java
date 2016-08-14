package uni.miskolc.ips.ilona.tracking.persist.mysql;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Properties;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import uni.miskolc.ips.ilona.tracking.model.PasswordRecoveryToken;
import uni.miskolc.ips.ilona.tracking.persist.SecurityFunctionsDAO;
import uni.miskolc.ips.ilona.tracking.persist.exception.OperationExecutionErrorException;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserNotFoundException;
import uni.miskolc.ips.ilona.tracking.persist.mysql.mappers.SecurityFunctionsUserMapper;

public class MySqlAndMybatisSecurityFunctionsDAOImpl implements SecurityFunctionsDAO {

	private static Logger logger = LogManager.getLogger(MySqlAndMybatisSecurityFunctionsDAOImpl.class);

	private SqlSessionFactory sessionFactory;

	public MySqlAndMybatisSecurityFunctionsDAOImpl() {

	}

	public MySqlAndMybatisSecurityFunctionsDAOImpl(final String host, final int port, final String database,
			final String user, final String password) throws FileNotFoundException {
		ClassLoader loader = getClass().getClassLoader();
		InputStream inputStream = loader.getResourceAsStream("mybatis-configuration.xml");

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
	public void updatePassword(String userid, String hashedPassword)
			throws UserNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			SecurityFunctionsUserMapper mapper = session.getMapper(SecurityFunctionsUserMapper.class);
			int updated = mapper.updatePassword(userid, hashedPassword);
			if (updated == 0) {
				throw new UserNotFoundException();
			}
			session.commit();
		} catch (Exception e) {
			if (e instanceof UserNotFoundException) {
				logger.error("User has not found with id: " + userid + "  Error: " + e.getMessage());
				throw new UsernameNotFoundException(
						"User has not found with id: " + userid + "  Error: " + e.getMessage());
			}
			logger.error("Error: " + e.getMessage());
			throw new OperationExecutionErrorException("Error: " + e.getMessage());
		} finally {
			session.close();
		}
	}

	@Override
	public void updateEnabled(String userid, Boolean enabled)
			throws UserNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			SecurityFunctionsUserMapper mapper = session.getMapper(SecurityFunctionsUserMapper.class);
			int updated = mapper.updateEnabled(userid, enabled);
			if (updated == 0) {
				throw new UserNotFoundException();
			}
			session.commit();
		} catch (Exception e) {
			if (e instanceof UserNotFoundException) {
				logger.error("User has not found with id: " + userid + "  Error: " + e.getMessage());
				throw new UsernameNotFoundException(
						"User has not found with id: " + userid + "  Error: " + e.getMessage());
			}
			logger.error("Error: " + e.getMessage());
			throw new OperationExecutionErrorException("Error: " + e.getMessage());
		} finally {
			session.close();
		}

	}

	@Override
	public void updateAccountExpiration(String userid, Date expiration)
			throws UserNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			SecurityFunctionsUserMapper mapper = session.getMapper(SecurityFunctionsUserMapper.class);
			int updated = mapper.updateAccountExpiration(userid, expiration);
			if (updated == 0) {
				throw new UserNotFoundException();
			}
			session.commit();
		} catch (Exception e) {
			if (e instanceof UserNotFoundException) {
				logger.error("User has not found with id: " + userid + "  Error: " + e.getMessage());
				throw new UsernameNotFoundException(
						"User has not found with id: " + userid + "  Error: " + e.getMessage());
			}
			logger.error("Error: " + e.getMessage());
			throw new OperationExecutionErrorException("Error: " + e.getMessage());
		} finally {
			session.close();
		}
	}

	@Override
	public void updateRoles(String userid, Collection<String> roles)
			throws UserNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			SecurityFunctionsUserMapper mapper = session.getMapper(SecurityFunctionsUserMapper.class);
			int updated = mapper.eraseRoles(userid);
			if (updated == 0) {
				throw new UserNotFoundException();
			}
			updated = mapper.insertRoles(userid, roles);
			if (updated == 0) {
				throw new OperationExecutionErrorException();
			}
			session.commit();
		} catch (Exception e) {
			if (e instanceof UserNotFoundException) {
				logger.error("User has not found with id: " + userid + "  Error: " + e.getMessage());
				throw new UsernameNotFoundException(
						"User has not found with id: " + userid + "  Error: " + e.getMessage());
			}
			logger.error("Error: " + e.getMessage());
			throw new OperationExecutionErrorException("Error: " + e.getMessage());
		} finally {
			session.close();
		}
	}

	@Override
	public void eraseBadLogins(String userid) throws UserNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			SecurityFunctionsUserMapper mapper = session.getMapper(SecurityFunctionsUserMapper.class);
			int updated = mapper.eraseBadLogins(userid);
			if (updated == 0) {
				throw new UserNotFoundException();
			}
			session.commit();
		} catch (Exception e) {
			if (e instanceof UserNotFoundException) {
				logger.error("User has not found with id: " + userid + "  Error: " + e.getMessage());
				throw new UsernameNotFoundException(
						"User has not found with id: " + userid + "  Error: " + e.getMessage());
			}
			logger.error("Error: " + e.getMessage());
			throw new OperationExecutionErrorException("Error: " + e.getMessage());
		} finally {
			session.close();
		}
	}

	@Override
	public void updateBadLogins(String userid, Collection<Date> badLogins)
			throws UsernameNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			SecurityFunctionsUserMapper mapper = session.getMapper(SecurityFunctionsUserMapper.class);
			int updated = mapper.eraseBadLogins(userid);
			if (updated == 0) {
				throw new UserNotFoundException();
			}
			Collection<Double> millisecondsDate = new ArrayList<Double>();
			for (Date date : badLogins) {
				millisecondsDate.add(date.getTime() * 0.001);
			}
			updated = mapper.insertBadLogins(userid, millisecondsDate);
			if (updated == 0) {
				throw new OperationExecutionErrorException();
			}
			session.commit();
		} catch (Exception e) {
			if (e instanceof UserNotFoundException) {
				logger.error("User has not found with id: " + userid + "  Error: " + e.getMessage());
				throw new UsernameNotFoundException(
						"User has not found with id: " + userid + "  Error: " + e.getMessage());
			}
			logger.error("Error: " + e.getMessage());
			throw new OperationExecutionErrorException("Error: " + e.getMessage());
		} finally {
			session.close();
		}
	}

	@Override
	public void updateLockedAndUntilLocked(String userid, Boolean nonLocked, Date lockedUntil, boolean deleteBadLogins)
			throws UsernameNotFoundException, OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			SecurityFunctionsUserMapper mapper = session.getMapper(SecurityFunctionsUserMapper.class);
			Double millisecDate = lockedUntil.getTime() * 0.001;
			int updated = mapper.updateLockedAndUntilLocked(userid, nonLocked, millisecDate);
			if (updated == 0) {
				throw new UserNotFoundException();
			}
			if(deleteBadLogins == true) {
				mapper.eraseBadLogins(userid);
			}
			session.commit();
		} catch (Exception e) {
			if (e instanceof UserNotFoundException) {
				logger.error("User has not found with id: " + userid + "  Error: " + e.getMessage());
				throw new UsernameNotFoundException(
						"User has not found with id: " + userid + "  Error: " + e.getMessage());
			}
			logger.error("Error: " + e.getMessage());
			throw new OperationExecutionErrorException("Error: " + e.getMessage());
		} finally {
			session.close();
		}
	}

	@Override
	public void storePasswordResetToken(PasswordRecoveryToken token) throws OperationExecutionErrorException {
		SqlSession session = sessionFactory.openSession();
		try {
			
		} finally {
			// TODO: handle finally clause
		}
		
	}

	@Override
	public void restorePasswordResetToken(String token) {
		// TODO Auto-generated method stub
		
	}

}
