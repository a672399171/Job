package com.zzu.controller;

import com.zzu.common.Common;
import com.zzu.common.annotaion.Authorization;
import com.zzu.dto.Result;
import com.zzu.model.Admin;
import com.zzu.service.*;
import com.zzu.util.StringUtil;
import com.zzu.util.TokenFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Resource
    private UserService userService;
    @Resource
    private CompanyService companyService;
    @Resource
    private JobService jobService;
    @Resource
    private ResumeService resumeService;
    @Resource
    private RedisService redisService;
    @Resource
    private ClassifyService classifyService;
    @Resource
    private CommentService commentService;
    @Resource
    private AdminService adminService;

    @RequestMapping("/login")
    @ResponseBody
    public Result adminLogin(String username, String password, HttpSession session) {
        Result result = new Result(false);
        if (session.getAttribute(Common.ADMIN) != null) {
            result.setSuccess(true);
        } else if (StringUtil.isEmpty(username) || StringUtil.isEmpty(password)) {
            result.setError("用户名或密码错误!");
        } else {
            password = StringUtil.toMd5(password);
            Admin admin = userService.adminLogin(username, password);

            if (admin != null) {
                session.setAttribute(Common.ADMIN, admin);
                result.setSuccess(true);

                redisService.insertToken(TokenFactory.getInstance());
            } else {
                result.setError("用户名或密码错误!");
            }
        }
        return result;
    }

    @RequestMapping("/logout")
    @ResponseBody
    public Result logout(HttpSession session) {
        Result result = new Result(true);
        session.removeAttribute(Common.ADMIN);
        return result;
    }

    @Authorization(Common.AUTH_ADMIN_LOGIN)
    @RequestMapping("/dashboard")
    @ResponseBody
    public Result dashboard() {
        Result result = new Result(true);
        result.getData().put("poorCount", adminService.getNewPoorCount());
        result.getData().put("companyCount",adminService.getNewCompanyCount());
        return result;
    }
}
