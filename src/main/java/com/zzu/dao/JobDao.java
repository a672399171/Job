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

    int updateJob(Job job);

    int addJob(Job job);

    int deleteJobs(int[] ids);

    List<Job> searchJobs(@Param("companyId") int companyId,
                         @Param("pIds") int[] pIds,
                         @Param("time") int time,
                         @Param("low") int low,
                         @Param("high") int high,
                         @Param("keyword") String keyword,
                         @Param("status") int status,
                         @Param("start") int start,
                         @Param("count") int count);

    int getJobCount(@Param("companyId") int companyId,
                    @Param("pIds") int[] pIds,
                    @Param("time") int time,
                    @Param("low") int low,
                    @Param("high") int high,
                    @Param("keyword") String keyword,
                    @Param("status") int status);

    int changeJobStatus(@Param("jId") int jId,
                        @Param("status") int status);

    List<Job> getRecommendJobs(@Param("time") int time,
                               @Param("pId") int pId);
}
