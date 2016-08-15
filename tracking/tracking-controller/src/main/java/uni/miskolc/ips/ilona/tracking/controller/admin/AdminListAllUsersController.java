package uni.miskolc.ips.ilona.tracking.controller.admin;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.model.LoginAttemptFormStorage;
import uni.miskolc.ips.ilona.tracking.controller.model.UserBaseDetailsDTO;
import uni.miskolc.ips.ilona.tracking.controller.model.UserDeviceDataDTO;
import uni.miskolc.ips.ilona.tracking.controller.model.UserSecurityDetails;
import uni.miskolc.ips.ilona.tracking.model.DeviceData;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.UserAndDeviceDAO;

@Controller
@RequestMapping(value = "/tracking/admin")
public class AdminListAllUsersController {

	@Autowired
	private UserAndDeviceDAO userDeviceDAO;

	@Autowired
	private MailSender mailSender;

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

		} catch (Exception e) {
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
		} catch (Exception e) {

		}
		mav.addObject("users", filteredUsers);
		return mav;
	}

	@RequestMapping(value = "/listusersmodifyuser")
	public ModelAndView createAdminUserModificationpageHandler(
			@RequestParam(name = "userid", required = false) String userid) {
		ModelAndView mav = new ModelAndView("tracking/admin/userModification");

		if (userid == null) {
			// error
		}

		try {
			UserData user = userDeviceDAO.getUser(userid);
			mav.addObject("Userid", user.getUserid());
			mav.addObject("Username", user.getUsername());
			mav.addObject("Email", user.getEmail());
			/*
			 * User enabled
			 */
			if (user.isEnabled() == true) {
				mav.addObject("Enabled", "checked=\"checked\"");
			} else {
				mav.addObject("Enabled", "");
			}
			/*
			 * is admin check
			 */
			Collection<String> roles = user.getRoles();
			boolean isAdmin = false;
			for (String role : roles) {
				if (role.equals("ROLE_ADMIN")) {
					isAdmin = true;
				}
			}
			if (isAdmin == true) {
				mav.addObject("IsAdmin", "checked=\"checked\"");
			} else {
				mav.addObject("IsAdmin", "");
			}
			Date lastLogin = user.getLastLoginDate();
			if ((new Date().getTime() - 31536000000L) > lastLogin.getTime()) {
				mav.addObject("AccountExpiration", "ERROR");
			} else {
				mav.addObject("AccountExpiration", "NOERROR");
			}
			mav.addObject("lastLoginDate", user.getLastLoginDate().toString());

			if (user.getCredentialNonExpiredUntil().getTime() < new Date().getTime()) {
				mav.addObject("passwordExpiration", "ERROR");
			} else {
				mav.addObject("passwordExpiration", "NOERROR");
			}
			mav.addObject("passwordValidUntil", user.getCredentialNonExpiredUntil().toString());

			Collection<LoginAttemptFormStorage> attempts = new ArrayList<>();
			Collection<Date> loginAttempts = user.getBadLogins();
			for (Date date : loginAttempts) {
				LoginAttemptFormStorage storage = new LoginAttemptFormStorage();
				storage.setFormatDate(date.toString());
				storage.setFormatMilliseconds(date.getTime());
				attempts.add(storage);
			}
			mav.addObject("loginAttempts", attempts);
		} catch (Exception e) {

		}
		return mav;
	}

	@RequestMapping(value = "/userdevcreatenewdevicepagerequest", method = { RequestMethod.POST })
	public ModelAndView createDeviceForUserRequestHandler(@RequestParam("userid") String userid) {
		ModelAndView mav = new ModelAndView("tracking/admin/createNewDevice");
		mav.addObject("deviceOwnerid", userid);
		return mav;
	}

	@RequestMapping(value = "/createnewdeviceforuser", method = { RequestMethod.POST })
	public ModelAndView createDeviceForUserCreateDeviceRequestHandler(@ModelAttribute() UserDeviceDataDTO newDevice) {
		ModelAndView mav = new ModelAndView("tracking/admin/createNewDevice");
		//
		try {
			UserData user = userDeviceDAO.getUser(newDevice.getUserid());
			DeviceData device = new DeviceData();
			device.setDeviceid(newDevice.getDeviceid());
			device.setDeviceName(newDevice.getDeviceName());
			device.setDeviceType(newDevice.getDeviceType());
			device.setDeviceTypeName(newDevice.getDeviceTypeName());
			userDeviceDAO.storeDevice(device, user);
		} catch (Exception e) {
			mav.addObject("OperationError", "An error occured!");
		}
		mav.addObject("deviceOwnerid", newDevice.getUserid());
		return mav;
	}

	@RequestMapping(value = "/automatedpasswordreset", method = { RequestMethod.POST })
	public ModelAndView userPasswordAutoGenerationHandler(@RequestParam("userid") String userid) {

		UserSecurityDetails user = (UserSecurityDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();

		try {
			SimpleMailMessage mailMessage = new SimpleMailMessage();
			mailMessage.setFrom("ILONA@gmail.com");
			mailMessage.setTo(user.getEmail().trim());
			mailMessage.setSubject("Password recovery!");
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			String newPassword = user.getUserid() + user.hashCode(); // OK...
			byte[] datas = md.digest(newPassword.getBytes());

			mailMessage.setText("Your new password is: " + newPassword);
			// mailSender.send(mailMessage);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public void setUserDeviceDAO(UserAndDeviceDAO userDeviceDAO) {
		this.userDeviceDAO = userDeviceDAO;
	}

	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}

}
