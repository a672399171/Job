package com.zzu.controller;

import com.zzu.model.*;
import com.zzu.model.Collection;
import com.zzu.service.JobService;
import com.zzu.service.UserService;
import com.zzu.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.*;

/**
 * Created by Administrator on 2016/3/8.
 */
@Component
@RequestMapping("job")
public class JobController {
	@Resource
	private UserService userService;
	@Resource
	private JobService jobService;

	@RequestMapping("/index.do")
	public String index(Model model) {
		JSONArray array = new JSONArray();
		JSONObject object = null;

		List<Classify> classifies = jobService.getAllClassifies();
		List<Position> positions = jobService.searchPositions(0);
		for (Classify classify : classifies) {
			object = JSONObject.fromObject(classify);
			List<Position> positionList = new ArrayList<Position>();
			for (Position position : positions) {
				if (position.getC_id() == classify.getId()) {
					positionList.add(position);
				}
			}
			object.put("positions", positionList);
			array.add(object);
		}

		model.addAttribute("array", array);

		return "index";
	}

	@RequestMapping("/classifies.do")
	@ResponseBody
	public JSONObject getClassifies() {
		JSONObject object = new JSONObject();

		List<Classify> classifies = jobService.getAllClassifies();
		List<Position> positions = jobService.searchPositions(0);
		object.put("classifies", classifies);
		object.put("positions", positions);

		return object;
	}

	@RequestMapping("/job_manage.do")
	public String jobManage(HttpSession session, Model model) {
		Company company = (Company) session.getAttribute(Common.COMPANY);
		if (company == null) {
			return "redirect:/user/toCompanyLogin.do";
		}

		List<Job> jobs = jobService.getAllCompanyJobs(company.getId());
		model.addAttribute("jobs", jobs);

		return "company/job_manage";
	}

	@RequestMapping("/resume_manage.do")
	public String resumeManage() {
		return "company/resume_manage";
	}

	@RequestMapping("/search_resume.do")
	public String toSearchResume(Model model) {
		List<School> schools = jobService.getSchools();
		model.addAttribute("schools", schools);
		return "company/search_resume";
	}

	@RequestMapping("/account_setting.do")
	public String AccountSetting(HttpSession session, Model model) {
		Company company = (Company) session.getAttribute(Common.COMPANY);
		if (company == null) {
			return "redirect:/user/toCompanyLogin.do";
		}

		company = userService.getCompanyById(company.getId());
		session.setAttribute(Common.COMPANY, company);
		model.addAttribute(Common.COMPANY, company);

		return "company/account_setting";
	}

	@RequestMapping("/toPost.do")
	public String toPost() {
		return "company/post";
	}

	@RequestMapping("/post_job.do")
	public String postJob(@Valid @ModelAttribute("job") Job job, BindingResult result, HttpSession session) {
		Company company = (Company) session.getAttribute(Common.COMPANY);
		if (company == null) {
			return "redirect:/user/toCompanyLogin.do";
		}

		job.setPost_time(new Date());
		job.setPost_company(company);

		return "redirect:job_manage.do";
	}

	@RequestMapping("/job_list.do")
	public String jobList(int c_id, int p_id, Integer time, String low, String high,
	                      Integer page, Model model) {
		if (page == null) {
			page = 1;
		}
		if (time > 127) {
			time = 127;
		} else if (time < 0) {
			time = 0;
		}
		int l = getSalaryNumber(low);
		int h = getSalaryNumber(high);
		if (l <= 0) {
			low = "0";
		}
		if(h == -1) {
			high = "max";
		}
		List<Position> positions = jobService.searchPositions(c_id);
		model.addAttribute("positions", positions);
		model.addAttribute("p_id", p_id);
		model.addAttribute("c_id", c_id);
		model.addAttribute("time", time);
		model.addAttribute("low", low);
		model.addAttribute("high", high);
		model.addAttribute("page", page);

		int[] p_ids = null;
		if (p_id != 0) {
			p_ids = new int[]{p_id};
		}

		List<Job> jobs = jobService.searchJobs(p_ids, time, l, h, page);
		model.addAttribute("jobs", jobs);

		int count = jobService.getJobCount(p_ids, time, l, h);
		model.addAttribute("count", count);

		return "job_list";
	}

