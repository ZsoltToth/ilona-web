package uni.miskolc.ips.ilona.tracking.controller.passwordrecovery;

public interface PasswordTokenSender {

	void sendToken(String useid, String newPassword);
}
