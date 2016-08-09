package uni.miskolc.ips.ilona.tracking.persist;

import java.util.Collection;
import java.util.Date;

public interface SecurityFunctionsDAO {

	public void  updateUserBadLogins(String userid, Collection<Date> badLogin);
}
