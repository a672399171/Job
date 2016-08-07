package com.zzu.dao;

import com.zzu.dto.Result;
import com.zzu.model.Resume;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface ResumeDao {
    Resume getByUid(int id);

    List<Resume> searchResumes(@Param("grade") int grade,
                                @Param("time") int time,
                                @Param("salary") String salary,
                                @Param("keyword") String keyword,
                                @Param("school") int school,
                                @Param("start") int start,
                                @Param("count") int count);

    int getResumeCount(@Param("grade") int grade,
                       @Param("time") int time,
                       @Param("salary") String salary,
                       @Param("keyword") String keyword,
                       @Param("school") int school);

    Resume getResumeByUid(int uId);

    void insertResume(Resume resume);

    void updateResume(Resume resume);
}
