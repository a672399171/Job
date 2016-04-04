package com.zzu.controller;

import com.zzu.model.*;
import com.zzu.model.Collection;
import com.zzu.service.JobService;
import com.zzu.service.MailService;
import com.zzu.service.ResumeService;
import com.zzu.service.UserService;
import com.zzu.util.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.*;

/**
 * Created by Administrator on 2016/3/1.
 */
@Component
@RequestMapping("user")
public class UserController {
	@Resource
	private UserService userService;
	@Resource
	private ResumeService resumeService;
	@Resource
	private JobService jobService;
	@Resource
	private MailService mailService;

	@RequestMapping("/toLogin.do")
	public String toLogin(String from) {
		return "login";
	}

	@RequestMapping("/toCompanyLogin.do")
	public String toCompanyLogin() {
		return "company/login";
	}

	@RequestMapping("companyLogin.do")
	@ResponseBody
	public Map<String, Object> companyLogin(String username, String password, boolean on, HttpSession session,
	                                        HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		Company company = userService.searchCompany(username, StringUtil.toMd5(password));

		if (company != null) {
			if (on) {
				setCookie("company", response, username, password);
			}

			map.put("msg", true);
			session.setAttribute(Common.COMPANY, company);
		} else {
			map.put("msg", "用户名或密码错误");
		}

		return map;
	}

	/**
	 * 企业注册
	 *
	 * @param username
	 * @param password
	 * @param varify
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/companyReg.do")
	@ResponseBody
	public Map<String, Object> reg(String username, String password, String email,
	                               String varify, HttpSession session, HttpServletRequest request) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		Company company = userService.existsCompany(username);
		if (company != null) {
			map.put("msg", "用户名已存在");
		} else {
			company = userService.searchCompanyByEmail(email);
			if (company != null) {
				map.put("msg", "该邮箱已绑定过");
			} else if (varify == null || !varify.equalsIgnoreCase((String) session.getAttribute("code"))) {
				map.put("msg", "验证码错误");
			} else {

				String url = request.getScheme() + "://" + request.getServerName() + ":" +
						request.getServerPort() + request.getContextPath() + "/user/validate_company_reg.do";
				String randomString = StringUtil.randomString(10);
				url += "?u=" + StringUtil.toMd5(username) + "&s=" + StringUtil.toMd5(randomString) +
						"&p=" + StringUtil.toMd5(password);

				Map<String, Object> valMap = new HashMap<String, Object>();
				valMap.put("url", url);

				mailService.sendEmail(email, "验证邮箱", "companyReg.ftl", valMap);

				Varify varify2 = userService.searchVarify(StringUtil.toMd5(username), Common.COMPANYREG);

				if (varify2 == null) {
					varify2 = new Varify();
				}

				varify2.setUsername(StringUtil.toMd5(username));
				varify2.setTime(new Date());
				varify2.setEmail(email);
				varify2.setU(username);
				varify2.setVarify(StringUtil.toMd5(randomString));
				varify2.setType(Common.COMPANYREG);

				userService.insertOrUpdateVarify(varify2);

				mailService.sendEmail(email, "企业注册激活", "companyReg.ftl", valMap);
			}
		}
		return map;
	}

	@RequestMapping("/validate_company_reg.do")
	public String validateCompanyReg(String u, String s, String p, Model model, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		Varify varify = userService.searchVarify(u, Common.COMPANYREG);

		if (varify != null && varify.getVarify().equals(s)) {
			int hourGap = (int) ((new Date().getTime() - varify.getTime().getTime()) / (1000 * 3600));
			if (hourGap <= 48) {
				Company company = new Company();
				company.setUsername(varify.getU());
				company.setPassword(p);
				company.setEmail(varify.getEmail());
				userService.addCompany(company);

				return "company/account_setting";
			} else {
				model.addAttribute("result", "很遗憾，验证失败！");
			}
			userService.deleteVarify(varify);
		} else {
			model.addAttribute("result", "很遗憾，验证失败！");
		}
		return "reg";
	}

	@RequestMapping("updateCompany.do")
	public String updateCompany(MultipartFile logo, HttpSession session, String company_name, String address, String name,
	                            String phone, String introduce, String type, String scope, String email, double lng, double lat) {
		Company company = (Company) session.getAttribute(Common.COMPANY);
		if (company == null) {
			return "redirect:/user/toCompanyLogin.do";
		}
		if (!StringUtil.isEmpty(company_name)) {
			company.setCompany_name(company_name);
		}
		if (!StringUtil.isEmpty(address)) {
			company.setAddress(address);
		}
		if (!StringUtil.isEmpty(name)) {
			company.setName(name);
		}
		if (!StringUtil.isEmpty(phone)) {
			company.setPhone(phone);
		}
		if (!StringUtil.isEmpty(introduce)) {
			company.setIntroduce(introduce);
		}
		if (!StringUtil.isEmpty(type)) {
			company.setType(type);
		}
		if (!StringUtil.isEmpty(scope)) {
			company.setScope(scope);
		}
		if (!StringUtil.isEmpty(email)) {
			company.setEmail(email);
		}
		if (logo != null) {
			String realPath = session.getServletContext().getRealPath("/images");
			String originalFilename = null;
			//如果只是上传一个文件,则只需要MultipartFile类型接收文件即可,而且无需显式指定@RequestParam注解
			originalFilename = logo.getOriginalFilename();

			String newFile = System.currentTimeMillis() + originalFilename.substring(originalFilename.lastIndexOf("."));
			String newPath = realPath + "/" + newFile;
			System.out.println("新文件路径:" + newPath);

			try {
				logo.transferTo(new File(newPath));
			} catch (IOException e) {
				System.out.println("文件[" + originalFilename + "]上传失败,堆栈轨迹如下");
				e.printStackTrace();
			}

			company.setLogo(newFile);
		}

		company.setX(lng);
		company.setY(lat);

		userService.updateCompany(company);
		company = userService.getCompanyById(company.getId());
		session.setAttribute(Common.COMPANY, company);

		if(company.getAuth() != Common.AUTHED) {
			sendEmailToAdmin();
		}

		return "redirect:/job/account_setting.do";
	}

	/**
	 * 给管理员群发邮件
	 */
	private void sendEmailToAdmin() {
		List<Admin> admins = userService.getAllAdmins();

		for(Admin admin : admins) {
			String em = admin.getEmail();
			mailService.sendEmail(em,"管理员大哥，有新消息啦！","adminMsg.ftl",null);
		}
	}

