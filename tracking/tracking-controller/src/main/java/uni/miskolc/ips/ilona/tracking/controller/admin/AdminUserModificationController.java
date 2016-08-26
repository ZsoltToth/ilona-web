package uni.miskolc.ips.ilona.tracking.controller.admin;

import java.nio.file.AccessDeniedException;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import uni.miskolc.ips.ilona.tracking.controller.model.UserBaseDetailsDTO;
import uni.miskolc.ips.ilona.tracking.controller.model.UserSecurityDetails;
import uni.miskolc.ips.ilona.tracking.model.UserData;
import uni.miskolc.ips.ilona.tracking.service.UserAndDeviceService;

@Controller
@RequestMapping(value = "/tracking/admin")
public class AdminUserModificationController {

	@Resource(name = "UserAndDeviceService")
	private UserAndDeviceService userAndDeviceService;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Resource(name = "mailSender")
	private MailSender mailSender;

	@RequestMapping(value = "/usermodresetaccountexpiration", method = { RequestMethod.POST })
	@ResponseBody
	public Date accountExpirationResetHandler(@RequestParam("userid") String userid) throws AccessDeniedException {

		try {
			UserData user = userAndDeviceService.getUser(userid);
			user.setLastLoginDate(new Date());
			userAndDeviceService.updateUser(user);
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
			UserData newUser = userAndDeviceService.getUser(user.getUserid());
			String hashedPassword = passwordEncoder.encode(user.getPassword());
			newUser.setPassword(hashedPassword);
			userAndDeviceService.updateUser(newUser);
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
			UserData updatedUser = userAndDeviceService.getUser(user.getUserid());
			updatedUser.setUsername(user.getUsername());
			updatedUser.setEmail(user.getEmail());
			updatedUser.setEnabled(user.isEnabled());
			Collection<String> roles = new ArrayList<>();
			roles.add("ROLE_USER");
			if (user.isAdminRole() == true) {
				roles.add("ROLE_ADMIN");
			}
			updatedUser.setRoles(roles);
			userAndDeviceService.updateUser(updatedUser);
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
			UserData updatedUser = userAndDeviceService.getUser(userid);
			Date newPasswordExpiration = new Date(new Date().getTime() + 31536000000L);
			updatedUser.setCredentialNonExpiredUntil(newPasswordExpiration);
			userAndDeviceService.updateUser(updatedUser);

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
			UserData updatedUser = userAndDeviceService.getUser(userid);

			return "";

		} catch (Exception e) {
			throw new AccessDeniedException("");
		}

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

	public void setUserAndDeviceService(UserAndDeviceService userAndDeviceService) {
		this.userAndDeviceService = userAndDeviceService;
	}

	public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}

	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}

}
