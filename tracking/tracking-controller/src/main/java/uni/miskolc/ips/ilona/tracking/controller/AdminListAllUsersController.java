package uni.miskolc.ips.ilona.tracking.controller;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.model.UserBaseDetailsDTO;
import uni.miskolc.ips.ilona.tracking.controller.model.UserDeviceDataDTO;
import uni.miskolc.ips.ilona.tracking.model.DeviceData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.UserAndDeviceDAO;

@Controller
@RequestMapping(value = "/tracking/admin")
public class AdminListAllUsersController {

	@Autowired
	private UserAndDeviceDAO userDeviceDAO;

	@RequestMapping(value = "/listallusers")
	public ModelAndView createAdminpageListAlluserspage() {
		ModelAndView userlistPage = new ModelAndView("tracking/admin/listAllUsers");
		Collection<UserData> users = new ArrayList<UserData>();
		Collection<UserBaseDetailsDTO> filteredUsers = new ArrayList<UserBaseDetailsDTO>();
		try {

			users = userDeviceDAO.getAllUsers();

			for (UserData user : users) {
				UserBaseDetailsDTO newUser = new UserBaseDetailsDTO();
				newUser.setUserid(user.getUserid());
				newUser.setUsername(user.getUsername());
				newUser.setEmail(user.getEmail());
				newUser.setEnabled(user.isEnabled());

				boolean isAdmin = false;
				for (String role : user.getRoles()) {
					if (role.equals("ROLE_ADMIN")) {
						isAdmin = true;
					}
				}
				newUser.setAdminRole(isAdmin);
				filteredUsers.add(newUser);
			}

		} catch (Exception e) {

		}
		userlistPage.addObject("users", filteredUsers);
		return userlistPage;
	}

	@RequestMapping(value = "/listusergetuserdevices", method = { RequestMethod.POST })
	public ModelAndView createListUserDevicespage(@RequestParam(name = "userid", required = false) String userid) {
		ModelAndView mav = new ModelAndView("tracking/admin/userDevices");

		if (userid == null) {
			return mav;
		}

		Collection<DeviceData> devices = new ArrayList<>();
		try {
			UserData user = userDeviceDAO.getUser(userid);
			devices = userDeviceDAO.readUserDevices(user);
			mav.addObject("devices", devices);
			mav.addObject("deviceOwner", userid);
		} catch (Exception e) {

		}
		return mav;
	}

	@RequestMapping(value = "/updatedevicedetails", method = { RequestMethod.POST })
	public ModelAndView updateUserDeviceDetails(@ModelAttribute() UserDeviceDataDTO device) {
		ModelAndView mav = new ModelAndView("tracking/admin/userDevices");
		Collection<DeviceData> newDeviceList = new ArrayList<>();
		try {
			UserData user = userDeviceDAO.getUser(device.getUserid());
			DeviceData newDevice = new DeviceData();
			newDevice.setDeviceid(device.getDeviceid());
			newDevice.setDeviceName(device.getDeviceName());
			newDevice.setDeviceType(device.getDeviceType());
			newDevice.setDeviceTypeName(device.getDeviceTypeName());
			userDeviceDAO.updateDevice(newDevice, user);
			newDeviceList = userDeviceDAO.readUserDevices(user);
			mav.addObject("devices", newDeviceList);
		} catch (Exception e) {
			mav.addObject("executionError", "Device update failed!");
		}
		mav.addObject("deviceOwner", device.getUserid());
		return mav;
	}
	
	@RequestMapping(value = "/deleteuserdevice", method = { RequestMethod.POST })
	public ModelAndView deleteUserDevice(@ModelAttribute() UserDeviceDataDTO device) {
		ModelAndView mav = new ModelAndView("tracking/admin/userDevices");
		Collection<DeviceData> newDeviceList = new ArrayList<>();
		try {
			UserData user = userDeviceDAO.getUser(device.getUserid());
			DeviceData deletableDevice = new DeviceData();
			deletableDevice.setDeviceid(device.getDeviceid());
			deletableDevice.setDeviceName(device.getDeviceName());
			deletableDevice.setDeviceType(device.getDeviceType());
			deletableDevice.setDeviceTypeName(device.getDeviceTypeName());			
			userDeviceDAO.deleteDevice(deletableDevice, user);
			
			newDeviceList = userDeviceDAO.readUserDevices(user);
			mav.addObject("devices", newDeviceList);
			
		} catch(Exception e) {
			mav.addObject("executionError", "Device deletion failed!");
		}
		mav.addObject("deviceOwner", device.getUserid());
		return mav;
	}

	@RequestMapping(value = "/listuserdeleteuser", method = { RequestMethod.POST })
	public ModelAndView deleteUser(@RequestParam("userid") String userid) {
		ModelAndView mav = new ModelAndView("tracking/admin/listAllUsers");
		Collection<UserData> users = new ArrayList<UserData>();
		Collection<UserBaseDetailsDTO> filteredUsers = new ArrayList<UserBaseDetailsDTO>();
		try {
			userDeviceDAO.deleteUser(userid);
			
			users = userDeviceDAO.getAllUsers();

			for (UserData user : users) {
				UserBaseDetailsDTO newUser = new UserBaseDetailsDTO();
				newUser.setUserid(user.getUserid());
				newUser.setUsername(user.getUsername());
				newUser.setEmail(user.getEmail());
				newUser.setEnabled(user.isEnabled());

				boolean isAdmin = false;
				for (String role : user.getRoles()) {
					if (role.equals("ROLE_ADMIN")) {
						isAdmin = true;
					}
				}
				newUser.setAdminRole(isAdmin);
				filteredUsers.add(newUser);
			}
		} catch(Exception e) {
			
		}
		mav.addObject("users", filteredUsers);
		return mav;
	}
	
	public void setUserDeviceDAO(UserAndDeviceDAO userDeviceDAO) {
		this.userDeviceDAO = userDeviceDAO;
	}

}
