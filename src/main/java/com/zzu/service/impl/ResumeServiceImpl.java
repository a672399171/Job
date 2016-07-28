package com.zzu.service.impl;

import com.zzu.daoback.ResumeDao;
import com.zzu.model.Resume;

import javax.annotation.Resource;

/**
 * Created by Administrator on 2016/3/4.
 */
//@Component
public class ResumeServiceImpl {
	@Resource
	private ResumeDao resumeDao;

	public Resume getResumeByUid(int u_id) {
		return resumeDao.getResumeByUid(u_id);
	}

	public void saveOrUpdateResume(Resume resume) {
		if(getResumeByUid(resume.getU_id()) == null) {
			insertResume(resume);
		} else {
			updateResume(resume);
		}
	}

	public void insertResume(Resume resume) {
		resumeDao.insertResume(resume);
	}

	public void updateResume(Resume resume) {
		resumeDao.updateResume(resume);
	}
}
