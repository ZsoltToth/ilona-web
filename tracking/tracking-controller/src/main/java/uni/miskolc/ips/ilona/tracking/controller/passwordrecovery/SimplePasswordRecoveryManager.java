package uni.miskolc.ips.ilona.tracking.controller.passwordrecovery;

import java.util.Date;

import uni.miskolc.ips.ilona.tracking.model.PasswordRecoveryToken;

public class SimplePasswordRecoveryManager implements PasswordRecoveryManager {

	private PasswordTokenDAO tokenDAO;

	private PasswordTokenGenerator tokenGenerator;

	public SimplePasswordRecoveryManager() {

	}

	public SimplePasswordRecoveryManager(PasswordTokenDAO tokenDAO, PasswordTokenGenerator tokenGenerator) {
		this.tokenDAO = tokenDAO;
		this.tokenGenerator = tokenGenerator;
	}

	@Override
	public void handlePasswordRecoveryRequest(String userid) {
		String passwordToken = tokenGenerator.generateToken();
		// security manager !!!
		Date validUntil = new Date();
		PasswordRecoveryToken token = new PasswordRecoveryToken(userid, passwordToken, validUntil);
		tokenDAO.storePasswordToken(token);
		System.out.println("Success! :: handlePasswordRecoveryRequest " + validUntil.getTime());
	}

	@Override
	public void handlePasswordRestore(String userid, String passwordToken) {
		PasswordRecoveryToken token = new PasswordRecoveryToken(userid, passwordToken, null);
		PasswordRecoveryToken tok = tokenDAO.loadPasswordToken(token);
		System.out.println("Success! :: handlePasswordRestore " + tok.getTokenValidUntil().getTime());
	}

}
