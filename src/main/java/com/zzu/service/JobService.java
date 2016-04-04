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

	public List<Job> getCompanyJobs(int post_company, int page) {
		return jobDao.getJobsByCompany(post_company, page);
	}

	public int getCompanyJobCount(int id) {
		return jobDao.getCompanyJobCount(id);
	}

	public Job getJobById(int id) {
		return jobDao.getJobById(id);
	}

	public List<Resume> searchResume(int grade, int spare_time, String salary, int school, int page,String filter) {
		List<Resume> resumes = jobDao.searchResume(grade, spare_time, salary, school, page,filter);

		return resumes;
	}

	public Resume getResumeById(int id) {
		return jobDao.getResumeById(id);
	}

	public List<Job> getRecentJobs(int num) {
		return jobDao.getRecentJobs(num);
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
	public List<Job> searchJobsByPid(int[] p_ids, int time, int low, int high, int page,String filter,int state) {
		List<Job> jobs = jobDao.searchJobsByPid(p_ids, time, low, high, page,filter,state);

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
	public int getJobCount(int[] p_ids, int time, int low, int high,String filter,int state) {
		return jobDao.getJobCount(p_ids, time, low, high,filter,state);
	}

	/**
	 * 模糊搜索工作
	 *
	 * @param keyword
	 * @param low
	 * @param high    @return
	 */
	public List<Job> searchJobs(String keyword, int page, int low, int high, int time, int c_id) {
		return jobDao.searchJobs(keyword, page, low, high, time, c_id);
	}

	/**
	 * 获取总条数
	 *
	 * @param keyword
	 * @return
	 */
	public int getJobCount(String keyword, int low, int high, int time, int c_id) {
		return jobDao.getJobCount(keyword, low, high, time, c_id);
	}

	/**
	 * 更新职位信息
	 *
	 * @param job
	 */
	public void updateJob(Job job) {
		jobDao.updateJob(job);
	}

	/**
	 * 增加职位
	 *
	 * @param job
	 */
	public void addJob(Job job) {
		jobDao.addJob(job);
	}

	/**
	 * 删除职位
	 *
	 * @param ids
	 */
	public int deleteJobs(int[] ids) {
		return jobDao.deleteJobs(ids);
	}

	/**
	 * 根据id返回小类
	 *
	 * @param id
	 * @return
	 */
	public Position getPositionById(int id) {
		return jobDao.getPositionById(id);
	}

	/**
	 * 获取评论数
	 *
	 * @param id
	 * @return
	 */
	public int getCommentCount(int id) {
		return jobDao.getCommentCount(id);
	}

	/**
	 * 获取指定页的评论
	 *
	 * @param id
	 * @param page
	 * @return
	 */
	public List<Comment> getComments(int id, int page) {
		return jobDao.getComments(id, page);
	}

	/**
	 * 获取所有的学院和专业信息
	 *
	 * @return
	 */
	public List<Major> getSchoolsAndMajors() {
		return jobDao.getSchoolsAndMajors();
	}

	/**
	 * 改变职位的运行状态
	 *
	 * @param j_id
	 * @param status
	 */
	public void changeJobStatus(int j_id, int status) {
		jobDao.changeJobStatus(j_id, status);
	}

	/**
	 * 获取投递该公司的简历
	 *
	 * @param id
	 * @param page
	 * @return
	 */
	public List<Apply> getAppliesByCompany(int id, int page) {
		return jobDao.getAppliesByCompany(id, page);
	}

	/**
	 * 获取投递该公司简历的个数
	 *
	 * @param id
	 * @return
	 */
	public int getCompanyApplyCount(int id) {
		return jobDao.getCompanyApplyCount(id);
	}

	/**
	 * 更新简历的投递状态
	 *
	 * @param j_id
	 * @param r_id
	 * @param state
	 */
	public void updateApply(int j_id, int r_id, int state) {
		jobDao.updateApply(j_id, r_id, state);
	}

	/**
	 * 获取搜索到的简历的数量
	 * @param grade
	 * @param time
	 * @param salary
	 * @param school
	 * @return
	 */
	public int getResumeCount(int grade, int time, String salary, int school,String filter) {
		return jobDao.getResumeCount(grade,time,salary,school,filter);
	}
}
