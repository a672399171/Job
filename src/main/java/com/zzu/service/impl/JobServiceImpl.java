package com.zzu.service.impl;

import com.zzu.dao.JobDao;
import com.zzu.dto.Result;
import com.zzu.model.*;
import com.zzu.service.JobService;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2016/3/8.
 */
@Component("jobService")
public class JobServiceImpl implements JobService {
    @Resource
    private JobDao jobDao;

    public Result<Job> searchJobs(int page, int pageSize) {
        Result<Job> result = new Result<Job>(page, pageSize);
        if (page < 1) {
            result.setSuccess(false);
            result.setError("页数错误");
            return result;
        }
        List<Job> jobs = jobDao.searchJobs(0, null, 0, 0, 0, null, 1, (page - 1) * pageSize, pageSize);
        result.setTotalItem(jobDao.getJobCount(0, null, 0, 0, 0, null, 1));
        result.setList(jobs);

        return result;
    }

    public Job getJobById(int id) {
        return jobDao.getJobById(id);
    }

    public Result<Job> getCompanyJobs(int companyId, int page, int pageSize) {
        Result<Job> result = new Result<Job>(page, pageSize);
        if (page < 1) {
            result.setSuccess(false);
            result.setError("页数错误");
            return result;
        }
        List<Job> jobs = jobDao.searchJobs(companyId, null, 0, 0, 0, null, 1, (page - 1) * pageSize, pageSize);
        result.setTotalItem(jobDao.getJobCount(companyId, null, 0, 0, 0, null, 1));
        result.setList(jobs);

        return result;
    }

    public Result<Job> searchJobs(int[] pIds, int time, int low, int high, String keyword, int page, int pageSize) {
        Result<Job> result = new Result<Job>(page, pageSize);
        if (page < 1) {
            result.setSuccess(false);
            result.setError("页数错误");
            return result;
        }
        List<Job> jobs = jobDao.searchJobs(0, pIds, time, low, high, keyword, 1, (page - 1) * pageSize, pageSize);
        result.setTotalItem(jobDao.getJobCount(0, pIds, time, low, high, keyword, 1));
        result.setList(jobs);
        return result;
    }

}
