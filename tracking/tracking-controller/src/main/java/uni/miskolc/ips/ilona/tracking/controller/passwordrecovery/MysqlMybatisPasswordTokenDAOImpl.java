package uni.miskolc.ips.ilona.tracking.controller.passwordrecovery;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import uni.miskolc.ips.ilona.tracking.controller.exception.PasswordRecoveryTokenRestoreErrorException;
import uni.miskolc.ips.ilona.tracking.controller.exception.PasswordRecoveryTokenStorageErrorException;
import uni.miskolc.ips.ilona.tracking.model.PasswordRecoveryToken;
import uni.miskolc.ips.ilona.tracking.persist.SecurityFunctionsDAO;

public class MysqlMybatisPasswordTokenDAOImpl implements PasswordTokenDAO {

	private static Logger logger = LogManager.getLogger(MysqlMybatisPasswordTokenDAOImpl.class);

	private SecurityFunctionsDAO tokenRecoveryManager;

	public MysqlMybatisPasswordTokenDAOImpl() {

	}

	public MysqlMybatisPasswordTokenDAOImpl(SecurityFunctionsDAO tokenRecoveryManager) {
		this.tokenRecoveryManager = tokenRecoveryManager;
	}

	@Override
	public void storePasswordToken(PasswordRecoveryToken token) throws PasswordRecoveryTokenStorageErrorException {
		try {
			tokenRecoveryManager.storePasswordResetToken(token);
		} catch (Exception e) {
			String messageUserid = "NULL";
			String messageToken = "NULL";
			if (token != null) {
				messageUserid = token.getUserid();
				messageToken = token.getToken();
			}
			logger.error("Recovery token storage failed! userid: " + messageUserid + " token: " + messageToken
					+ " Error: " + e.getMessage());
			throw new PasswordRecoveryTokenStorageErrorException("Recovery token storage failed! userid: "
					+ messageUserid + " token: " + messageToken + " Error: " + e.getMessage(), e);
		}

	}

	@Override
	public PasswordRecoveryToken loadPasswordToken(PasswordRecoveryToken passwordToken)
			throws PasswordRecoveryTokenRestoreErrorException {
		PasswordRecoveryToken token = null;
		try {
			token = tokenRecoveryManager.restorePasswordResetToken(passwordToken);
		} catch (Exception e) {
			String messageUserid = "NULL";
			String messageToken = "NULL";
			if (token != null) {
				messageUserid = token.getUserid();
				messageToken = token.getToken();
			}
			logger.error("Recovery token restore failed! userid: " + messageUserid + " token: " + messageToken
					+ " Error: " + e.getMessage());
			throw new PasswordRecoveryTokenRestoreErrorException("Recovery token restore failed! userid: "
					+ messageUserid + " token: " + messageToken + " Error: " + e.getMessage(), e);
		}
		return token;
	}

}
