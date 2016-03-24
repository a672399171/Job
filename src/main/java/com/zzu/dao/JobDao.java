package com.zzu.dao;

import com.zzu.model.*;
import org.apache.ibatis.session.*;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/3/8.
 */
@Component
public class JobDao {
	@Resource
	private SqlSession session;

	public List<Classify> getAllClassifies() {
		List<Classify> classifies = null;
		classifies = session.selectList("mapping.JobMapper.getAllClassifies");
		return classifies;
	}

	public List<Job> getAllCompanyJobs(int post_company) {
		List<Job> jobs = null;
		jobs = session.selectList("mapping.JobMapper.getAllCompanyJobs", post_company);
		return jobs;
	}

	public Job getJobById(int id) {
		Job job = null;
		job = session.selectOne("mapping.JobMapper.getJobById", id);
		return job;
	}

	public List<Resume> searchResume(int grade, int spare_time, String salary, int school) {
		List<Resume> resumes = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("grade", grade);
		map.put("spare_time", spare_time);
		map.put("salary", salary);
		map.put("school", school);
		resumes = session.selectList("mapping.ResumeMapper.searchResume", map);

		return resumes;
	}

	public List<School> getSchools() {

		List<School> schools = session.selectList("mapping.JobMapper.getSchools");
		return schools;
	}

	public Resume getResumeById(int id) {
		Resume resume = session.selectOne("mapping.ResumeMapper.getResumeById", id);
		return resume;
	}

	public void addSchool(String school) {
		session.insert("mapping.JobMapper.addSchool", school);
	}

	public void addMajors(List<String> majors) {
		session.insert("mapping.JobMapper.addMajors", majors);
	}

	public List<Job> getRecentJobs(int num) {
		List<Job> jobs = session.selectList("mapping.JobMapper.getRecentJobs", num);
		return jobs;
	}

	public List<Comment> getComments(int id) {
		List<Comment> comments = session.selectList("mapping.JobMapper.getComments", id);
		return comments;
	}

	public Collection getCollection(int u_id, int j_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("j_id", j_id);
		Collection collection = session.selectOne("mapping.JobMapper.getCollection", map);
		return collection;
	}

	public void deleteCollection(int u_id, int j_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("j_id", j_id);
		session.delete("mapping.JobMapper.deleteCollection", map);
	}

	public void addCollection(int u_id, int j_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("j_id", j_id);
		session.insert("mapping.JobMapper.addCollection", map);
	}

	public List<Apply> getApplies(int u_id, int j_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("j_id", j_id);

		List<Apply> applies = session.selectList("mapping.JobMapper.getApplies", map);
		return applies;
	}

	public void addApply(Apply apply) {
		session.insert("mapping.JobMapper.addApply", apply);
	}

	/**
	 * 添加大类
	 *
	 * @param classify
	 */
	public void addClassify(Classify classify) {
		session.insert("mapping.JobMapper.addClassify", classify);
	}

	/**
	 * 更新大类
	 *
	 * @param classify
	 */
	public void updateClassify(Classify classify) {
		session.insert("mapping.JobMapper.updateClassify", classify);
	}

	/**
	 * 删除大类
	 *
	 * @param id
	 */
	public void deleteClassify(int id) {
		session.insert("mapping.JobMapper.deleteClassify", id);
	}

	/**
	 * 添加小类
	 *
	 * @param position
	 */
	public void addPosition(Position position) {
		session.insert("mapping.JobMapper.addPosition", position);
	}

	/**
	 * 更新小类
	 *
	 * @param position
	 */
	public void updatePosition(Position position) {
		session.insert("mapping.JobMapper.updatePosition", position);
	}

	/**
	 * 删除小类
	 *
	 * @param id
	 */
	public void deletePosition(int id) {
		session.insert("mapping.JobMapper.deletePosition", id);
	}

	/**
	 * 查询职位
	 *
	 * @return
	 */
	public List<Job> searchJobs(int[] p_ids, int l, int h, int page, int time) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("p_ids", p_ids);
		map.put("l", l);
		map.put("h", h);
		map.put("page", page);
		map.put("start", (page - 1) * Common.COUNT);
		map.put("count", 10);
		map.put("time", time);

		List<Job> jobs = session.selectList("mapping.JobMapper.searchJobs", map);
		return jobs;
	}

	/**
	 * 获取总条数
	 *
	 * @param p_ids
	 * @param l
	 * @param h
	 * @return
	 */
	public int getJobCount(int[] p_ids, int time, int l, int h) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("p_ids", p_ids);
		map.put("l", l);
		map.put("h", h);
		map.put("time", time);

		int count = session.selectOne("mapping.JobMapper.getJobCount", map);
		return count;
	}

	/**
	 * 模糊搜索工作
	 *
	 * @param keyword
	 * @param l
	 *@param h @return
	 */
	public List<Job> searchJobs(String keyword, int page, int l, int h,int time,int c_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("page", page);
		map.put("l", l);
		map.put("h", h);
		map.put("start", (page - 1) * Common.COUNT);
		map.put("count", 10);
		map.put("c_id", c_id);
		map.put("time", time);

		List<Job> jobs = session.selectList("mapping.JobMapper.vagueSearchJobs", map);
		return jobs;
	}

	/**
	 * 查询大类下的所有小类
	 *
	 * @param c_id
	 * @return
	 */
	public List<Position> searchPositions(int c_id) {
		List<Position> positions = null;
		Position position = new Position();
		position.setC_id(c_id);
		positions = session.selectList("mapping.JobMapper.searchPositions", position);
		return positions;
	}

	/**
	 * 获取总条数
	 * @param keyword
	 * @return
	 */
	public int getJobCount(String keyword, int l, int h,int time,int c_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", keyword);
		map.put("l", l);
		map.put("h", h);
		map.put("c_id", c_id);
		map.put("time", time);

		int count = session.selectOne("mapping.JobMapper.getVagueJobCount", map);
		return count;
	}

	/**
	 * 获取评论条数
	 * @param id
	 * @return
	 */
	public int getCommentCount(int id) {
		int count = session.selectOne("mapping.JobMapper.getCommentCount",id);
		return count;
	}

	/**
	 * 获取指定页的评论
	 * @param id
	 * @param page
	 * @return
	 */
	public List<Comment> getComments(int id, int page) {
		List<Comment> comments = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("page", page);
		map.put("start", (page - 1) * Common.COUNT);
		map.put("count", 10);

		comments = session.selectList("mapping.JobMapper.getCommentsPage",map);
		return comments;
	}
}
