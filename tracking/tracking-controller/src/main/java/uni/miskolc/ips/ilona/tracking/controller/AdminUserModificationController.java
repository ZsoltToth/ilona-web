package uni.miskolc.ips.ilona.tracking.controller;

import java.nio.file.AccessDeniedException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import uni.miskolc.ips.ilona.tracking.controller.model.UserBaseDetailsDTO;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.persist.UserAndDeviceDAO;

@Controller
@RequestMapping(value = "/tracking/admin")
public class AdminUserModificationController {

	@Autowired
	private UserAndDeviceDAO userDeviceDAO;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@RequestMapping(value = "/usermodresetaccountexpiration", method = { RequestMethod.POST })
	@ResponseBody
	public Date accountExpirationResetHandler(@RequestParam("userid") String userid) throws AccessDeniedException {

		try {
			UserData user = userDeviceDAO.getUser(userid);
			user.setLastLoginDate(new Date());
			userDeviceDAO.updateUser(user);
			return new Date();

		} catch (Exception e) {
			throw new AccessDeniedException("dasdasda");
		}

	}

	@RequestMapping(value = "/usermodmanualpasswordchange", method = { RequestMethod.POST })
	@ResponseBody
	public String accountManualPasswordResetHandler(@ModelAttribute() UserBaseDetailsDTO user)
			throws AccessDeniedException {

		// integrity check!

		// validation!

		try {
			UserData newUser = userDeviceDAO.getUser(user.getUserid());
			String hashedPassword = passwordEncoder.encode(user.getPassword());
			newUser.setPassword(hashedPassword);
			userDeviceDAO.updateUser(newUser);
			return "Password has been modified successfully!";

		} catch (Exception e) {
			return "An error occured!";
		}

	}

	@RequestMapping(value = "/usermodchangeaccountdetails", method = { RequestMethod.POST })
	@ResponseBody
	public String accountManagementChangeAccountDetails(@ModelAttribute() UserBaseDetailsDTO user)
			throws AccessDeniedException {
		// integrity check!

		// validation!

		try {
			UserData updatedUser = userDeviceDAO.getUser(user.getUserid());
			updatedUser.setUsername(user.getUsername());
			updatedUser.setEmail(user.getEmail());
			updatedUser.setEnabled(user.isEnabled());
			Collection<String> roles = new ArrayList<>();
			roles.add("ROLE_USER");
			if (user.isAdminRole() == true) {
				roles.add("ROLE_ADMIN");
			}
			updatedUser.setRoles(roles);
			userDeviceDAO.updateUser(updatedUser);
			return "Password has been modified successfully!";

		} catch (Exception e) {
			return "An error occured!";
		}

	}

	@RequestMapping(value = "/usermodresetpasswordexpiration", method = { RequestMethod.POST })
	@ResponseBody
	public Date accountManagementResetUserPasswordExpirationHandler(@RequestParam("userid") String userid)
			throws AccessDeniedException {
		// integrity check!

		// validation!

		try {
			UserData updatedUser = userDeviceDAO.getUser(userid);
			Date newPasswordExpiration = new Date(new Date().getTime() + 31536000000L);
			updatedUser.setCredentialNonExpiredUntil(newPasswordExpiration);
			userDeviceDAO.updateUser(updatedUser);

			return newPasswordExpiration;

		} catch (Exception e) {
			throw new AccessDeniedException("");
		}

	}

	@RequestMapping(value = "/usermodupdateloginattempts", method = { RequestMethod.POST })
	@ResponseBody
	public String accountManagementUpdateLoginAttemptsHandler(@RequestParam("userid") String userid,
			@RequestParam(value = "attempts[]", required = false) String[] loginAttempts) throws AccessDeniedException {
		// integrity check!	
		// validation!
		Collection<Date> logins = new ArrayList<>();
		for (int i = 0; i < loginAttempts.length; i++) {
			logins.add(new Date(Long.valueOf(loginAttempts[i])));
		}
		
		for (Date d : logins) {
			System.out.println(d.toString());
		}
		try {
			UserData updatedUser = userDeviceDAO.getUser(userid);

			return "";

		} catch (Exception e) {
			throw new AccessDeniedException("");
		}

	}

	public void setUserDeviceDAO(UserAndDeviceDAO userDeviceDAO) {
		this.userDeviceDAO = userDeviceDAO;
	}

	public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}

}
