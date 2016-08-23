package uni.miskolc.ips.ilona.tracking.controller.user;

import java.util.ArrayList;
import java.util.Collection;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.model.UserDeviceDataDTO;
import uni.miskolc.ips.ilona.tracking.controller.model.UserSecurityDetails;
import uni.miskolc.ips.ilona.tracking.controller.util.ValidateDeviceData;
import uni.miskolc.ips.ilona.tracking.controller.util.WebpageInformationProvider;
import uni.miskolc.ips.ilona.tracking.model.DeviceData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.UserAndDeviceDAO;
import uni.miskolc.ips.ilona.tracking.service.UserAndDeviceService;
import uni.miskolc.ips.ilona.tracking.service.exceptions.DuplicatedDeviceException;
import uni.miskolc.ips.ilona.tracking.util.validate.ValidityStatusHolder;

@Controller
@RequestMapping(value = "/tracking/user")
public class UserManageDevicesController {

	@Resource(name = "UserAndDeviceService")
	private UserAndDeviceService userAndDeviceService;

	@RequestMapping(value = "/managedevices")
	public ModelAndView createDeviceManagementpageHandler() {
		ModelAndView mav = new ModelAndView("tracking/user/manageDevices");
		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();
		Collection<DeviceData> devices = new ArrayList<>();

		try {

			UserData user = userAndDeviceService.getUser(userDetails.getUserid());
			devices = userAndDeviceService.readUserDevices(user);

		} catch (Exception e) {
			mav.addObject("executionError", "Service error!");
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
			owner = userAndDeviceService.getUser(deletableDevice.getUserid());
			DeviceData dev = new DeviceData();
			dev.setDeviceid(deletableDevice.getDeviceid());
			dev.setDeviceName(deletableDevice.getDeviceName());
			dev.setDeviceType(deletableDevice.getDeviceType());
			dev.setDeviceTypeName(deletableDevice.getDeviceTypeName());
			userAndDeviceService.deleteDevice(dev, owner);

			Collection<DeviceData> devices = userAndDeviceService.readUserDevices(owner);
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
			UserData user = userAndDeviceService.getUser(device.getUserid());
			DeviceData dev = new DeviceData();
			dev.setDeviceid(device.getDeviceid());
			dev.setDeviceName(device.getDeviceName());
			dev.setDeviceType(device.getDeviceType());
			dev.setDeviceTypeName(device.getDeviceTypeName());
			userAndDeviceService.updateDevice(dev, user);

			Collection<DeviceData> devices = userAndDeviceService.readUserDevices(user);
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

		fillModelAndViewWithCreateDeviceData(mav);
		mav.addObject("deviceOwnerid", userDetails.getUserid());

		return mav;
	}

	@RequestMapping(value = "/createnewdevice", method = { RequestMethod.POST })
	@ResponseBody
	public Collection<String> createUserDeviceHandler(@ModelAttribute UserDeviceDataDTO newDevice) {
		Collection<String> returnMessage = new ArrayList<String>();

		ValidityStatusHolder errors = new ValidityStatusHolder();
		errors.appendValidityStatusHolder(ValidateDeviceData.validateDeviceid(newDevice.getDeviceid()));
		errors.appendValidityStatusHolder(ValidateDeviceData.validateDeviceName(newDevice.getDeviceName()));
		errors.appendValidityStatusHolder(ValidateDeviceData.validateDeviceType(newDevice.getDeviceType()));
		errors.appendValidityStatusHolder(ValidateDeviceData.validateDeviceTypeName(newDevice.getDeviceTypeName()));

		if (!errors.isValid()) {
			returnMessage.addAll(errors.getErrors());
			return returnMessage;
		}
		UserSecurityDetails userDetails = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();

		if (!newDevice.getUserid().equals(userDetails.getUserid())) {
			returnMessage.add("Authorization violation error!");
			return returnMessage;
		}

		try {
			UserData user = userAndDeviceService.getUser(userDetails.getUserid());
			DeviceData dev = new DeviceData();
			dev.setDeviceid(newDevice.getDeviceid());
			dev.setDeviceName(newDevice.getDeviceName());
			dev.setDeviceType(newDevice.getDeviceType());
			dev.setDeviceTypeName(newDevice.getDeviceTypeName());
			userAndDeviceService.storeDevice(dev, user);
		} catch (DuplicatedDeviceException e) {
			returnMessage.add("Device already exists with id: " + newDevice.getDeviceid());
			return returnMessage;
		} catch (Exception e) {
			returnMessage.add("Service error, device storage has failed!");
			return returnMessage;
		}

		returnMessage.add("Device has been created successfully!");
		return returnMessage;
	}

	private ModelAndView fillModelAndViewWithCreateDeviceData(ModelAndView mav) {
		mav.addObject("deviceidRestriction", WebpageInformationProvider.getDeviceidrestrictionmessage());
		mav.addObject("deviceNameRestriction", WebpageInformationProvider.getDevicenamerestrictionmessage());
		mav.addObject("deviceTypeRestriction", WebpageInformationProvider.getDevicetyperestrictionmessage());
		mav.addObject("deviceTypeNameRestriction", WebpageInformationProvider.getDevicetypenamerestrictionmessage());

		mav.addObject("deviceidPattern", WebpageInformationProvider.getDeviceidpattern());
		mav.addObject("deviceNamePattern", WebpageInformationProvider.getDevicenamepattern());
		mav.addObject("deviceTypePattern", WebpageInformationProvider.getDevicetypepattern());
		mav.addObject("deviceTypeNamePattern", WebpageInformationProvider.getDevicetypenamepattern());

		return mav;
	}

	public void setUserAndDeviceService(UserAndDeviceService userAndDeviceService) {
		this.userAndDeviceService = userAndDeviceService;
	}

}
