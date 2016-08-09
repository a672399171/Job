package com.zzu.controller;

import com.google.code.kaptcha.servlet.KaptchaExtend;
import com.zzu.common.Common;
import com.zzu.common.annotaion.Authorization;
import com.zzu.dto.Result;
import com.zzu.model.*;
import com.zzu.model.Collection;
import com.zzu.service.RedisService;
import com.zzu.service.ResumeService;
import com.zzu.service.UserService;
import com.zzu.service.impl.MailServiceImpl;
import com.zzu.util.CookieUtil;
import com.zzu.util.NetUtil;
import com.zzu.util.PictureUtil;
import com.zzu.util.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.*;

/**
 * Created by Administrator on 2016/3/1.
 */
@Controller
@RequestMapping("user")
public class UserController {
    @Resource
    private UserService userService;
    @Resource
    private ResumeService resumeService;
    @Resource
    private MailServiceImpl mailService;
    @Resource
    private RedisService redisService;
    private KaptchaExtend kaptchaExtend = new KaptchaExtend();

    /**
     * 学生用户登录
     *
     * @param username
     * @param password
     * @param session
     * @return
     */
    @RequestMapping("/login")
    @ResponseBody
    public Result login(String username, String password, Boolean on,
                        @CookieValue(value = Common.JOB_COOKIE_USER_REMEMBER, required = false) String cookie,
                        HttpSession session, HttpServletResponse response, HttpServletRequest request) {
        Result result = new Result();
        User user = userService.search(username, password);

        if (user != null) {
            if (on != null && on) {
                if (cookie == null) {
                    CookieUtil.addCookie(request.getServerName(), response, username);
                } else if (request.getCookies() != null) {
                    for (Cookie c : request.getCookies()) {
                        if (c.getName().equals(Common.JOB_COOKIE_USER_REMEMBER)) {
                            c.setMaxAge(Common.MAX_AGE);
                            break;
                        }
                    }
                }
            } else if (cookie != null && request.getCookies() != null) {
                for (Cookie c : request.getCookies()) {
                    if (c.getName().equals(Common.JOB_COOKIE_USER_REMEMBER)) {
                        CookieUtil.deleteCookie(request.getServerName(), response, username);
                        break;
                    }
                }
            }

            session.setAttribute(Common.USER, user);
        } else {
            result.setSuccess(false);
            result.setError("用户名或密码错误");
        }

        return result;
    }

    /**
     * 学生用户个人资料
     *
     * @return
     */
    @Authorization(Common.AUTH_USER_LOGIN)
    @RequestMapping("/info")
    public String info() {
        return "info";
    }

    /**
     * 个人简历
     *
     * @return
     */
    @RequestMapping(value = "/resume", method = RequestMethod.GET)
    @Authorization(Common.AUTH_USER_LOGIN)
    public String resume() {
        return "resume";
    }

    @RequestMapping("/apply")
    @Authorization(Common.AUTH_USER_LOGIN)
    public String apply(HttpSession session, Model model) {
        User user = (User) session.getAttribute(Common.USER);
        if (user != null) {
            model.addAttribute("applies", userService.getApplies(user.getId(), 0));
        }

        return "apply";
    }

    @RequestMapping("/poor")
    @Authorization(Common.AUTH_USER_LOGIN)
    public String poor(HttpSession session, Model model) {
        User user = (User) session.getAttribute(Common.USER);
        if (user != null) {
            List<Poor> poors = userService.searchPoor(user.getId());
            if (poors != null) {
                for (Poor poor : poors) {
                    if (poor.getU_id() == user.getId()) {
                        model.addAttribute("poor", poor);
                        break;
                    }
                }
            }
        }

        return "poor";
    }

    @Authorization({Common.AUTH_USER_LOGIN, Common.AUTH_COMPANY_LOGIN})
    @RequestMapping(value = "/resume/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Result getResumeById(@PathVariable("id") int id) {
        Result result = new Result();
        Resume resume = resumeService.getByUid(id);
        result.getData().put("resume", resume);
        return result;
    }

    @RequestMapping(value = "/resume", method = RequestMethod.POST)
    @Authorization(Common.AUTH_USER_LOGIN)
    @ResponseBody
    public Result saveOrModifyResult(@Valid @ModelAttribute("resume") Resume resume, BindingResult bindingResult) {
        Result result = new Result();
        System.out.println(resume);
        return result;
    }

    @RequestMapping("/setting")
    @Authorization(Common.AUTH_USER_LOGIN)
    public String setting() {
        return "setting";
    }

