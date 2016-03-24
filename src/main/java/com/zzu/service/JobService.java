package com.zzu.service;

import com.zzu.dao.JobDao;
import com.zzu.model.*;
import com.zzu.util.StringUtil;
import org.springframework.cglib.core.TinyBitSet;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Iterator;
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

	public List<Resume> searchResume(int grade, int spare_time, String salary, int school) {
		List<Resume> resumes = jobDao.searchResume(grade, spare_time, salary, school);

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

	public Collection getCollection(int u_id, int j_id) {
		return jobDao.getCollection(u_id, j_id);
	}

	public void updateCollection(boolean collection, int u_id, int j_id) {
		if (collection) {
			jobDao.addCollection(u_id, j_id);
		} else {
			jobDao.deleteCollection(u_id, j_id);
		}
	}

	public List<Apply> getApplies(int u_id, int j_id) {
		return jobDao.getApplies(u_id, j_id);
	}

	public void addApply(Apply apply) {
		jobDao.addApply(apply);
	}

	/**
	 * 添加大类
	 *
	 * @param classify
	 */
	public void addClassify(Classify classify) {
		jobDao.addClassify(classify);
	}

	/**
	 * 更新大类
	 *
	 * @param classify
	 */
	public void updateClassify(Classify classify) {
		jobDao.updateClassify(classify);
	}

	/**
	 * 删除大类
	 *
	 * @param id
	 */
	public void deleteClassify(int id) {
		jobDao.deleteClassify(id);
	}

	/**
	 * 添加小类
	 *
	 * @param position
	 */
	public void addPosition(Position position) {
		jobDao.addPosition(position);
	}

	/**
	 * 更新小类
	 *
	 * @param position
	 */
	public void updatePosition(Position position) {
		jobDao.updatePosition(position);
	}

	/**
	 * 删除小类
	 *
	 * @param id
	 */
	public void deletePosition(int id) {
		jobDao.deletePosition(id);
	}

	/**
	 * 查询职位
	 *
	 * @return
	 */
	public List<Job> searchJobs(int[] p_ids, int time, int low, int high, int page) {
		List<Job> jobs = jobDao.searchJobs(p_ids, low, high, page, time);

		/*//使用增强的for循环会抛出java.util.ConcurrentModificationException,用iterator替代
		Iterator<Job> iterator = jobs.iterator();
		while (iterator.hasNext()) {
			Job job = iterator.next();
			int workTime = job.getWork_time();
			int temp = workTime & time;
			if (temp == 0) {
				iterator.remove();
			}
		}*/

		return jobs;
	}

	/**
	 * 获取总条数
	 *
	 * @param p_ids
	 * @param low
	 * @param high
	 * @return
	 */
	public int getJobCount(int[] p_ids, int time, int low, int high) {
		return jobDao.getJobCount(p_ids, time, low, high);
	}

	/**
	 * 模糊搜索工作
	 *
	 * @param keyword
	 * @param low
	 * @param high    @return
	 */
	public List<Job> searchJobs(String keyword, int page, int low, int high,int time,int c_id) {
		return jobDao.searchJobs(keyword, page, low, high,time,c_id);
	}

	/**
	 * 获取总条数
	 *
	 * @param keyword
	 * @return
	 */
	public int getJobCount(String keyword, int low, int high,int time,int c_id) {
		return jobDao.getJobCount(keyword, low, high,time,c_id);
	}

	/**
	 * 获取评论数
	 * @param id
	 * @return
	 */
	public int getCommentCount(int id) {
		return jobDao.getCommentCount(id);
	}

	/**
	 * 获取指定页的评论
	 * @param id
	 * @param page
	 * @return
	 */
	public List<Comment> getComments(int id, int page) {
		return jobDao.getComments(id,page);
	}
}
