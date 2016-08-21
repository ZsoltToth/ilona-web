package uni.miskolc.ips.ilona.tracking.controller.passwordrecovery;

import uni.miskolc.ips.ilona.tracking.model.PasswordRecoveryToken;

public interface PasswordTokenDAO {

	void storePasswordToken(PasswordRecoveryToken token);
	
	PasswordRecoveryToken loadPasswordToken(PasswordRecoveryToken passwordToken);
}
