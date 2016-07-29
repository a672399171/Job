package com.zzu.controller;

import com.zzu.dto.Result;
import com.zzu.model.*;
import com.zzu.model.Collection;
import com.zzu.service.CommentService;
import com.zzu.service.JobService;
import com.zzu.service.RedisService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Administrator on 2016/3/8.
 */
@Controller
@RequestMapping("job")
public class JobController {
    @Resource
    private JobService jobService;
    @Resource
    private CommentService commentService;
    @Resource
    private RedisService redisService;

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

    @RequestMapping(value = "/company/{id}/page/{page}", method = RequestMethod.GET)
    @ResponseBody
    public Result<Job> companyJobs(@PathVariable("id") int id,
                                   @PathVariable("page") int page) {
        return jobService.getCompanyJobs(id, page, Common.SMALL_COUNT);
    }

    @RequestMapping("/{id}/comment/page/{page}")
    @ResponseBody
    public Result<Comment> getComments(@PathVariable("id") int id,
                                       @PathVariable("page") int page) {
        return commentService.getComments(id, page, Common.COUNT);
    }

    @RequestMapping("/schoolData")
    @ResponseBody
    public List<School> schoolData() {
        return redisService.getSchools();
    }

}
