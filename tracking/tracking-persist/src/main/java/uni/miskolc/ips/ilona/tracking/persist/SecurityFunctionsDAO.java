package uni.miskolc.ips.ilona.tracking.persist;

import java.util.Collection;
import java.util.Date;

import org.springframework.security.core.userdetails.UsernameNotFoundException;

import uni.miskolc.ips.ilona.tracking.persist.exception.OperationExecutionErrorException;

public interface SecurityFunctionsDAO {

	public void updatePassword(String userid, String hashedPassword)
			throws UsernameNotFoundException, OperationExecutionErrorException;

	public void updateEnabled(String userid, Boolean enabled)
			throws UsernameNotFoundException, OperationExecutionErrorException;

	public void updateAccountExpiration(String userid, Date expiration)
			throws UsernameNotFoundException, OperationExecutionErrorException;

	public void updateRoles(String userid, Collection<String> roles)
			throws UsernameNotFoundException, OperationExecutionErrorException;

	public void updateBadLogins(String userid, Collection<Date> badLogins)
			throws UsernameNotFoundException, OperationExecutionErrorException;

	public void updateLockedAndUntilLocked(String userid, Boolean nonLocked, Date lockedUntil)
			throws UsernameNotFoundException, OperationExecutionErrorException;

	public void updateLockedStatus(String userid, Boolean nonLocked, Date lockedUntil, Collection<Date> badLogins)
			throws UsernameNotFoundException, OperationExecutionErrorException;
}
