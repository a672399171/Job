package com.zzu.dao;

import com.zzu.model.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface JobDao {
    List<Job> getAllCompanyJobs(int postCompany);

    Job getJobById(@Param("id") int id);

    List<Job> searchJobsByPid(int[] pIds, int time, int l, int h, int page, String filter, int state);

    int getJobCount(int[] pIds, int time, int l, int h, String filter, int state);

    void updateJob(Job job);

    void addJob(Job job);

    int deleteJobs(int[] ids);

    //List<Job> searchJobs(String keyword, int page, int l, int h, int time, int cId);
    List<Job> searchJobs(@Param("start") int start,
                         @Param("count") int count);

    int getJobCount(String keyword, int l, int h, int time, int cId);

    List<Job> getJobsByCompany(int company_id, int page);

    int getCompanyJobCount(int id);

    void changeJobStatus(int jId, int status);

    List<Job> getRecommendJobs(int time, int pId);
}