    @RequestMapping("/secret")
    @Authorization(Common.AUTH_USER_LOGIN)
    public String secret(HttpSession session) {
        User user = (User) session.getAttribute(Common.USER);
        if (user != null) {
            user = userService.getById(user.getId());
            session.setAttribute(Common.USER, user);
        }

        return "secret";
    }

    @RequestMapping("/collection")
    @Authorization(Common.AUTH_USER_LOGIN)
    public String collection(HttpSession session, Model model) {
        User user = (User) session.getAttribute(Common.USER);
        if (user != null) {
            Result<Collection> result = userService.searchCollections(user.getId(), 1, Common.COUNT);
            model.addAttribute("collections", result.getList());
        }

        return "collection";
    }

    @RequestMapping("/modifyInfo")
    @Authorization(Common.AUTH_USER_LOGIN)
    public String modify_info(String nickname, String sex, String photo_src, HttpSession session) {
        User user = (User) session.getAttribute(Common.USER);
        if (user != null) {
            User u = new User();
            u.setNickname(nickname);
            u.setSex(sex);
            u.setPhoto_src(photo_src);
            u.setId(user.getId());
            userService.modifyInfo(u);
            user = userService.getById(user.getId());
            session.setAttribute(Common.USER, user);
        }

        return "redirect:/user/info";
    }

    @Authorization(Common.AUTH_USER_LOGIN)
    @RequestMapping("/cancelCollection")
    @ResponseBody
    public Result cancelCollection(HttpSession session, int u_id, int j_id) {
        User user = (User) session.getAttribute(Common.USER);
        Result result = null;
        if (user != null) {
            result = userService.deleteCollection(u_id, j_id);
        }

        return result;
    }

    @Authorization(Common.AUTH_USER_LOGIN)
    @RequestMapping("changePassword")
    @ResponseBody
    public Result changePassword(String originPwd, String newPwd, HttpSession session) {
        Result result = new Result();
        User user = (User) session.getAttribute(Common.USER);
        user = userService.search(user.getUsername(), originPwd);
        if (user == null) {
            result.setSuccess(false);
            result.setError("密码错误");
        } else {
            result = userService.changeUserPassword(user.getId(), newPwd);
        }
        return result;
    }

    /**
     * 绑定邮箱
     *
     * @param session
     * @param email
     * @return
     */
    @Authorization(Common.AUTH_USER_LOGIN)
    @RequestMapping("/bindEmail")
    @ResponseBody
    public Result bindEmail(HttpSession session, String email, HttpServletRequest request) {
        Result result = new Result();
        User user = (User) session.getAttribute(Common.USER);
        if (user != null) {
            String url = request.getScheme() + "://" + request.getServerName() + ":" +
                    request.getServerPort() + request.getContextPath() + "/user/validate?type=" + Common.BINGEMAIL;
            String ran = StringUtil.toMd5(user.getUsername() + Common.BINGEMAIL);
            url += "&s=" + ran;
            Map<String, Object> valMap = new HashMap<String, Object>();
            valMap.put("url", url);

            mailService.sendEmail(email, "验证邮箱", "bindEmail.ftl", valMap);

            Verify verify = new Verify();
            verify.setEmail(email);
            verify.setVerify(ran);
            verify.setUsername(user.getUsername());
            verify.setTime(new Date());
            verify.setType(Common.BINGEMAIL);

            redisService.insertVerify(verify);
        }

        return result;
    }

    /**
     * 验证
     *
     * @param s
     * @param model
     * @return
     */
    @RequestMapping("/validate")
    public String validateResult(String type, String s, Model model, HttpSession session) {
        User user = (User) session.getAttribute(Common.USER);
        Verify verify = redisService.searchVerify(s, type);

        if (Common.BINGEMAIL.equals(type)) {
            return validateBindEmail(verify, user, model, session, s);
        } else if (Common.FINDPWD.equals(type)) {
            return validateFindpwd(verify, s, session);
        }

        return "redirect:/";
    }

    private String validateBindEmail(Verify verify, User user, Model model, HttpSession session, String s) {
        if (verify != null && verify.getVerify() != null && verify.getVerify().equals(s)) {
            int hourGap = (int) ((new Date().getTime() - verify.getTime().getTime()) / (1000 * 3600));
            if (hourGap <= 48) {
                user = userService.exists(verify.getUsername());
                if (user == null) {
                    model.addAttribute("result", "很遗憾，验证失败！");
                } else {
                    user.setEmail(verify.getEmail());
                    userService.bindEmail(user);
                    model.addAttribute("result", "恭喜你，验证成功！");
                    session.setAttribute(Common.USER, user);
                }
            } else {
                model.addAttribute("result", "很遗憾，验证失败！");
            }
        } else {
            model.addAttribute("result", "很遗憾，验证失败！");
        }

        return "varify_result";
    }

