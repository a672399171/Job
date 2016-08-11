package com.zzu.controller;

import com.google.code.kaptcha.servlet.KaptchaExtend;
import com.zzu.common.annotaion.Authorization;
import com.zzu.dto.Result;
import com.zzu.common.Common;
import com.zzu.model.*;
import com.zzu.service.CompanyService;
import com.zzu.service.JobService;
import com.zzu.service.RedisService;
import com.zzu.service.ResumeService;
import com.zzu.service.impl.MailServiceImpl;
import com.zzu.util.CookieUtil;
import com.zzu.util.NetUtil;
import com.zzu.util.StringUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("company")
public class CompanyController {
    @Resource
    private CompanyService companyService;
    @Resource
    private JobService jobService;
    @Resource
    private ResumeService resumeService;
    @Resource
    private KaptchaExtend kaptchaExtend;
    @Resource
    private RedisService redisService;
    @Resource
    private MailServiceImpl mailService;

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public Result login(String username, String password, Boolean on,
                        @CookieValue(value = Common.JOB_COOKIE_COMPANY_REMEMBER, required = false) String cookie,
                        HttpSession session, HttpServletResponse response, HttpServletRequest request) {
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
        return resumeService.searchResumes(grade, time, salary, keyword, school, page);
    }

    @RequestMapping("/reg")
    @ResponseBody
    public Result reg(@Valid @ModelAttribute("company") Company company,
                      String verify, HttpServletRequest request) throws Exception {
        Result result = new Result(false);

        Company c = companyService.exists(company.getUsername());
        if (c != null) {
            result.setError("用户名已存在");
        } else if (verify == null || !verify.equalsIgnoreCase(kaptchaExtend.getGeneratedKey(request))) {
            result.setError("验证码错误");
        } else if (companyService.searchByEmail(company.getEmail()) != null) {
            result.setError("该email已被绑定");
        } else {
            Verify ve = new Verify();
            ve.setVerify(StringUtil.toMd5(company.getUsername() + Common.COMPANYREG));
            ve.setUsername(company.getUsername());
            ve.setEmail(company.getEmail());
            ve.setTime(new Date());
            ve.setType(Common.COMPANYREG);
            ve.getData().put(Common.COMPANY, company);

            try {
                String url = request.getScheme() + "://" + request.getServerName() + ":" +
                        request.getServerPort() + request.getContextPath() + "/company/validate?type=" + Common.COMPANYREG;
                String ran = ve.getVerify();
                url += "&s=" + ran;
                Map<String, Object> valMap = new HashMap<String, Object>();
                valMap.put("url", url);
                mailService.sendEmail(company.getEmail(), "注册", "companyReg.ftl", valMap);
            } catch (Exception e) {
                result.setError(e.getMessage());
                return result;
            }

            redisService.insertVerify(ve);
            result.setSuccess(true);
        }
        return result;
    }

    @RequestMapping("/findPassword")
    @ResponseBody
    public Result findPassword(String username, HttpServletRequest request) {
        Result result = new Result();
        Company company = companyService.exists(username);
        if (company == null || StringUtil.isEmpty(company.getEmail())) {
            result.setSuccess(false);
            result.setError("用户不存在或暂未绑定邮箱,无法找回密码");
        } else {
            String email = company.getEmail();

            String url = request.getScheme() + "://" + request.getServerName() + "/company/validate?type=" + Common.COMPANY_FINDPWD;
            String ran = StringUtil.toMd5(username + Common.COMPANY_FINDPWD);
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
            verify.setType(Common.COMPANY_FINDPWD);

            result.getData().put("email", email);

            redisService.insertVerify(verify);
        }

        return result;
    }

    @RequestMapping("/validate")
    public String validateResult(String type, String s, Model model, HttpSession session) {
        Company company = (Company) session.getAttribute(Common.COMPANY);
        Verify verify = redisService.searchVerify(s, type);

        if (Common.COMPANYREG.equals(type)) {
            return validateReg(verify, model, session, s);
        } else if (Common.COMPANY_FINDPWD.equals(type)) {
            return validateFindpwd(verify, s, session);
        }

        return "redirect:/";
    }

    private String validateFindpwd(Verify verify, String s, HttpSession session) {
        if (verify != null && verify.getVerify() != null && verify.getVerify().equals(s)) {
            int hourGap = (int) ((new Date().getTime() - verify.getTime().getTime()) / (1000 * 3600));
            if (hourGap <= 48) {
                session.setAttribute(Common.AUTH, verify.getUsername());
            } else {
                redisService.deleteVerify(verify);
            }
        } else {
            redisService.deleteVerify(verify);
        }
        return "company/find_password";
    }

    private String validateReg(Verify verify, Model model, HttpSession session, String s) {
        if (verify != null && verify.getVerify() != null && verify.getVerify().equals(s)) {
            int hourGap = (int) ((new Date().getTime() - verify.getTime().getTime()) / (1000 * 3600));
            if (hourGap <= 48) {
                Company company = companyService.exists(verify.getUsername());
                if (company == null) {
                    model.addAttribute("result", "很遗憾，注册失败！");
                } else {
                    company = (Company) verify.getData().get(Common.COMPANY);
                    Result result = companyService.addCompany(company);
                    if (result.isSuccess()) {
                        model.addAttribute("result", "恭喜你，注册成功！");
                        session.setAttribute(Common.COMPANY, company);
                    } else {
                        model.addAttribute("result", result.getError());
                    }
                }
            } else {
                model.addAttribute("result", "很遗憾，注册失败！");
            }
        } else {
            model.addAttribute("result", "很遗憾，注册失败！");
        }
        return "";
    }

    @Authorization(Common.AUTH_COMPANY_LOGIN)
    @RequestMapping("modifyPassword")
    @ResponseBody
    public Result modifyCompanyPassword(HttpSession session, String password, String newPassword) {
        Company company = (Company) session.getAttribute(Common.COMPANY);
        Result result = new Result(false);

        if (company == null) {
            result.setError("登录已过期!");
        } else if (companyService.login(company.getUsername(), password) == null) {
            result.setError("密码错误");
        } else {
            companyService.modifyPassword(company.getId(), StringUtil.toMd5(newPassword));
            company = companyService.getById(company.getId());
            session.setAttribute(Common.COMPANY, company);
            result.setSuccess(true);
        }

        return result;
    }

    @Authorization(Common.AUTH_COMPANY_LOGIN)
    @RequestMapping(value = "/updateApply", method = RequestMethod.POST)
    @ResponseBody
    public Result updateApply(@RequestParam(value = "j_id",required = false,defaultValue = "0") int j_id,
                              @RequestParam(value = "r_id",required = false,defaultValue = "0") int r_id,
                              @RequestParam(value = "state",required = false,defaultValue = "1") int state) {
        Result result = companyService.updateApply(j_id, r_id, state);
        return result;
    }

    @RequestMapping(value = "/quit", method = RequestMethod.POST)
    @ResponseBody
    public void quit(HttpSession session) {
        session.removeAttribute(Common.COMPANY);
    }
}
