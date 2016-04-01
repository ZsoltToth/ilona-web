package uni.miskolc.ips.ilona.navigation.persist;

import uni.miskolc.ips.ilona.navigation.model.ZoneMap;
import uni.miskolc.ips.ilona.navigation.persist.exceptions.ConnectionFailedException;
import uni.miskolc.ips.ilona.navigation.persist.exceptions.InstancingFailedException;
import uni.miskolc.ips.ilona.navigation.persist.exceptions.MapAlreadyExistsException;
import uni.miskolc.ips.ilona.navigation.persist.exceptions.NoSuchMapException;
import uni.miskolc.ips.ilona.navigation.persist.exceptions.RedundantMapException;
import uni.miskolc.ips.ilona.navigation.persist.exceptions.SavingFailedException;
import uni.miskolc.ips.ilona.navigation.persist.exceptions.WrongFormatException;
import uni.miskolc.ips.ilona.navigation.persist.exceptions.ZoneNotFoundException;

public interface CRUDInterface {

	public void createMap(ZoneMap map)
			throws MapAlreadyExistsException, RedundantMapException, ConnectionFailedException, SavingFailedException;

	public ZoneMap readMap(String mapName) throws NoSuchMapException, InstancingFailedException,
			ConnectionFailedException, ZoneNotFoundException, WrongFormatException;

	public void updateMap(ZoneMap map) throws NoSuchMapException, SavingFailedException, ConnectionFailedException;

	public void deleteMap(String mapName) throws NoSuchMapException, SavingFailedException, ConnectionFailedException;

	public void deleteMap(ZoneMap map) throws NoSuchMapException, SavingFailedException, ConnectionFailedException;

}
