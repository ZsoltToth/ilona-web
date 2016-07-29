package uni.miskolc.ips.ilona.tracking.service.impl;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;

import uni.miskolc.ips.ilona.tracking.model.database.DatabaseDeviceDatas;
import uni.miskolc.ips.ilona.tracking.model.database.DatabaseUserDatas;
import uni.miskolc.ips.ilona.tracking.persist.TrackingUserManagementAndTrackingServiceDAO;
import uni.miskolc.ips.ilona.tracking.service.TrackingUserManagementAndTrackingService;

public class TrackingUserManagementAndTrackingServiceImpl implements TrackingUserManagementAndTrackingService {

	private TrackingUserManagementAndTrackingServiceDAO userAndTrackingDAO;

	/**
	 * Serializaton, ModelAttribute, IoC
	 */
	public TrackingUserManagementAndTrackingServiceImpl() {

	}

	public TrackingUserManagementAndTrackingServiceImpl(
			TrackingUserManagementAndTrackingServiceDAO userAndTrackingDAO) {
		this.userAndTrackingDAO = userAndTrackingDAO;
	}

	@Override
	public void createUser(DatabaseUserDatas userdata) {
		try {
			userAndTrackingDAO.createUser(userdata);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public DatabaseUserDatas getUser(String userid) {
		DatabaseUserDatas user = new DatabaseUserDatas();
		try {
			user = userAndTrackingDAO.getUser(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public Collection<DatabaseUserDatas> getAllUsers() {
		Collection<DatabaseUserDatas> users = new ArrayList<DatabaseUserDatas>();
		try {
			users = userAndTrackingDAO.getAllUsers();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return users;
	}

	@Override
	public void updateUser(DatabaseUserDatas userdata) {
		try {
			userAndTrackingDAO.updateUser(userdata);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void deleteUser(String userid) {
		try {
			userAndTrackingDAO.deleteUser(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void storeDevice(DatabaseDeviceDatas deviceData) {
		try {
			userAndTrackingDAO.storeDevice(deviceData);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public Collection<DatabaseDeviceDatas> getDeviceByUserid(String userid) {
		Collection<DatabaseDeviceDatas> devices = new ArrayList<DatabaseDeviceDatas>();
		try {
			devices = userAndTrackingDAO.getDeviceByUserid(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return devices;
	}

	@Override
	public Collection<DatabaseDeviceDatas> getAllDevices() {
		Collection<DatabaseDeviceDatas> devices = new ArrayList<DatabaseDeviceDatas>();
		try {
			devices = userAndTrackingDAO.getAllDevices();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return devices;
	}

	@Override
	public void updateDevice(DatabaseDeviceDatas device) {
		try {
			userAndTrackingDAO.updateDevice(device);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteDevice(DatabaseDeviceDatas device) {
		try {
			userAndTrackingDAO.deleteDevice(device);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
