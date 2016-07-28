package com.zzu.service;

import com.zzu.model.Job;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface JobService {
    List<Job> searchJobs(int page, int pageSize);

    Job getJobById(int id);
}