	/**
	 * 学生用户登录
	 *
	 * @param username
	 * @param password
	 * @param session
	 * @return
	 */
	@RequestMapping("login.do")
	@ResponseBody
	public Map<String, Object> login(String username, String password, boolean on, HttpSession session,
	                                 HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = userService.search(username, StringUtil.toMd5(password));

		if (user != null) {
			if (on) {
				setCookie("cookie_user", response, username, password);
			}

			map.put("msg", true);
			session.setAttribute(Common.USER, user);
		} else {
			map.put("msg", "用户名或密码错误");
		}

		return map;
	}

	public void setCookie(String name, HttpServletResponse response, String username, String password) {
		Cookie cookie = new Cookie(name, username + "-" + password);
		cookie.setMaxAge(60 * 60 * 24 * 30); //cookie 保存30天
		//设置Cookie路径和域名
		cookie.setPath("/");
		response.addCookie(cookie);
	}

	/**
	 * 转到注册页面
	 *
	 * @return
	 */
	@RequestMapping("/toReg.do")
	public String toReg() {
		return "reg";
	}

	/**
	 * 转到公司注册界面
	 * @return
	 */
	@RequestMapping("/toCompanyReg.do")
	public String toCompanyReg() {
		return "company/reg";
	}

	/**
	 * 处理注册
	 *
	 * @param username
	 * @param password
	 * @param school_num
	 * @param jwpwd
	 * @param varify
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/reg.do")
	@ResponseBody
	public Map<String, Object> reg(String username, String password, String school_num,
	                               String jwpwd, String varify, HttpSession session) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();

		User user = userService.exists(username);
		if (user != null) {
			map.put("msg", "用户名已存在");
		} else if (varify == null || !varify.equalsIgnoreCase((String) session.getAttribute("code"))) {
			map.put("msg", "验证码错误");
		} else if (!NetUtil.isZZUStudent(username, jwpwd)) {
			map.put("msg", "学号或教务系统密码错误");
		} else if (userService.searchUserBySchoolNum(school_num) != null) {
			map.put("msg", "该学号已绑定");
		} else {
			user = new User();
			user.setUsername(username);
			user.setPassword(StringUtil.toMd5(password));
			user.setNickname("用户" + username);
			user.setPush(false);
			user.setSchool_num(school_num);
			user.setSex(Common.NAN);
			user.setPhoto_src(Common.DEFAULTPHOTO);
			userService.addUser(user);
			session.setAttribute(Common.USER, user);
		}
		return map;
	}

	/**
	 * 注册成功
	 *
	 * @return
	 */
	@RequestMapping("/reg_success.do")
	public String reg_success() {
		return "reg_success";
	}

