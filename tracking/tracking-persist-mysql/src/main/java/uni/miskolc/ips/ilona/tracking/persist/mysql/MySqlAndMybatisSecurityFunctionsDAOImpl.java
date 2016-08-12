package uni.miskolc.ips.ilona.tracking.persist.mysql;

import java.util.Collection;
import java.util.Date;

import org.springframework.security.core.userdetails.UsernameNotFoundException;

import uni.miskolc.ips.ilona.tracking.persist.SecurityFunctionsDAO;
import uni.miskolc.ips.ilona.tracking.persist.exception.OperationExecutionErrorException;

public class MySqlAndMybatisSecurityFunctionsDAOImpl implements SecurityFunctionsDAO{

	@Override
	public void updatePassword(String userid, String hashedPassword)
			throws UsernameNotFoundException, OperationExecutionErrorException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateEnabled(String userid, Boolean enabled)
			throws UsernameNotFoundException, OperationExecutionErrorException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateAccountExpiration(String userid, Date expiration)
			throws UsernameNotFoundException, OperationExecutionErrorException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateRoles(String userid, Collection<String> roles)
			throws UsernameNotFoundException, OperationExecutionErrorException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateBadLogins(String userid, Collection<Date> badLogins)
			throws UsernameNotFoundException, OperationExecutionErrorException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateLockedAndUntilLocked(String userid, Boolean nonLocked, Date lockedUntil)
			throws UsernameNotFoundException, OperationExecutionErrorException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateLockedStatus(String userid, Boolean nonLocked, Date lockedUntil, Collection<Date> badLogins)
			throws UsernameNotFoundException, OperationExecutionErrorException {
		// TODO Auto-generated method stub
		
	}

}
