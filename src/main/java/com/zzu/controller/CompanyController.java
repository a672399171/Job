package com.zzu.controller;

import com.zzu.dto.Result;
import com.zzu.common.Common;
import com.zzu.model.Company;
import com.zzu.service.CompanyService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("company")
public class CompanyController {
    @Resource
    private CompanyService companyService;

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Result login(String username, String password, HttpSession session) {
        Result result = companyService.login(username, password);
        Company company = (Company) result.getData().get(Common.COMPANY);
        if (company != null) {
            session.setAttribute(Common.COMPANY, company);
        }
        return companyService.login(username, password);
    }

    @RequestMapping(value = "/jobManage", method = RequestMethod.GET)
    public String jobManage() {
        return "company/job_manage";
    }

    @RequestMapping(value = "/resumeManage", method = RequestMethod.GET)
    public String resumeManage() {
        return "company/resume_manage";
    }

    @RequestMapping(value = "/searchResume", method = RequestMethod.GET)
    public String searchResume() {
        return "company/search_resume";
    }

    @RequestMapping(value = "/accountSetting", method = RequestMethod.GET)
    public String accountSetting() {
        return "company/account_setting";
    }

    @RequestMapping(value = "/postNew", method = RequestMethod.GET)
    public String postNew() {
        return "company/post";
    }

    @RequestMapping(value = "/quit", method = RequestMethod.POST)
    public void quit(HttpSession session) {
        session.removeAttribute(Common.COMPANY);
    }
}