	@RequestMapping("/vague_search_job.do")
	public String searchJobs(String keyword, Integer page, Integer c_id, Integer time, String low, String high, Model model) {
		if (page == null || page <= 0) {
			page = 1;
		}
		if (c_id == null || c_id <= 0) {
			c_id = 0;
		}
		if (time == null || time <= 0 || time >= 127) {
			time = 127;
		}
		int l = getSalaryNumber(low);
		int h = getSalaryNumber(high);
		if (l <= 0) {
			low = "0";
		}
		if(h == -1) {
			high = "max";
		}

		model.addAttribute("time", time);
		model.addAttribute("c_id", c_id);
		model.addAttribute("page", page);
		model.addAttribute("keyword", keyword);
		model.addAttribute("low", low);
		model.addAttribute("high", high);

		List<Classify> classifies = jobService.getAllClassifies();
		model.addAttribute("classifies", classifies);

		List<Job> jobs = jobService.searchJobs(keyword, page, l, h,time,c_id);
		model.addAttribute("jobs", jobs);

		int count = jobService.getJobCount(keyword, l, h,time,c_id);
		model.addAttribute("count", count);

		return "vague_search_job";
	}

	private int getSalaryNumber(String str) {
		int num = -1;
		if (!StringUtil.isEmpty(str) && StringUtil.isNumber(str)) {
			num = Integer.parseInt(str);
		}
		return num;
	}

	@RequestMapping("/job_detail.do")
	public String jobDetail(int id, Model model) {
		Job job = jobService.getJobById(id);
		model.addAttribute("job", job);

		return "company/job_detail";
	}

	@RequestMapping("/searchResume.do")
	@ResponseBody
	public JSONObject searchResume(int grade, Integer spare_time, String salary, int school) {
		if (spare_time > 127 || spare_time <= 0) {
			spare_time = 127;
		}
		JSONObject object = new JSONObject();
		List<Resume> resumes = jobService.searchResume(grade, spare_time, salary, school);
		object.put("resumes", resumes);

		return object;
	}

	@RequestMapping("/resume_detail.do")
	public String resumeDetail(int id, Model model) {
		Resume resume = jobService.getResumeById(id);
		model.addAttribute("resume", resume);
		return "company/resume_detail";
	}

	@RequestMapping("/updateDatabase.do")
	@ResponseBody
	public JSONObject updateDatabase(String data) {
		JSONObject object = new JSONObject();
		JSONArray array = JSONArray.fromObject(data);
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < array.size(); i++) {
			JSONObject jsonObject = array.getJSONObject(i);
			JSONArray majors = jsonObject.getJSONArray("majors");
			for (int j = 0; j < majors.size(); j++) {
				list.add(majors.getString(j));
			}
		}

