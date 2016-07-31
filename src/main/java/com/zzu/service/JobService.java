package com.zzu.service;

import com.zzu.dto.Result;
import com.zzu.model.Job;
import com.zzu.model.School;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface JobService {
    Result<Job> searchJobs(int page, int pageSize);

    Job getJobById(int id);

    Result<Job> getCompanyJobs(int companyId, int page, int pageSize);

    Result<Job> searchJobs(int[] pIds, int time, int low, int high, String keyword, int page, int pageSize);
}
