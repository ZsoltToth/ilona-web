package uni.miskolc.ips.ilona.tracking.controller.passwordrecovery;

import uni.miskolc.ips.ilona.tracking.controller.exception.PasswordRecoveryException;
import uni.miskolc.ips.ilona.tracking.controller.exception.PasswordRecoveryTokenValidityErrorException;

public interface PasswordRecoveryManager {

	void handlePasswordRecoveryRequest(String userid) throws PasswordRecoveryException;

	void handlePasswordRestore(String userid, String token)
			throws PasswordRecoveryTokenValidityErrorException, PasswordRecoveryException;
}
