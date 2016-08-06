package com.zzu.service.impl;

import com.zzu.common.Common;
import com.zzu.dao.ClassifyDao;
import com.zzu.dao.ResumeDao;
import com.zzu.dto.Result;
import com.zzu.model.Resume;
import com.zzu.service.ResumeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("resumeService")
public class ResumeServiceImpl implements ResumeService {
    @Resource
    private ResumeDao resumeDao;
    @Resource
    private ClassifyDao classifyDao;

    public void saveOrUpdateResume(Resume resume) {
        /*if(getResumeByUid(resume.getU_id()) == null) {
            insertResume(resume);
		} else {
			updateResume(resume);
		}*/
    }

    public void insertResume(Resume resume) {
        resumeDao.insertResume(resume);
    }

    public void updateResume(Resume resume) {
        resumeDao.updateResume(resume);
    }

    public Resume getByUid(int id) {
        Resume resume = resumeDao.getByUid(id);
        if (resume != null && resume.getJob_type() != null) {
            String[] array = resume.getJob_type().split("#");

            if (array != null && array.length > 0) {
                int[] intArr = new int[array.length];

                for (int i = 0; i < array.length; i++) {
                    intArr[i] = Integer.parseInt(array[i]);
                }

                resume.setPositions(classifyDao.searchPositionsWithArr(intArr));
            }
        }
        return resume;
    }

    public Result<Resume> searchResumes(int grade, int time, String salary, String keyword, int school, int page) {
        Result<Resume> result = new Result<Resume>();
        if (page < 1) {
            result.setSuccess(false);
            result.setError("页码错误");
        } else {
            result.setList(resumeDao.searchResumes(grade, time, salary, keyword, school, (page - 1) * Common.COUNT, Common.COUNT));
            result.setTotalItem(resumeDao.getResumeCount(grade, time, salary, keyword, school));
        }

        return result;
    }
}
