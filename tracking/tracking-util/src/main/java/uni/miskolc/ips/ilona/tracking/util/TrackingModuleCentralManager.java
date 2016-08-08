package uni.miskolc.ips.ilona.tracking.util;

/**
 * <h2>This class provides the center program flow managament for the tracking
 * system.</h2><br>
 * This class is responsible for managing the program flow in the system.<br>
 * In this class,the manager can change the behaviour of the modul.<br>
 * Example:<br>
 * -
 * 
 * @author Patrik / A5USl0
 *
 */
@Szalbiztossag
public class TrackingModuleCentralManager {

	/*
	 * Time intervals in milliseconds:
	 * 1 hour : 3600000L
	 * 1 day : 86400000L
	 */

	/*
	 * Ezt az egész osztályt több szálból is elérik, bár egy szerű doglokat
	 * tartalmaz Szálbiztosság tétel.
	 * 
	 */

	private static long badLoginsUpperBound = 10;

	/*
	 * Default: 1 hour
	 */
	private static long lockedTimeAfterBadLogins = 3600000L;

	
	private static boolean accountEnabledCheckState = true;
	
	private static boolean accountLockedCheckState = true;
	
	
	
	// szálbiztosság!!
	@Szalbiztossag
	public static void setNonExpiredState() {
		synchronized (TrackingModuleCentralManager.class) {

		}
	}

	/*
	 * user bejelentkezett és az admin megváltoztatta az adatait, akkor
	 * frissüljön a user is? kéne egy lista, amibe bele lehet tenni az adatokat
	 * és onnan kivenné a user dátum alapján a változtatás és így csak akkor
	 * frissíti, ha a bejelentkezés hamarabbi, mint a változtatás
	 * Map<String,Date> => Map<userid, módosítás dátuma>
	 */

	/*
	 * Mióta nem jelenetkezett be valaki, account expired engedélyezése és
	 * tiltása
	 */

	/*
	 * Account lockednek az engedélyezése és külön beállítás, hogy hány
	 * sikertelen próbálkozás után dobjon ki és mennyi legyen az az idő, amig
	 * nem évül el az egész
	 */

	/*
	 * user enabled ellenőrzése?! talán
	 */

	/*
	 * authorities ellenőrzése??
	 */
}
