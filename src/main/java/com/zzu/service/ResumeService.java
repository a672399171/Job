package com.zzu.service;

import com.zzu.dto.Result;
import com.zzu.model.Job;
import com.zzu.model.Resume;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface ResumeService {
    Resume getByUid(int id);

    Result<Resume> searchResumes(int grade, int time, String salary, String keyword, int school, int page);
}
