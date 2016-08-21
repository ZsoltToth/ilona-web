package uni.miskolc.ips.ilona.tracking.controller.passwordrecovery;

public interface PasswordRecoveryManager {

	void handlePasswordRecoveryRequest(String userid);
	
	void handlePasswordRestore(String userid, String token);
}
