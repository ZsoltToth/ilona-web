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
public class TrackingModuleCentralManager {

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

	/*
	 * Time intervals in milliseconds: 1 hour: 3600000L 1 day: 86400000L 1 week:
	 * 604800000L 1 month: 2678400000L 1 year: 31536000000L
	 */
	public static final long oneHourInMilliseconds = 3_600_000L;

	public static final long oneDayInMiliseconds = 86_400_000L;

	public static final long oneWeekInMilliseconds = 604_800_000L;

	public static final long oneMonthInMilliseconds = 2_678_400_000L;

	public static final long oneYearInMilliseconds = 31_536_000_000L;

	/*
	 * Threading lock tokens.
	 */

	private Object accountExpirationTimeLock = new Object();

	private Object credentialsValidityPeriodLock = new Object();

	private Object passwordRecoveryTokenValidityTimeLock = new Object();

	/*
	 * Ezt az egész osztályt több szálból is elérik, bár egy szerű doglokat
	 * tartalmaz Szálbiztosság tétel.
	 * 
	 */

	/**
	 * 
	 */
	private long accountExpirationTime = 31_536_000_000L;

	/**
	 * Credentials validity time in milliseconds.
	 */
	private long credentialsValidityPeriod = 31536000000L;

	/////////////////////////////////////////////////////////////////////////
	private static long badLoginsUpperBound = 10;

	/*
	 * Default: 1 hour
	 */
	private static long lockedTimeAfterBadLogins = 3600000L;

	private static boolean accountEnabledCheckState = true;

	private static boolean accountLockedCheckState = true;

	/*
	 * Default: one day
	 */
	private long passwordRecoveryTokenValidityTime = 86_400_000L;

	public long getCredentialsValidityPeriod() {
		synchronized (credentialsValidityPeriodLock) {
			return credentialsValidityPeriod;
		}

	}

	public void setCredentialsValidityPeriod(long credentialsValidityPeriod) {
		synchronized (credentialsValidityPeriodLock) {
			this.credentialsValidityPeriod = credentialsValidityPeriod;
		}
	}

	public long getPasswordRecoveryTokenValidityTime() {
		synchronized (passwordRecoveryTokenValidityTimeLock) {
			return passwordRecoveryTokenValidityTime;
		}

	}

	public void setPasswordRecoveryTokenValidityTime(long passwordRecoveryTokenValidityTime) {
		synchronized (passwordRecoveryTokenValidityTimeLock) {
			this.passwordRecoveryTokenValidityTime = passwordRecoveryTokenValidityTime;
		}
	}

	public long getAccountExpirationTime() {
		synchronized (accountExpirationTimeLock) {
			return accountExpirationTime;
		}

	}

	public void setAccountExpirationTime(long accountExpirationTime) {
		synchronized (accountExpirationTimeLock) {
			this.accountExpirationTime = accountExpirationTime;
		}
	}
}
