package com.zzu.controller;

import com.zzu.dto.Result;
import com.zzu.model.Classify;
import com.zzu.common.Common;
import com.zzu.model.Job;
import com.zzu.service.JobService;
import com.zzu.service.RedisService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping
public class PageController {
    @Resource
    private JobService jobService;
    @Resource
    private RedisService redisService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(Model model) {
        List<Classify> classifies = redisService.getClassifies();
        Result<Job> jobs = jobService.searchJobs(1, Common.COUNT);
        model.addAttribute("classifies", classifies);
        model.addAttribute("jobs", jobs.getList());

        return "index";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, @CookieValue(value = Common.JOB_COOKIE_USER_REMEMBER, required = false) String cookie) {
        boolean flag = false;
        if (cookie != null) {
            flag = true;
        }
        model.addAttribute("flag", flag);
        return "login";
    }

    @RequestMapping(value = "/companyLogin", method = RequestMethod.GET)
    public String companyLogin(Model model, @CookieValue(value = Common.JOB_COOKIE_COMPANY_REMEMBER, required = false) String cookie) {
        boolean flag = false;
        if (cookie != null) {
            flag = true;
        }
        model.addAttribute("flag", flag);
        return "company/login";
    }

    @RequestMapping(value = "/findPassword", method = RequestMethod.GET)
    public String findPassword(Model model) {
        return "find_password";
    }

    @RequestMapping(value = "/reg", method = RequestMethod.GET)
    public String reg(Model model) {
        return "reg";
    }

    @RequestMapping(value = "/regSuccess", method = RequestMethod.GET)
    public String regSuccess(Model model) {
        return "reg_success";
    }

    @RequestMapping(value = "/applySuccess", method = RequestMethod.GET)
    public String applySuccess(Model model) {
        return "apply_success";
    }
}
