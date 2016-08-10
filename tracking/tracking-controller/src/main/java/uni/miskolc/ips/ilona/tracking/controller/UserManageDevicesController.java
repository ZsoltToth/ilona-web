package uni.miskolc.ips.ilona.tracking.controller;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.model.UserDeviceDataDTO;
import uni.miskolc.ips.ilona.tracking.controller.model.UserSecurityDetails;
import uni.miskolc.ips.ilona.tracking.model.DeviceData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.UserAndDeviceDAO;

@Controller
@RequestMapping(value = "/tracking/user")
public class UserManageDevicesController {

	@Autowired
	private UserAndDeviceDAO userAndDeviceDAO;

	@RequestMapping(value = "/managedevices")
	public ModelAndView createDeviceManagementpageHandler() {
		ModelAndView mav = new ModelAndView("tracking/user/manageDevices");
		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();
		Collection<DeviceData> devices = new ArrayList<>();

		try {

			UserData user = userAndDeviceDAO.getUser(userDetails.getUserid());
			devices = userAndDeviceDAO.readUserDevices(user);
			/*
			 * for(DeviceData dev : devices) { UserDeviceDataDTO newDev = new
			 * UserDeviceDataDTO(); newDev.setDeviceid(dev.getDeviceid());
			 * newDev.setUserid(userDetails.getUserid());
			 * newDev.setDeviceName(dev.getDeviceName());
			 * newDev.setDeviceType(dev.getDeviceType()); newDev.se }
			 */
		} catch (Exception e) {
			return mav;
		}
		mav.addObject("devices", devices);
		mav.addObject("deviceOwnerid", userDetails.getUserid());
		mav.addObject("deviceOwnerName", userDetails.getUsername());
		return mav;
	}

	@RequestMapping(value = "/mandevdeletedevice", method = { RequestMethod.POST })
	public ModelAndView processDeleteDeviceRequestHandler(@ModelAttribute() UserDeviceDataDTO deletableDevice) {
		ModelAndView mav = new ModelAndView("tracking/user/manageDevices");
		UserData owner = null;
		try {
			owner = userAndDeviceDAO.getUser(deletableDevice.getUserid());
			DeviceData dev = new DeviceData();
			dev.setDeviceid(deletableDevice.getDeviceid());
			dev.setDeviceName(deletableDevice.getDeviceName());
			dev.setDeviceType(deletableDevice.getDeviceType());
			dev.setDeviceTypeName(deletableDevice.getDeviceTypeName());
			userAndDeviceDAO.deleteDevice(dev, owner);

			Collection<DeviceData> devices = userAndDeviceDAO.readUserDevices(owner);
			mav.addObject("devices", devices);
			mav.addObject("deviceOwnerid", owner.getUserid());
			mav.addObject("deviceOwnerName", owner.getUsername());
			return mav;
		} catch (Exception e) {
			mav.addObject("executionError", "An error occured!");
			return mav;
		}

		// return mav;
	}

	@RequestMapping(value = "/mandevupdatedevicedetails", method = { RequestMethod.POST })
	public ModelAndView processUpdateUserDeviceDetailsRequestHandler(@ModelAttribute() UserDeviceDataDTO device) {
		ModelAndView mav = new ModelAndView("tracking/user/manageDevices");
		try {
			UserData user = userAndDeviceDAO.getUser(device.getUserid());
			DeviceData dev = new DeviceData();
			dev.setDeviceid(device.getDeviceid());
			dev.setDeviceName(device.getDeviceName());
			dev.setDeviceType(device.getDeviceType());
			dev.setDeviceTypeName(device.getDeviceTypeName());
			userAndDeviceDAO.updateDevice(dev, user);

			Collection<DeviceData> devices = userAndDeviceDAO.readUserDevices(user);
			mav.addObject("devices", devices);
			mav.addObject("deviceOwnerid", user.getUserid());
			mav.addObject("deviceOwnerName", user.getUsername());
			return mav;

		} catch (Exception e) {
			return mav;
		}
		// return mav;
	}

	@RequestMapping(value = "/createdevicepage", method = { RequestMethod.POST })
	public ModelAndView createUserCreateDevicepageHandler() {
		ModelAndView mav = new ModelAndView("tracking/user/createDevice");
		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();
		
		mav.addObject("deviceOwnerid", userDetails.getUserid());
		
		return mav;
	}

	@RequestMapping(value = "/createnewdevice", method = { RequestMethod.POST })
	public ModelAndView createUserDeviceHandler(@ModelAttribute UserDeviceDataDTO newDevice) {
		ModelAndView mav = new ModelAndView("tracking/user/createDevice");
		
		// valdiate
		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();
		try {
			UserData user = userAndDeviceDAO.getUser(userDetails.getUserid());
			DeviceData dev = new DeviceData();
			dev.setDeviceid(newDevice.getDeviceid());
			dev.setDeviceName(newDevice.getDeviceName());
			dev.setDeviceType(newDevice.getDeviceType());
			dev.setDeviceTypeName(newDevice.getDeviceTypeName());
			userAndDeviceDAO.storeDevice(dev, user);
			mav.addObject("executionError", "Device successfully added!");
		} catch(Exception e) {
			mav.addObject("executionError", "An error occured!");
		}
		
		mav.addObject("deviceOwnerid", userDetails.getUserid());
		return mav;
	}

	public void setUserAndDeviceDAO(UserAndDeviceDAO userAndDeviceDAO) {
		this.userAndDeviceDAO = userAndDeviceDAO;
	}

}
