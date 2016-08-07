package com.zzu.controller;

import com.zzu.common.annotaion.Authorization;
import com.zzu.dto.Result;
import com.zzu.common.Common;
import com.zzu.model.*;
import com.zzu.service.CompanyService;
import com.zzu.service.JobService;
import com.zzu.service.ResumeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("company")
public class CompanyController {
    @Resource
    private CompanyService companyService;
    @Resource
    private JobService jobService;
    @Resource
    private ResumeService resumeService;

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

    @Authorization(Common.AUTH_COMPANY_LOGIN)
    @RequestMapping(value = "/jobManage", method = RequestMethod.GET)
    public String jobManage() {
        return "company/job_manage";
    }

    @Authorization(Common.AUTH_COMPANY_LOGIN)
    @RequestMapping(value = "/resumeManage", method = RequestMethod.GET)
    public String resumeManage() {
        return "company/resume_manage";
    }

    @Authorization(Common.AUTH_COMPANY_LOGIN)
    @RequestMapping(value = "/searchResume", method = RequestMethod.GET)
    public String searchResume() {
        return "company/search_resume";
    }

    @Authorization(Common.AUTH_COMPANY_LOGIN)
    @RequestMapping(value = "/accountSetting", method = RequestMethod.GET)
    public String accountSetting() {
        return "company/account_setting";
    }

    @Authorization(Common.AUTH_COMPANY_LOGIN)
    @RequestMapping(value = "/postNew", method = RequestMethod.GET)
    public String postNew() {
        return "company/post";
    }

    @Authorization(Common.AUTH_COMPANY_LOGIN)
    @RequestMapping(value = "/job/{id}", method = RequestMethod.GET)
    public String jobDetail(@PathVariable("id") Integer id, Model model) {
        if (id != null) {
            Job job = jobService.getJobById(id);
            model.addAttribute("job", job);
        }
        return "company/job_detail";
    }

    @Authorization(Common.AUTH_COMPANY_LOGIN)
    @RequestMapping(value = "/applies", method = RequestMethod.GET)
    @ResponseBody
    public Result<Apply> getApplies(@RequestParam(value = "page", required = false, defaultValue = "1") Integer page,
                                    HttpSession session) {
        Company company = (Company) session.getAttribute(Common.COMPANY);
        Result<Apply> result = companyService.getApplies(company.getId(), page, Common.COUNT);
        return result;
    }

    @Authorization({Common.AUTH_ADMIN_LOGIN, Common.AUTH_COMPANY_LOGIN})
    @RequestMapping(value = "/searchResume", method = RequestMethod.POST)
    @ResponseBody
    public Result<Resume> searchResume(
            @RequestParam(value = "grade", required = false, defaultValue = "0") Integer grade,
            @RequestParam(value = "time", required = false, defaultValue = "0") Integer time,
            @RequestParam(value = "salary", required = false, defaultValue = "") String salary,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "school", required = false, defaultValue = "0") Integer school,
            @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        return resumeService.searchResumes(grade,time,salary,keyword,school,page);
    }

    @RequestMapping(value = "/quit", method = RequestMethod.POST)
    @ResponseBody
    public void quit(HttpSession session) {
        session.removeAttribute(Common.COMPANY);
    }
}
