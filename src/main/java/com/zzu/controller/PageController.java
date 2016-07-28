package com.zzu.controller;

import com.zzu.model.Classify;
import com.zzu.model.Common;
import com.zzu.model.Job;
import com.zzu.model.Position;
import com.zzu.service.ClassifyService;
import com.zzu.service.JobService;
import com.zzu.service.RedisService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping
public class PageController {
    @Resource
    private ClassifyService classifyService;
    @Resource
    private JobService jobService;
    @Resource
    private RedisService redisService;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(Model model) {
        List<Classify> classifies = redisService.getClassifies();
        List<Job> jobs = jobService.searchJobs(1, Common.COUNT);
        model.addAttribute("classifies", classifies);
        model.addAttribute("jobs",jobs);

        return "index";
    }
}
