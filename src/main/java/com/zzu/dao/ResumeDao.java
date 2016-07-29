package com.zzu.dao;

import com.zzu.model.Resume;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface ResumeDao {
    Resume getByUid(int id);

    List<Resume> searchResume(int grade, int spareTime, String salary, int school, int page, String filter, boolean push);

    int getResumeCount(int grade, int time, String salary, int school, String filter, boolean push);

    Resume getResumeByUid(int uId);

    void insertResume(Resume resume);

    void updateResume(Resume resume);
}