		//jobService.addMajors(list);
		return object;
	}

	@RequestMapping("/getRecentJobs.do")
	@ResponseBody
	public JSONObject getRecentJobs() {
		JSONObject object = new JSONObject();

		List<Job> jobs = jobService.getRecentJobs(5);
		object.put("jobs", jobs);

		return object;
	}

	@RequestMapping("/detail.do")
	public String detail(int id, Model model, HttpSession session) {
		User user = (User) session.getAttribute(Common.USER);
		Collection collection = null;

		Job job = jobService.getJobById(id);
		model.addAttribute("job", job);
		List<Comment> comments = jobService.getComments(id);
		model.addAttribute("comments", comments);

		if (user != null) {
			collection = jobService.getCollection(user.getId(), id);
			List<Apply> applies = jobService.getApplies(user.getId(), id);
			for (Apply apply : applies) {
				if (apply.getJob().getId() == id) {
					model.addAttribute("apply", apply);
					break;
				}
			}
		}
		model.addAttribute("collection", collection);
		return "job_detail";
	}

	@RequestMapping("/updateCollection.do")
	@ResponseBody
	public Map<String, Object> updateCollection(boolean collection, HttpSession session, int j_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) session.getAttribute(Common.USER);

		if (user == null) {
			map.put("msg", "请登陆后收藏！");
			return map;
		}

		jobService.updateCollection(collection, user.getId(), j_id);

		return map;
	}

	@RequestMapping("/applyJob.do")
	@ResponseBody
	public Map<String, Object> applyJob(HttpSession session, int j_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) session.getAttribute(Common.USER);

		if (user == null) {
			map.put("msg", "请登陆后收藏！");
			return map;
		}

		Job job = new Job();
		job.setId(j_id);
		Apply apply = new Apply();
		apply.setUser(user);
		apply.setJob(job);
		apply.setState(Common.APPLYING);

		jobService.addApply(apply);

		return map;
	}

	@RequestMapping("/applySuccess.do")
	public String applySuccess(HttpSession session) {

		return "apply_success";
	}

	@RequestMapping("/admin/addClassify.do")
	@ResponseBody
	public Map<String, Object> addClassify(String text) {
		Map<String, Object> map = new HashMap<String, Object>();
		Classify classify = new Classify();
		classify.setName(text);
		jobService.addClassify(classify);
		map.put("c_id", classify.getId());
		return map;
	}

	@RequestMapping("/admin/updateClassify.do")
	@ResponseBody
	public Map<String, Object> updateClassify(int id, String text) {
		Map<String, Object> map = new HashMap<String, Object>();
		Classify classify = new Classify();
		classify.setId(id);
		classify.setName(text);
		jobService.updateClassify(classify);
		return map;
	}

	@RequestMapping("/admin/deleteClassify.do")
	@ResponseBody
	public Map<String, Object> deleteClassify(int id) {
		Map<String, Object> map = new HashMap<String, Object>();
		jobService.deleteClassify(id);
		return map;
	}

	@RequestMapping("/admin/addPosition.do")
	@ResponseBody
	public Map<String, Object> addPosition(int c_id, String text) {
		Map<String, Object> map = new HashMap<String, Object>();
		Position position = new Position();
		position.setC_id(c_id);
		position.setName(text);
		jobService.addPosition(position);
		return map;
	}

	@RequestMapping("/admin/updatePosition.do")
	@ResponseBody
	public Map<String, Object> updatePosition(int id, String text) {
		Map<String, Object> map = new HashMap<String, Object>();
		Position position = new Position();
		position.setId(id);
		position.setName(text);
		jobService.updatePosition(position);
		return map;
	}

	@RequestMapping("/admin/deletePosition.do")
	@ResponseBody
	public Map<String, Object> deletePosition(int id) {
		Map<String, Object> map = new HashMap<String, Object>();
		jobService.deletePosition(id);
		return map;
	}

	@RequestMapping("/admin/searchJobs.do")
	@ResponseBody
	public JSONObject searchJobs() {
		JSONObject object = new JSONObject();
		List<Job> jobs = jobService.searchJobs(null, 127, 0, -1, 0);

		object.put("total", jobs.size());
		object.put("rows", jobs);
		JSONArray array = object.getJSONArray("rows");
		for (int i = 0; i < array.size(); i++) {
			JSONObject jsonObject = array.getJSONObject(i);
			int status = jsonObject.getInt("status");
			switch (status) {
				case Common.STOP:
					jsonObject.put("status", "停止中");
					break;
				case Common.RUNNING:
					jsonObject.put("status", "运行中");
					break;
			}
		}

		return object;
	}
}
