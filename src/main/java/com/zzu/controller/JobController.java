package com.zzu.controller;

import com.zzu.common.Common;
import com.zzu.common.annotaion.Authorization;
import com.zzu.common.enums.JobStateEnum;
import com.zzu.dto.Result;
import com.zzu.model.*;
import com.zzu.model.Collection;
import com.zzu.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("job")
public class JobController {
    @Resource
    private JobService jobService;
    @Resource
    private CommentService commentService;
    @Resource
    private RedisService redisService;
    @Resource
    private UserService userService;
    @Resource
    private ClassifyService classifyService;

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
        return jobService.getCompanyJobs(id, JobStateEnum.RUNNING_JOB.getValue(), page, Common.SMALL_COUNT);
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

    @RequestMapping("/typeData")
    @ResponseBody
    public List<Classify> typeData() {
        return redisService.getClassifies();
    }

    @RequestMapping("/positionData")
    @ResponseBody
    public List<Position> positionData(@RequestParam(value = "cId", required = false) Integer cId) {
        if (cId == null) {
            return null;
        }
        List<Classify> classifies = redisService.getClassifies();
        for (Classify c : classifies) {
            if (c.getId() == cId) {
                return c.getPositions();
            }
        }
        return null;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        return "job_list";
    }

    @RequestMapping(value = "/vagueList", method = RequestMethod.GET)
    public String vagueList() {
        return "vague_search_job";
    }

    @Authorization({Common.AUTH_USER_LOGIN, Common.AUTH_ADMIN_LOGIN, Common.COMPANY})
    @RequestMapping(value = "/listData", method = RequestMethod.POST)
    @ResponseBody
    public Result<Job> listData(@RequestParam(value = "cId", required = false) Integer cId,
                                @RequestParam(value = "pId", required = false) Integer pId,
                                @RequestParam(value = "time", required = false) Integer time,
                                @RequestParam(value = "low", required = false) Integer low,
                                @RequestParam(value = "high", required = false) Integer high,
                                @RequestParam(value = "keyword", required = false) String keyword,
                                @RequestParam(value = "status", required = false) Integer page) {
        int[] pIds = null;
        if (pId != null && pId > 0) {
            pIds = new int[]{pId};
        } else if (cId != null && cId > 0) {
            List<Position> positions = classifyService.searchPositions(cId);
            pIds = new int[positions.size()];
            for (int i = 0; i < positions.size(); i++) {
                pIds[i] = positions.get(i).getId();
            }
        }
        if (time == null) {
            time = 0;
        }
        if (low == null) {
            low = 0;
        }
        if (high == null) {
            high = 0;
        }
        if (page == null) {
            page = 1;
        }
        return jobService.searchJobs(pIds, time, low, high, keyword, page, Common.COUNT);
    }

    @RequestMapping("/companyJobs")
    @ResponseBody
    public Result companyJobs(@RequestParam(value = "companyId", defaultValue = "0") Integer companyId,
                              @RequestParam(value = "page", defaultValue = "1") Integer page) {
        return jobService.getCompanyJobs(companyId, -1, page, Common.COUNT);
    }

    @RequestMapping("/changeJobStatus")
    @ResponseBody
    public Result changeJobStatus(@RequestParam(value = "j_id", defaultValue = "0") Integer j_id,
                                  @RequestParam(value = "status", defaultValue = "0") Integer status) {
        return jobService.changeJobStatus(j_id, status);
    }
}
