package uni.miskolc.ips.ilona.tracking.controller.passwordrecovery;

import uni.miskolc.ips.ilona.tracking.model.PasswordRecoveryToken;
import uni.miskolc.ips.ilona.tracking.persist.SecurityFunctionsDAO;

public class MysqlMybatisPasswordTokenDAOImpl implements PasswordTokenDAO {

	private SecurityFunctionsDAO tokenRecoveryManager;

	public MysqlMybatisPasswordTokenDAOImpl() {

	}

	public MysqlMybatisPasswordTokenDAOImpl(SecurityFunctionsDAO tokenRecoveryManager) {
		this.tokenRecoveryManager = tokenRecoveryManager;
	}

	@Override
	public void storePasswordToken(PasswordRecoveryToken token) {
		try {
			tokenRecoveryManager.storePasswordResetToken(token);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public PasswordRecoveryToken loadPasswordToken(PasswordRecoveryToken token) {
		try {
			return tokenRecoveryManager.restorePasswordResetToken(token);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