    private String validateFindpwd(Verify verify, String s, HttpSession session) {
        if (verify != null && verify.getVerify() != null && verify.getVerify().equals(s)) {
            int hourGap = (int) ((new Date().getTime() - verify.getTime().getTime()) / (1000 * 3600));
            if (hourGap <= 48) {
                session.setAttribute("auth", true);
            }
        }
        return "find_password";
    }

    @RequestMapping("/findPassword")
    @ResponseBody
    public Result findPassword(String email, String username, HttpServletRequest request) {
        Result result = new Result();
        String url = request.getScheme() + "://" + request.getServerName() + ":" +
                request.getServerPort() + request.getContextPath() + "/user/validate?type=" + Common.FINDPWD;
        String ran = StringUtil.toMd5(username + Common.FINDPWD);
        url += "&s=" + ran;
        Map<String, Object> valMap = new HashMap<String, Object>();
        valMap.put("url", url);

        try {
            mailService.sendEmail(email, "找回密码", "findPwd.ftl", valMap);
        } catch (Exception e) {
            result.setSuccess(false);
            result.setError(e.getMessage());
            return result;
        }

        Verify verify = new Verify();
        verify.setEmail(email);
        verify.setVerify(ran);
        verify.setUsername(username);
        verify.setTime(new Date());
        verify.setType(Common.FINDPWD);

        redisService.insertVerify(verify);

        return result;
    }

    @Authorization(Common.AUTH_USER_LOGIN)
    @RequestMapping("uploadPhoto")
    @ResponseBody
    public Map<String, Object> uploadPhoto(@RequestParam("file") MultipartFile myfile, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<String, Object>();
        String realPath = request.getSession().getServletContext().getRealPath("/resources/images");
        String originalFilename = myfile.getOriginalFilename();

        String newFile = System.currentTimeMillis() + originalFilename.substring(originalFilename.lastIndexOf("."));
        String newPath = realPath + "/" + newFile;
        System.out.println("新文件路径:" + newPath);

        try {
            myfile.transferTo(new File(newPath));
        } catch (IOException e) {
            System.out.println("文件[" + originalFilename + "]上传失败");
            e.printStackTrace();
        }
        PictureUtil.cutPicture(newPath);
        map.put("src", newFile);
        return map;
    }

    @RequestMapping("/reg")
    @ResponseBody
    public Result reg(@Valid @ModelAttribute("user") User user, String jwpwd,
                      String verify, HttpServletRequest request) throws Exception {
        Result result = new Result();
        result.setSuccess(false);

        User u = userService.exists(user.getUsername());
        if (u != null) {
            result.setError("用户名已存在");
        } else if (verify == null || !verify.equalsIgnoreCase(kaptchaExtend.getGeneratedKey(request))) {
            result.setError("验证码错误");
        } else if (!NetUtil.isZZUStudent(user.getUsername(), jwpwd)) {
            result.setError("学号或教务系统密码错误");
        } else if (userService.searchBySchoolNum(user.getSchool_num()) != null) {
            result.setError("该学号已绑定");
        } else {
            user.setPassword(StringUtil.toMd5(user.getPassword()));
            user.setNickname("用户" + user.getUsername());
            user.setPush(false);
            user.setSex("男");
            user.setPhoto_src(Common.DEFAULTPHOTO);
            Result _result = userService.addUser(user);
            result = _result;
            if (result.isSuccess()) {
                request.getSession().setAttribute(Common.USER, user);
            }
        }
        return result;
    }


    @RequestMapping("/captchaCode")
    public void captchaCode(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        kaptchaExtend.captcha(req, resp);
    }

    @RequestMapping("/checkCaptcha")
    @ResponseBody
    public Map<String, Object> checkCaptcha(String verify, HttpServletRequest request) {
        Map<String, Object> object = new HashMap<String, Object>();

        String code = kaptchaExtend.getGeneratedKey(request);
        if (code.equalsIgnoreCase(verify)) {
            object.put("valid", true);
        } else {
            object.put("valid", false);
        }

        return object;
    }

    @RequestMapping(value = "/quit", method = RequestMethod.POST)
    @ResponseBody
    public void quit(HttpSession session) {
        session.removeAttribute(Common.USER);
    }
}
