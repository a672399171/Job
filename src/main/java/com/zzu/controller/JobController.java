package com.zzu.controller;

import com.zzu.model.*;
import com.zzu.model.Collection;
import com.zzu.service.impl.JobServiceImpl;
import com.zzu.service.impl.MailServiceImpl;
import com.zzu.service.impl.ResumeServiceImpl;
import com.zzu.service.impl.UserServiceImpl;
import com.zzu.util.DateUtil;
import com.zzu.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.*;

/**
 * Created by Administrator on 2016/3/8.
 */
@Controller
@RequestMapping("job")
public class JobController {
    @Resource
    private JobServiceImpl jobService;

    /**
     * 用户界面查看职位详情
     *
     * @param id
     * @param model
     * @param session
     * @return
     */
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String detail(@PathVariable("id") Integer id, Model model, HttpSession session) {
        User user = (User) session.getAttribute(Common.USER);
        Collection collection = null;

        Job job = jobService.getJobById(id);
        model.addAttribute("job", job);

        if (user != null) {
            // collection = jobService.getCollection(user.getId(), id);
            /*List<Apply> applies = jobService.getApplies(user.getId(), id);
            for (Apply apply : applies) {
                if (apply.getJob().getId() == id) {
                    model.addAttribute("apply", apply);
                    break;
                }
            }*/
        }

        //model.addAttribute("collection", collection);
        return "job_detail";
    }
}