	/**
	 * 图片验证码
	 *
	 * @param req
	 * @param resp
	 * @throws Exception
	 */
	@RequestMapping("/varify.do")
	public void vafiry(HttpServletRequest req, HttpServletResponse resp) throws Exception {
		String randomCode = VarifyUtil.createVerifyCode();
		BufferedImage bufferedImage = VarifyUtil.createImage(randomCode);

		// 将四位数字的验证码保存到Session中。
		HttpSession session = req.getSession();
		System.out.print(randomCode);
		session.setAttribute("code", randomCode);

		// 禁止图像缓存。
		resp.setHeader("Pragma", "no-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setDateHeader("Expires", 0);

		resp.setContentType("image/jpeg");

		// 将图像输出到Servlet输出流中。
		ServletOutputStream sos = resp.getOutputStream();
		ImageIO.write(bufferedImage, "jpeg", sos);
		sos.close();
	}

	/**
	 * 用户退出
	 *
	 * @param session
	 * @return
	 */
	@RequestMapping("/quit.do")
	@ResponseBody
	public Map<String, Object> quit(HttpSession session) {
		session.removeAttribute(Common.USER);
		session.removeAttribute(Common.COMPANY);

		Map map = new HashMap<String, Object>();
		map.put("msg", true);
		return map;
	}

	/**
	 * 学生用户个人资料
	 *
	 * @param session
	 * @return
	 */
	@RequestMapping("/info.do")
	public String info(HttpSession session) {
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			return "login";
		}

		return "info";
	}

	/**
	 * 个人资料的修改
	 *
	 * @param nickname
	 * @param sex
	 * @param photo_src
	 * @param session
	 * @return
	 */
	@RequestMapping("/modify_info.do")
	public String modify_info(String nickname, String sex, String photo_src, HttpSession session) {
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			return "login";
		}
		userService.modifyInfo(nickname, sex, photo_src, user.getId());
		user = userService.getUserById(user.getId());
		session.setAttribute(Common.USER, user);

