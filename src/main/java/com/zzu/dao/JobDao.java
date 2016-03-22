package com.zzu.dao;

import com.zzu.model.*;
import com.zzu.service.JobService;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.*;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/3/8.
 */
@Component
public class JobDao {
	private SqlSessionFactory factory = null;
	private SqlSession session = null;

	public JobDao() {
		try {
			Reader reader = Resources.getResourceAsReader("SqlMapConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<Classify> getAllClassifies() {
		List<Classify> classifies = null;
		session = factory.openSession();
		classifies = session.selectList("mapping.JobMapper.getAllClassifies");
		session.commit();
		return classifies;
	}

	public List<Job> getAllCompanyJobs(int post_company) {
		List<Job> jobs = null;
		session = factory.openSession();
		jobs = session.selectList("mapping.JobMapper.getAllCompanyJobs", post_company);
		session.commit();
		return jobs;
	}

	public Job getJobById(int id) {
		Job job = null;
		session = factory.openSession();
		job = session.selectOne("mapping.JobMapper.getJobById", id);
		session.commit();
		return job;
	}

	public List<Resume> searchResume(int grade, String spare_time, String salary, int school) {
		List<Resume> resumes = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("grade", grade);
		map.put("spare_time", spare_time);
		map.put("salary", salary);
		map.put("school", school);
		session = factory.openSession();
		resumes = session.selectList("mapping.ResumeMapper.searchResume", map);
		session.commit();

		return resumes;
	}

	public List<School> getSchools() {
		session = factory.openSession();

		List<School> schools = session.selectList("mapping.JobMapper.getSchools");
		session.commit();
		return schools;
	}

	public Resume getResumeById(int id) {
		session = factory.openSession();
		Resume resume = session.selectOne("mapping.ResumeMapper.getResumeById", id);
		session.commit();
		return resume;
	}


	public void addSchool(String school) {
		session = factory.openSession();
		session.insert("mapping.JobMapper.addSchool", school);
		session.commit();
	}

	public void addMajors(List<String> majors) {
		session = factory.openSession();
		session.insert("mapping.JobMapper.addMajors", majors);
		session.commit();
	}

	public List<Job> getRecentJobs(int num) {
		session = factory.openSession();
		List<Job> jobs = session.selectList("mapping.JobMapper.getRecentJobs", num);
		session.commit();
		return jobs;
	}

	public List<Comment> getComments(int id) {
		session = factory.openSession();
		List<Comment> comments = session.selectList("mapping.JobMapper.getComments", id);
		session.commit();
		return comments;
	}

	public Collection getCollection(int u_id, int j_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("j_id", j_id);
		session = factory.openSession();
		Collection collection = session.selectOne("mapping.JobMapper.getCollection", map);
		session.commit();
		return collection;
	}

	public void deleteCollection(int u_id, int j_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("j_id", j_id);
		session = factory.openSession();
		session.delete("mapping.JobMapper.deleteCollection", map);
		session.commit();
	}

	public void addCollection(int u_id, int j_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("j_id", j_id);
		session = factory.openSession();
		session.insert("mapping.JobMapper.addCollection", map);
		session.commit();
	}

	public List<Apply> getApplies(int u_id, int j_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("j_id", j_id);

		session = factory.openSession();
		List<Apply> applies = session.selectList("mapping.JobMapper.getApplies", map);
		session.commit();
		return applies;
	}

	public void addApply(Apply apply) {
		session = factory.openSession();
		session.insert("mapping.JobMapper.addApply", apply);
		session.commit();
	}

	/**
	 * 添加大类
	 *
	 * @param classify
	 */
	public void addClassify(Classify classify) {
		session = factory.openSession();
		session.insert("mapping.JobMapper.addClassify", classify);
		session.commit();
	}

	/**
	 * 更新大类
	 *
	 * @param classify
	 */
	public void updateClassify(Classify classify) {
		session = factory.openSession();
		session.insert("mapping.JobMapper.updateClassify", classify);
		session.commit();
	}

	/**
	 * 删除大类
	 *
	 * @param id
	 */
	public void deleteClassify(int id) {
		session = factory.openSession();
		session.insert("mapping.JobMapper.deleteClassify", id);
		session.commit();
	}

	/**
	 * 添加小类
	 *
	 * @param position
	 */
	public void addPosition(Position position) {
		session = factory.openSession();
		session.insert("mapping.JobMapper.addPosition", position);
		session.commit();
	}

	/**
	 * 更新小类
	 *
	 * @param position
	 */
	public void updatePosition(Position position) {
		session = factory.openSession();
		session.insert("mapping.JobMapper.updatePosition", position);
		session.commit();
	}

	/**
	 * 删除小类
	 *
	 * @param id
	 */
	public void deletePosition(int id) {
		session = factory.openSession();
		session.insert("mapping.JobMapper.deletePosition", id);
		session.commit();
	}

	/**
	 * 查询职位
	 *
	 * @return
	 */
	public List<Job> searchJobs(int[] p_ids, int l, int h, int page) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("p_ids", p_ids);
		map.put("l", l);
		map.put("h", h);
		map.put("page", page);
		map.put("start", (page - 1) * Common.COUNT);
		map.put("count", 10);

		session = factory.openSession();
		List<Job> jobs = session.selectList("mapping.JobMapper.searchJobs", map);
		session.commit();
		return jobs;
	}

	/**
	 * 获取总条数
	 * @param p_ids
	 * @param l
	 * @param h
	 * @return
	 */
	public int getJobCount(int[] p_ids, int l, int h) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("p_ids", p_ids);
		map.put("l", l);
		map.put("h", h);
		final int[] count = new int[1];

		session = factory.openSession();
		session.select("mapping.JobMapper.getJobCount", new ResultHandler() {
			public void handleResult(ResultContext resultContext) {
				count[0] = resultContext.getResultCount();
			}
		});
		session.commit();
		return count[0];
	}

	/**
	 * 查询大类下的所有小类
	 *
	 * @param c_id
	 * @return
	 */
	public List<Position> searchPositions(int c_id) {
		List<Position> positions = null;
		session = factory.openSession();
		Position position = new Position();
		position.setC_id(c_id);
		positions = session.selectList("mapping.JobMapper.searchPositions", position);
		session.commit();
		return positions;
	}
}
