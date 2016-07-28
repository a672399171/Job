package com.zzu.service.impl;

import com.zzu.dao.JobDao;
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

    public List<Job> searchJobs(int page, int pageSize) {
        if (page < 1) {
            return null;
        }
        return jobDao.searchJobs((page - 1) * pageSize, pageSize);
    }

    public Job getJobById(int id) {
        return jobDao.getJobById(id);
    }
}