		return "redirect:info.do";
	}

	/**
	 * 个人简历
	 *
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("/resume.do")
	public String resume(HttpSession session, Model model) {
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			return "login";
		}

		Resume resume = resumeService.getResumeByUid(user.getId());

		List<Position> positions = new ArrayList<Position>();
		String[] types = null;
		if (types != null && !StringUtil.isEmpty(resume.getJob_type())) {
			types = resume.getJob_type().split("#");
			for (String type : types) {
				if (StringUtil.isNumber(type)) {
					int temp = Integer.parseInt(type);
					Position position = jobService.getPositionById(temp);
					positions.add(position);
				}
			}
		}

		if (resume != null) {
			resume.setPositions(positions);
		}
		model.addAttribute(Common.RESUME, resume);

		return "resume";
	}

	/**
	 * 添加或修改简历
	 *
	 * @param resume
	 * @param result
	 * @param birthday
	 * @param session
	 * @return
	 */
	@RequestMapping("/saveOrUpdateResume.do")
	public String saveOrUpdateResume(@Valid @ModelAttribute("resume") Resume resume, BindingResult result,
	                                 String birthday, Integer major_id, HttpSession session) {
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			return "login";
		}

		Major major = new Major();
		major.setId(major_id);
		resume.setMajor(major);

		resume.setBirthday(DateUtil.toDate(birthday));
		resume.setU_id(user.getId());
		resumeService.saveOrUpdateResume(resume);

		return "redirect:resume.do";
	}

	/**
	 * 账号设置
	 *
	 * @param session
	 * @return
	 */
	@RequestMapping("/setting.do")
	public String setting(HttpSession session) {
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			return "login";
		}

		return "setting";
	}

	@RequestMapping("/changePassword.do")
	@ResponseBody
	public Map<String, Object> changePassword(String originPwd, String newPwd, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			map.put("msg", "unlogin");
		} else if (userService.search(user.getUsername(), StringUtil.toMd5(originPwd)) == null) {
			map.put("msg", "pwderror");
		} else {
			user.setPassword(StringUtil.toMd5(newPwd));
			userService.changeUserPassword(user);
		}

		session.setAttribute(Common.USER, user);

		return map;
	}

	/**
	 * 隐私设置
	 *
	 * @param session
	 * @return
	 */
	@RequestMapping("/secret.do")
	public String secret(HttpSession session) {
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			return "login";
		}
		user = userService.getUserById(user.getId());
		session.setAttribute(Common.USER, user);

		return "secret";
	}

	/**
	 * 修改隐私设置
	 *
	 * @param secret
	 * @param session
	 * @return
	 */
	@RequestMapping("/updateSecret.do")
	@ResponseBody
	public Map updateSecret(boolean secret, HttpSession session) {
		User user = (User) session.getAttribute(Common.USER);
		userService.updateSecret(user.getId(), secret);

		return null;
	}

	/**
	 * 我的收藏
	 *
	 * @param session
	 * @return
	 */
	@RequestMapping("/collection.do")
	public String collection(HttpSession session, Model model) {
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			return "login";
		}

		List<Collection> collections = userService.searchCollections(user.getId(), 1);
		model.addAttribute("collections", collections);

		return "collection";
	}

	/**
	 * 取消收藏
	 *
	 * @param session
	 * @param u_id
	 * @param j_id
	 * @return
	 */
	@RequestMapping("/cancelCollection.do")
	@ResponseBody
	public JSONObject cancelCollection(HttpSession session, int u_id, int j_id) {
		JSONObject object = new JSONObject();
		object.put("success", true);
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			object.put("success", false);
		} else {
			userService.deleteCollection(u_id, j_id);
		}

		return object;
	}

	/**
	 * 绑定邮箱
	 *
	 * @param session
	 * @param email
	 * @return
	 */
	@RequestMapping("/bindEmail.do")
	@ResponseBody
	public Map<String, Object> bindEmail(HttpSession session, String email, HttpServletRequest request) {
		User user = (User) session.getAttribute(Common.USER);
		Map<String, Object> map = new HashMap<String, Object>();
		if (user == null) {
			return null;
		}

		String url = request.getScheme() + "://" + request.getServerName() + ":" +
				request.getServerPort() + request.getContextPath() + "/user/validate_result.do";
		String randomString = StringUtil.randomString(10);
		url += "?u=" + StringUtil.toMd5(user.getUsername()) + "&s=" + StringUtil.toMd5(randomString);

		Map<String, Object> valMap = new HashMap<String, Object>();
		valMap.put("url", url);

		mailService.sendEmail(email, "验证邮箱", "bindEmail.ftl", valMap);

		Varify varify = userService.searchVarify(StringUtil.toMd5(user.getUsername()), Common.BINGEMAIL);

		if (varify == null) {
			varify = new Varify();
		}

		varify.setUsername(StringUtil.toMd5(user.getUsername()));
		varify.setTime(new Date());
		varify.setEmail(email);
		varify.setVarify(StringUtil.toMd5(randomString));
		varify.setType(Common.BINGEMAIL);

		userService.insertOrUpdateVarify(varify);

		return map;
	}

	/**
	 * 验证邮箱绑定
	 *
	 * @param u
	 * @param s
	 * @param model
	 * @return
	 */
	@RequestMapping("/validate_result.do")
	public String validateResult(String u, String s, Model model, HttpSession session) {
		User user = (User) session.getAttribute(Common.USER);
		Map<String, Object> map = new HashMap<String, Object>();
		if (user == null) {
			return "login";
		}
		Varify varify = userService.searchVarify(u, Common.BINGEMAIL);

		if (varify != null && varify.getVarify().equals(s)) {
			int hourGap = (int) ((new Date().getTime() - varify.getTime().getTime()) / (1000 * 3600));
			if (hourGap <= 48) {
				user.setEmail(varify.getEmail());
				userService.bindEmail(user);
				model.addAttribute("result", "恭喜你，验证成功！");
				session.setAttribute(Common.USER, user);
			} else {
				model.addAttribute("result", "很遗憾，验证失败！");
			}
			userService.deleteVarify(varify);
		} else {
			model.addAttribute("result", "很遗憾，验证失败！");
		}
		return "varify_result";
	}

	@RequestMapping("/apply.do")
	public String apply(HttpSession session, Model model) {
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			return "login";
		}

		List<Apply> applies = jobService.getApplies(user.getId(), 0);
		model.addAttribute("applies", applies);

		return "apply";
	}

	@RequestMapping("/poor.do")
	public String poor(HttpSession session, Model model) {
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			return "login";
		}

		Poor poor = userService.searchPoor(user.getId());
		model.addAttribute("poor", poor);

		return "poor";
	}

	@RequestMapping("/poor_confirm.do")
	public String poorConfirm(String name, String email, int major, @RequestParam("file") MultipartFile myfile,
	                          HttpSession session) {
		User user = (User) session.getAttribute(Common.USER);
		if (user == null) {
			return "login";
		}

		String realPath = session.getServletContext().getRealPath("/images");
		File file = new File(realPath);
		if (file.isDirectory() && !file.exists()) {
			file.mkdirs();
		}

		String originalFilename = myfile.getOriginalFilename();
		//如果只是上传一个文件,则只需要MultipartFile类型接收文件即可,而且无需显式指定@RequestParam注解
		String newFile = System.currentTimeMillis() + originalFilename.substring(originalFilename.lastIndexOf("."));
		String newPath = realPath + "/" + newFile;
		try {
			myfile.transferTo(new File(newPath));
		} catch (IOException e) {
			System.out.println("文件[" + originalFilename + "]上传失败,堆栈轨迹如下");
			e.printStackTrace();
		}

		Major m = new Major();
		m.setId(major);

		Poor poor = new Poor();
		poor.setU_id(user.getId());
		poor.setName(name);
		poor.setEmail(email);
		poor.setMajor(m);
		poor.setSrc(newFile);
		poor.setStatus(Common.AUDIT);
		userService.insertPoor(poor);

		return "redirect:poor.do";
	}

	/**
	 * 管理员登录
	 *
	 * @param username
	 * @param password
	 * @param session
	 * @return
	 */
	@RequestMapping("/admin/login.do")
	@ResponseBody
	public JSONObject adminLogin(String username, String password, HttpSession session) {
		JSONObject object = new JSONObject();
		if (session.getAttribute(Common.ADMIN) != null) {
			object.put("success", true);
		} else if (StringUtil.isEmpty(username) || StringUtil.isEmpty(password)) {
			object.put(Common.ERROR, "用户名或密码错误!");
		} else {
			password = StringUtil.toMd5(password);
			Admin admin = userService.adminLogin(username, password);

			if (admin != null) {
				session.setAttribute(Common.ADMIN, admin);
				object.put("success", true);
			} else {
				object.put(Common.ERROR, "用户名或密码错误!");
			}
		}
		return object;
	}

	/**
	 * 管理员退出
	 *
	 * @param session
	 * @return
	 */
	@RequestMapping("/admin/logout.do")
	@ResponseBody
	public JSONObject adminLogout(HttpSession session) {
		JSONObject object = new JSONObject();
		session.removeAttribute(Common.ADMIN);
		return object;
	}

	/**
	 * 发表评论
	 *
	 * @param j_id
	 * @param content
	 * @param session
	 * @return
	 */
	@RequestMapping("/postComment.do")
	@ResponseBody
	public JSONObject postComment(int j_id, String content, HttpSession session) {
		JSONObject object = new JSONObject();
		User user = (User) session.getAttribute(Common.USER);
		if (user != null) {
			Comment comment = new Comment();
			comment.setUser(user);
			comment.setContent(content);

			Job job = new Job();
			job.setId(j_id);

			comment.setJob(job);
			comment.setC_time(new Date());

			userService.addComment(comment);
		}
		return object;
	}

	/**
	 * 找回密码
	 *
	 * @return
	 */
	@RequestMapping("/find_password.do")
	public String toFindPassword() {
		return "find_password";
	}

	/**
	 * 验证学号教务密码
	 *
	 * @param username
	 * @param school_num
	 * @param jwpwd
	 * @param code
	 * @param session
	 * @return
	 */
	@RequestMapping("/varifySchoolNum.do")
	@ResponseBody
	public JSONObject varifySchoolNum(String username, String school_num, String jwpwd, String code, HttpSession session) {
		String c = (String) session.getAttribute("code");

		JSONObject object = new JSONObject();
		User user = null;
		if (StringUtil.isEmpty(username) || StringUtil.isEmpty(school_num)
				|| StringUtil.isEmpty(jwpwd) || StringUtil.isEmpty(code)) {
			object.put("msg", "字段不能为空");
		} else if (!code.equalsIgnoreCase(c)) {
			object.put("msg", "验证码错误");
		} else {
			user = userService.searchUserBySchoolNum(school_num);
			if (user == null || !username.equals(user.getUsername())) {
				object.put("msg", "用户名或学号错误");
			} else if (!NetUtil.isZZUStudent(school_num, jwpwd)) {
				object.put("msg", "教务密码与学号不匹配");
			} else {
				session.setAttribute("auth", username);
			}
		}

		return object;
	}

	/**
	 * 修改用户密码
	 *
	 * @param password
	 * @param session
	 * @return
	 */
	@RequestMapping("/resetPassword.do")
	@ResponseBody
	public JSONObject resetPassword(String password, HttpSession session) {
		JSONObject object = new JSONObject();
		String username = (String) session.getAttribute("auth");
		if (username == null) {
			object.put("msg", "未验证");
		} else {
			User user = userService.exists(username);
			if (user != null) {
				user.setPassword(StringUtil.toMd5(password));
				userService.changeUserPassword(user);
			}
		}
		session.removeAttribute("auth");
		return object;
	}

	/**
	 * 验证邮箱发送邮件
	 *
	 * @param username
	 * @param email
	 * @return
	 */
	@RequestMapping("/varifyEmail.do")
	@ResponseBody
	public JSONObject varifyEmail(String username, String email, HttpServletRequest request) {
		JSONObject object = new JSONObject();
		User user = userService.exists(username);
		if (user == null) {
			object.put("msg", "用户不存在");
		} else {
			String _email = user.getEmail();
			if (StringUtil.isEmpty(_email)) {
				object.put("msg", "该用户邮箱未绑定");
			} else if (!_email.equals(email)) {
				object.put("msg", "邮箱不正确");
			} else {
				String url = request.getScheme() + "://" + request.getServerName() + ":" +
						request.getServerPort() + request.getContextPath() + "/user/validate_find_password.do";
				String randomString = StringUtil.randomString(10);
				url += "?u=" + StringUtil.toMd5(user.getUsername()) + "&s=" + StringUtil.toMd5(randomString);

				Map<String, Object> valMap = new HashMap<String, Object>();
				valMap.put("url", url);

				mailService.sendEmail(email, "验证邮箱", "findPwd.ftl", valMap);

				Varify varify = userService.searchVarify(StringUtil.toMd5(user.getUsername()), Common.FINDPWD);

				if (varify == null) {
					varify = new Varify();
				}

				varify.setUsername(StringUtil.toMd5(user.getUsername()));
				varify.setTime(new Date());
				varify.setEmail(email);
				varify.setVarify(StringUtil.toMd5(randomString));
				varify.setType(Common.FINDPWD);
				varify.setU(username);

				userService.insertOrUpdateVarify(varify);
			}
		}
		return object;
	}

	/**
	 * 验证找回密码的邮件
	 *
	 * @param u
	 * @param s
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("/validate_find_password.do")
	public String validateFindPassword(String u, String s, Model model, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		Varify varify = userService.searchVarify(u, Common.FINDPWD);

		if (varify != null && varify.getVarify().equals(s)) {
			int hourGap = (int) ((new Date().getTime() - varify.getTime().getTime()) / (1000 * 3600));
			if (hourGap <= 48) {
				session.setAttribute("auth", varify.getU());
			}
			userService.deleteVarify(varify);
		}
		return "find_password";
	}

	/**
	 * 公司修改密码
	 *
	 * @param session
	 * @param password
	 * @param newPassword
	 * @return
	 */
	@RequestMapping("modifyCompanyPassword")
	@ResponseBody
	public Map<String, Object> modifyCompanyPassword(HttpSession session, String password, String newPassword) {
		Company company = (Company) session.getAttribute(Common.COMPANY);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("msg", "修改失败！");
		if (company == null) {
			map.put("msg", "登录已过期!");
		} else if (!company.getPassword().equals(StringUtil.toMd5(password))) {
			map.put("msg", "密码错误!");
		} else {
			userService.modifyCompanyPassword(company.getId(), StringUtil.toMd5(newPassword));
			company = userService.getCompanyById(company.getId());
			session.setAttribute(Common.COMPANY, company);
			map.put("msg", true);
		}

		return map;
	}

	@RequestMapping("/admin/tree_data.do")
	@ResponseBody
	public JSONArray getTreeData() {
		JSONArray array = new JSONArray();
		JSONObject object = null;

		List<Classify> classifies = jobService.getAllClassifies();
		List<Position> positions = jobService.searchPositions(0);
		for (Classify classify : classifies) {
			object = new JSONObject();
			object.put("id", classify.getId());
			object.put("label", classify.getName());
			object.put("type", Common.CLASSIFY);
			object.put("isNew", false);
			JSONArray children = new JSONArray();

			for (Position position : positions) {
				if (position.getC_id() == classify.getId()) {
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("id", position.getId());
					jsonObject.put("label", position.getName());
					jsonObject.put("type", Common.POSITION);
					jsonObject.put("isNew", false);
					jsonObject.put("c_id", classify.getId());
					children.add(jsonObject);
				}
			}
			object.put("children", children);
			array.add(object);
		}
		return array;
	}

	/**
	 * 查找普通用户
	 *
	 * @return
	 */
	@RequestMapping(value = "/admin/users/list/{page}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject searchUsers(@PathVariable("page") Integer page, String filter) {
		JSONObject object = new JSONObject();

		if (StringUtil.isEmpty(filter)) {
			filter = null;
		}

		List<User> users = userService.searchUsers(page, filter);
		int count = userService.getUsersCount(filter);

		object.put("total", count);
		object.put("rows", users);

		return object;
	}

	/**
	 * 根据id返回用户
	 *
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/admin/users/detail/{id}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getUserById(@PathVariable("id") Integer id) {
		JSONObject object = null;
		User user = userService.getUserById(id);
		object = JSONObject.fromObject(user);

		return object;
	}

	/**
	 * 更新用户信息
	 *
	 * @param id
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/admin/users/update/{id}", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateUser(@PathVariable("id") Integer id,
	                             @ModelAttribute("user") User user, BindingResult result) {
		JSONObject object = new JSONObject();

		boolean b = userService.isUserOrSchoolNumRepeat(user);
		if (!b) {
			userService.modifyUser(user);
			object.put("msg", "修改成功");
		} else {
			object.put("msg", "修改失败：用户名或学号重复！");
		}
		object.put("success", b);

		return object;
	}

	/**
	 * 添加用户
	 *
	 * @param user
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/admin/users/create", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject addUser(@Valid @ModelAttribute("user") User user, BindingResult result) {
		JSONObject object = new JSONObject();
		user.setId(0);

		boolean b = userService.isUserOrSchoolNumRepeat(user);
		if (!b) {
			user.setPassword(StringUtil.toMd5(user.getPassword()));
			userService.addUser(user);
			object.put("msg", "添加成功");
		} else {
			object.put("msg", "添加失败：用户名或学号重复！");
		}
		object.put("success", !b);

		return object;
	}

	/**
	 * 删除用户
	 *
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/admin/users/delete", method = RequestMethod.POST)
	@ResponseBody
	//接收int型数组
	public JSONObject deleteUser(@RequestParam(value = "ids[]") int[] ids) {
		JSONObject object = new JSONObject();
		int count = userService.deleteUsers(ids);
		if (count == ids.length) {
			object.put("msg", "删除成功");
		} else {
			object.put("msg", "未完全删除");
		}
		return object;
	}

	/**
	 * 查找公司
	 *
	 * @return
	 */
	@RequestMapping(value = "/admin/companies/list/{page}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject searchCompanies(@PathVariable("page") Integer page, Boolean audit, String filter) {
		JSONObject object = new JSONObject();
		int[] array = null;
		if (audit == null) {
			array = new int[]{Common.UNAUTH, Common.AUTHING, Common.AUTHED};
		} else if (audit) {
			array = new int[]{Common.AUTHED};
		} else {
			array = new int[]{Common.UNAUTH, Common.AUTHING};
		}

		if (StringUtil.isEmpty(filter)) {
			filter = null;
		}

		List<Company> companies = userService.searchCompanies(page, array, filter);
		int count = userService.getCompaniesCount(array, filter);

		object.put("total", count);
		object.put("rows", companies);
		return object;
	}

	/**
	 * 根据id返回公司
	 *
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/admin/companies/detail/{id}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getCompanyById(@PathVariable("id") Integer id) {
		JSONObject object = null;
		Company company = userService.getCompanyById(id);
		object = JSONObject.fromObject(company);

		return object;
	}

	/**
	 * 更新公司信息
	 *
	 * @param id
	 * @param company
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/admin/companies/update/{id}", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateCompany(@PathVariable("id") Integer id,
	                                @ModelAttribute("company") Company company, BindingResult result) {
		JSONObject object = new JSONObject();

		boolean b = userService.isUsernameRepeat(company);
		if (!b) {
			userService.updateCompany(company);
			object.put("msg", "修改成功");
		} else {
			object.put("msg", "修改失败：用户名重复！");
		}
		object.put("success", !b);

		return object;
	}

	/**
	 * 创建公司
	 *
	 * @param company
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/admin/companies/create", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject addCompany(@Valid @ModelAttribute("company") Company company, BindingResult result) {
		JSONObject object = new JSONObject();
		company.setId(0);

		boolean b = userService.isUsernameRepeat(company);
		if (!b) {
			company.setPassword(StringUtil.toMd5(company.getPassword()));
			userService.addCompany(company);
			object.put("msg", "添加成功");
		} else {
			object.put("msg", "添加失败：用户名或学号重复！");
		}
		object.put("success", !b);

		return object;
	}

	/**
	 * 删除公司
	 *
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/admin/companies/delete", method = RequestMethod.POST)
	@ResponseBody
	//接收int型数组
	public JSONObject deleteCompany(@RequestParam(value = "ids[]") int[] ids) {
		JSONObject object = new JSONObject();
		int count = userService.deleteUsers(ids);
		if (count == ids.length) {
			object.put("msg", "删除成功");
		} else {
			object.put("msg", "未完全删除");
		}
		return object;
	}

	/**
	 * 返回后台主页所需数据（未处理贫困生数量及未审核公司）
	 *
	 * @return
	 */
	@RequestMapping("/admin/dashboard.do")
	@ResponseBody
	public JSONObject getDashboardData() {
		JSONObject object = new JSONObject();

		int poorCount = userService.getNewPoorCount();
		int companyCount = userService.getNewCompanyCount();

		object.put("poorCount", poorCount);
		object.put("companyCount", companyCount);

		return object;
	}

	/**
	 * 查询所有贫困信息
	 *
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/admin/poors/list/{page}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject searchPoors(@PathVariable("page") Integer page) {
		JSONObject object = new JSONObject();
		List<Poor> poors = userService.searchPoors(page);
		object.put("total", poors.size());
		object.put("rows", poors);
		return object;
	}

	/**
	 * 根据id返回贫困生信息
	 *
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/admin/poors/detail/{id}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getPoorById(@PathVariable("id") Integer id) {
		JSONObject object = null;
		Poor poor = userService.searchPoor(id);
		object = JSONObject.fromObject(poor);

		return object;
	}

	/**
	 * 认证贫困生
	 *
	 * @param u_id
	 * @param status
	 * @return
	 */
	@RequestMapping(value = "/admin/auth.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject authPoor(int u_id, int status) {
		JSONObject object = new JSONObject();
		userService.authPoor(u_id, status);

		return object;
	}

	/**
	 * 审核公司信息
	 *
	 * @param id
	 * @param audit
	 * @return
	 */
	@RequestMapping(value = "/admin/audit.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject auditCompany(int id, int audit) {
		JSONObject object = new JSONObject();
		userService.auditCompany(id, audit);

		return object;
	}

	/**
	 * 修改或增加贫困生信息
	 *
	 * @param major_id
	 * @param poor
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/admin/poors/saveOrUpdatePoor.do", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateCompany(int major_id, @ModelAttribute("poor") Poor poor, BindingResult result) {
		JSONObject object = new JSONObject();

		Major major = new Major();
		major.setId(major_id);

		poor.setMajor(major);
		userService.insertPoor(poor);

		return object;
	}

	/**
	 * 上传头像
	 *
	 * @param myfile
	 * @param request
	 * @return
	 */
	@RequestMapping("upload_photo.do")
	@ResponseBody
	public Map<String, Object> upload_photo(@RequestParam("file") MultipartFile myfile, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String realPath = request.getSession().getServletContext().getRealPath("/images");
		String originalFilename = null;
		//如果只是上传一个文件,则只需要MultipartFile类型接收文件即可,而且无需显式指定@RequestParam注解
		originalFilename = myfile.getOriginalFilename();

		String newFile = System.currentTimeMillis() + originalFilename.substring(originalFilename.lastIndexOf("."));
		String newPath = realPath + "/" + newFile;
		System.out.println("新文件路径:" + newPath);

		try {
			myfile.transferTo(new File(newPath));
		} catch (IOException e) {
			System.out.println("文件[" + originalFilename + "]上传失败,堆栈轨迹如下");
			e.printStackTrace();
		}
		PictureUtil.cutPicture(newPath);
		map.put("src", newFile);
		return map;
	}

	@RequestMapping("uploadPicture.do")
	@ResponseBody
	public JSONObject uploadPicture(@RequestParam("file") MultipartFile myfile, HttpServletRequest request) {
		JSONObject object = new JSONObject();
		String realPath = request.getSession().getServletContext().getRealPath("/images/index");
		String originalFilename = myfile.getOriginalFilename();

		String newFile = System.currentTimeMillis() + originalFilename.substring(originalFilename.lastIndexOf("."));
		String newPath = realPath + "/" + newFile;
		System.out.println("新文件路径:" + newPath);

		try {
			myfile.transferTo(new File(newPath));
		} catch (IOException e) {
			System.out.println("文件[" + originalFilename + "]上传失败,堆栈轨迹如下");
			e.printStackTrace();
		}

		object.put("src", newFile);
		return object;
	}

	/**
	 * 修改主页图片轮播
	 *
	 * @param data
	 * @param session
	 * @return
	 */
	@RequestMapping("/updatePictureJson.do")
	@ResponseBody
	public JSONObject updatePictureJson(String data, HttpSession session) {
		JSONObject object = new JSONObject();
		JSONArray array = JSONArray.fromObject(data);

		String realPath = session.getServletContext().getRealPath("/json") + "/pic.json";
		//System.out.println(realPath);

		try {
			FileWriter fw = new FileWriter(realPath);
			fw.write(array.toString());
			fw.flush();
			fw.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		return object;
	}
}
