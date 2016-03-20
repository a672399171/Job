package com.zzu.service;

import com.zzu.dao.JobDao;
import com.zzu.model.*;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Administrator on 2016/3/8.
 */
@Component
public class JobService {
	@Resource
	private JobDao jobDao;

	public List<Classify> getAllClassifies() {
		return jobDao.getAllClassifies();
	}

	public List<Position> searchPositions(int c_id) {
		return jobDao.searchPositions(c_id);
	}

	public List<Job> getAllCompanyJobs(int post_company) {
		return jobDao.getAllCompanyJobs(post_company);
	}

	public Job getJobById(int id) {
		return jobDao.getJobById(id);
	}

	public List<Resume> searchResume(int grade, String spare_time, String salary, int school) {
		List<Resume> resumes = jobDao.searchResume(grade, spare_time, salary, school);

		for (Resume resume : resumes) {
			String time1 = resume.getSpare_time();
			for (int i = 0; i < time1.length(); i += 2) {
				if (spare_time.charAt(i) == '1' && time1.charAt(i) == '0' && time1.charAt(i + 1) == '0') {
					resumes.remove(resume);
					break;
				}
			}
		}
		return resumes;
	}

	public List<School> getSchools() {
		return jobDao.getSchools();
	}

	public Resume getResumeById(int id) {
		return jobDao.getResumeById(id);
	}

	public void addSchool(String school) {
		jobDao.addSchool(school);
	}

	public void addMajors(List<String> majors) {
		jobDao.addMajors(majors);
	}

	public List<Job> getRecentJobs(int num) {
		return jobDao.getRecentJobs(num);
	}

	public List<Comment> getComments(int id) {
		return jobDao.getComments(id);
	}

	public Collection getCollection(int u_id,int j_id) {
		return jobDao.getCollection(u_id,j_id);
	}

	public void updateCollection(boolean collection,int u_id,int j_id) {
		if(collection) {
			jobDao.addCollection(u_id,j_id);
		} else {
			jobDao.deleteCollection(u_id,j_id);
		}
	}

	public List<Apply> getApplies(int u_id,int j_id) {
		return jobDao.getApplies(u_id, j_id);
	}

	public void addApply(Apply apply) {
		jobDao.addApply(apply);
	}

	/**
	 * 添加大类
	 * @param classify
	 */
	public void addClassify(Classify classify) {
		jobDao.addClassify(classify);
	}

	/**
	 * 更新大类
	 * @param classify
	 */
	public void updateClassify(Classify classify) {
		jobDao.updateClassify(classify);
	}

	/**
	 * 删除大类
	 * @param id
	 */
	public void deleteClassify(int id) {
		jobDao.deleteClassify(id);
	}

	/**
	 * 添加小类
	 * @param position
	 */
	public void addPosition(Position position) {
		jobDao.addPosition(position);
	}

	/**
	 * 更新小类
	 * @param position
	 */
	public void updatePosition(Position position) {
		jobDao.updatePosition(position);
	}

	/**
	 * 删除小类
	 * @param id
	 */
	public void deletePosition(int id) {
		jobDao.deletePosition(id);
	}

	/**
	 * 查询职位
	 * @return
	 */
	public List<Job> searchJobs(int[] p_ids) {
		return jobDao.searchJobs(p_ids);
	}
}
