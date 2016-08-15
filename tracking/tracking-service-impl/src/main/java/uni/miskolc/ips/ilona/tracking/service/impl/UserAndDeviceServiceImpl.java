package uni.miskolc.ips.ilona.tracking.service.impl;

import java.util.Collection;

import uni.miskolc.ips.ilona.tracking.model.DeviceData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.UserAndDeviceDAO;
import uni.miskolc.ips.ilona.tracking.persist.exception.UserAlreadyExistsException;
import uni.miskolc.ips.ilona.tracking.service.UserAndDeviceService;
import uni.miskolc.ips.ilona.tracking.service.exceptions.DeviceNotFoundException;
import uni.miskolc.ips.ilona.tracking.service.exceptions.DuplicatedDeviceException;
import uni.miskolc.ips.ilona.tracking.service.exceptions.DuplicatedUserException;
import uni.miskolc.ips.ilona.tracking.service.exceptions.ServiceGeneralErrorException;
import uni.miskolc.ips.ilona.tracking.service.exceptions.UserNotFoundException;

public class UserAndDeviceServiceImpl implements UserAndDeviceService {

	private UserAndDeviceDAO userDeviceDAO;

	public UserAndDeviceServiceImpl() {
		this.userDeviceDAO = null;
	}

	public UserAndDeviceServiceImpl(UserAndDeviceDAO dao) {
		this.userDeviceDAO = dao;
	}

	@Override
	public void createUser(UserData user) throws DuplicatedUserException, ServiceGeneralErrorException {
		try {
			userDeviceDAO.createUser(user);
		} catch (UserAlreadyExistsException e) {
			// log1
			throw new DuplicatedUserException("DUPLICATED USER WITH NAME: " + user.getUserid(), e);
		} catch (Exception e) {
			// log2
			throw new ServiceGeneralErrorException("General error: " + e.getMessage(), e);
		}

	}

	@Override
	public UserData getUser(String userid) throws UserNotFoundException, ServiceGeneralErrorException {
		UserData user = null;

		try {
			user = userDeviceDAO.getUser(userid);
		} catch (Exception e) {

		}
		return user;
	}

	@Override
	public Collection<UserData> getAllUsers() throws ServiceGeneralErrorException {
		Collection<UserData> users = null;

		try {
			users = userDeviceDAO.getAllUsers();
		} catch (Exception e) {

		}
		return users;
	}

	@Override
	public void updateUser(UserData user) throws UserNotFoundException, ServiceGeneralErrorException {
		;

		try {
			userDeviceDAO.updateUser(user);
		} catch (Exception e) {

		}

	}

	@Override
	public void deleteUser(UserData user) throws UserNotFoundException, ServiceGeneralErrorException {
		try {
			userDeviceDAO.deleteUser(user.getUserid());
		} catch (Exception e) {

		}

	}

	@Override
	public void storeDevice(DeviceData device, UserData user)
			throws UserNotFoundException, DuplicatedDeviceException, ServiceGeneralErrorException {

		try {
			userDeviceDAO.storeDevice(device, user);
		} catch (Exception e) {

		}

	}

	@Override
	public Collection<DeviceData> readUserDevices(UserData user)
			throws UserNotFoundException, ServiceGeneralErrorException {
		Collection<DeviceData> devices = null;
		try {
			devices = userDeviceDAO.readUserDevices(user);
		} catch (Exception e) {

		}
		return devices;
	}

	@Override
	public void updateDevice(DeviceData device, UserData user)
			throws DeviceNotFoundException, UserNotFoundException, ServiceGeneralErrorException {
		try {
			userDeviceDAO.updateDevice(device, user);
		} catch (Exception e) {

		}

	}

	@Override
	public void deleteDevice(DeviceData device, UserData user)
			throws DeviceNotFoundException, UserNotFoundException, ServiceGeneralErrorException {

		try {
			userDeviceDAO.deleteDevice(device, user);
		} catch (Exception e) {

		}

	}

}