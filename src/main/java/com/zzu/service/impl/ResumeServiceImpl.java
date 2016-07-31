package com.zzu.service.impl;

import com.zzu.dao.ResumeDao;
import com.zzu.model.Resume;
import com.zzu.service.ResumeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("resumeService")
public class ResumeServiceImpl implements ResumeService {
	@Resource
	private ResumeDao resumeDao;

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
		if(resume != null) {

		}
		return resume;
	}
}
