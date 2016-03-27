package com.zzu.controller;

import com.zzu.model.*;
import com.zzu.model.Collection;
import com.zzu.service.JobService;
import com.zzu.service.ResumeService;
import com.zzu.service.UserService;
import com.zzu.util.DateUtil;
import com.zzu.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

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
	@Resource
	private ResumeService resumeService;

	/**
	 * 加载主页
	 *
	 * @param model
	 * @return
	 */
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

	/**
	 * 获取所有大类
	 *
	 * @return
	 */
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

	/**
	 * 公司用户职位管理
	 *
	 * @param session
	 * @param model
	 * @return
	 */
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

	/**
	 * 公司简历管理
	 *
	 * @return
	 */
	@RequestMapping("/resume_manage.do")
	public String resumeManage() {
		return "company/resume_manage";
	}

	/**
	 * 公司查找简历
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/search_resume.do")
	public String toSearchResume(Model model) {
		List<School> schools = jobService.getSchools();
		model.addAttribute("schools", schools);
		return "company/search_resume";
	}

	/**
	 * 公司账号设置
	 *
	 * @param session
	 * @param model
	 * @return
	 */
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

	/**
	 * 转到发布职位界面
	 *
	 * @return
	 */
	@RequestMapping("/toPost.do")
	public String toPost() {
		return "company/post";
	}

	/**
	 * 公司发布职位
	 *
	 * @param job
	 * @param result
	 * @param session
	 * @return
	 */
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

	/**
	 * 查找职位列表
	 *
	 * @param c_id
	 * @param p_id
	 * @param time
	 * @param low
	 * @param high
	 * @param page
	 * @param model
	 * @return
	 */
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
		if (h == -1) {
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

	/**
	 * 模糊搜索职位
	 *
	 * @param keyword
	 * @param page
	 * @param c_id
	 * @param time
	 * @param low
	 * @param high
	 * @param model
	 * @return
	 */
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
		if (h == -1) {
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

		List<Job> jobs = jobService.searchJobs(keyword, page, l, h, time, c_id);
		model.addAttribute("jobs", jobs);

		int count = jobService.getJobCount(keyword, l, h, time, c_id);
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

	/**
	 * 职位详细信息
	 *
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("/job_detail.do")
	public String jobDetail(int id, Model model) {
		Job job = jobService.getJobById(id);
		model.addAttribute("job", job);

		return "company/job_detail";
	}

	/**
	 * 查找简历
	 *
	 * @param grade
	 * @param spare_time
	 * @param salary
	 * @param school
	 * @return
	 */
	@RequestMapping("/searchResume.do")
	@ResponseBody
	public JSONObject searchResume(int grade, Integer spare_time, String salary, int school) {
		if (spare_time > 127 || spare_time <= 0) {
			spare_time = 127;
		}
		JSONObject object = new JSONObject();
		List<Resume> resumes = jobService.searchResume(grade, spare_time, salary, school, 0);
		object.put("resumes", resumes);

		return object;
	}

	/**
	 * 简历详情
	 *
	 * @param id
	 * @param model
	 * @return
	 */
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

	/**
	 * 最新职位信息
	 *
	 * @return
	 */
	@RequestMapping("/getRecentJobs.do")
	@ResponseBody
	public JSONObject getRecentJobs() {
		JSONObject object = new JSONObject();

		List<Job> jobs = jobService.getRecentJobs(5);
		object.put("jobs", jobs);

		return object;
	}

	/**
	 * 用户界面查看职位详情
	 *
	 * @param id
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping("/detail.do")
	public String detail(int id, Model model, HttpSession session) {
		User user = (User) session.getAttribute(Common.USER);
		Collection collection = null;

		Job job = jobService.getJobById(id);
		model.addAttribute("job", job);

		int count = jobService.getCommentCount(id);
		model.addAttribute("count", count);

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

		List<Job> jobs = jobService.getAllCompanyJobs(job.getPost_company().getId());
		model.addAttribute("jobs", jobs);

		model.addAttribute("collection", collection);
		return "job_detail";
	}

	/**
	 * 获取评论列表
	 *
	 * @param page
	 * @param id
	 * @return
	 */
	@RequestMapping("/getComments.do")
	@ResponseBody
	public JSONArray getComments(Integer page, int id) {
		JSONArray array = new JSONArray();
		if (page == null || page <= 0) {
			page = 1;
		}

		List<Comment> comments = jobService.getComments(id, page);
		for (Comment comment : comments) {
			JSONObject object = new JSONObject();
			object.put("user", comment.getUser());
			object.put("id", comment.getId());
			object.put("c_time", comment.getC_time());
			object.put("content", comment.getContent());
			array.add(object);
		}
		return array;
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

	/**
	 * 增加或删除类型
	 *
	 * @param id
	 * @param c_id
	 * @param label
	 * @param type
	 * @param isNew
	 * @return
	 */
	@RequestMapping("/admin/saveOrUpdateType.do")
	@ResponseBody
	public JSONObject saveOrUpdateType(int id, Integer c_id, String label, String type, boolean isNew) {
		JSONObject object = new JSONObject();
		object.put("success", false);

		if (type.equals(Common.CLASSIFY)) {
			Classify classify = new Classify();
			classify.setId(id);
			classify.setName(label);
			if (isNew) {
				// impossible
			} else {
				jobService.updateClassify(classify);
				object.put("success", true);
			}
		} else if (type.equals(Common.POSITION) && c_id != null) {
			Position position = new Position();
			position.setId(id);
			position.setC_id(c_id);
			position.setName(label);
			if (isNew) {
				jobService.addPosition(position);
			} else {
				jobService.updatePosition(position);
			}
			object.put("success", true);
		}

		return object;
	}

	/**
	 * 删除类型
	 *
	 * @param id
	 * @param type
	 * @param isNew
	 * @return
	 */
	@RequestMapping("/admin/deleteType.do")
	@ResponseBody
	public JSONObject deleteType(int id, String type, boolean isNew) {
		JSONObject object = new JSONObject();
		object.put("success", true);

		if (isNew) {
			return object;
		}

		if (type.equals(Common.CLASSIFY)) {
			jobService.deleteClassify(id);
		} else if (type.equals(Common.POSITION)) {
			jobService.deletePosition(id);
		}

		return object;
	}

	/**
	 * 查找职位
	 *
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/admin/jobs/list/{page}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject searchJobs(@PathVariable("page") Integer page) {
		JSONObject object = new JSONObject();
		List<Job> jobs = jobService.searchJobs(null, 127, 0, -1, page);

		object.put("total", jobs.size());
		object.put("rows", jobs);
		return object;
	}

	/**
	 * 根据id返回职位详情
	 *
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/admin/jobs/detail/{id}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getJobById(@PathVariable("id") Integer id) {
		Job job = jobService.getJobById(id);
		JSONObject object = JSONObject.fromObject(job);

		return object;
	}

	/**
	 * 更新职位信息
	 *
	 * @param id
	 * @param job
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/admin/jobs/update/{id}", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateJob(@PathVariable("id") Integer id, int company, int position,
	                            @ModelAttribute("job") Job job, BindingResult result) {
		JSONObject object = new JSONObject();

		Position p = new Position();
		p.setId(position);
		job.setType(p);

		Company c = new Company();
		c.setId(company);
		job.setPost_company(c);

		jobService.updateJob(job);
		object.put("success", true);

		return object;
	}

	/**
	 * 新建职位
	 *
	 * @param company
	 * @param position
	 * @param job
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/admin/jobs/create", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateJob(int company, int position, @ModelAttribute("job") Job job, BindingResult result) {
		JSONObject object = new JSONObject();

		Position p = new Position();
		p.setId(position);
		job.setType(p);

		Company c = new Company();
		c.setId(company);
		job.setPost_company(c);

		job.setPost_time(new Date());

		jobService.addJob(job);
		object.put("success", true);

		return object;
	}

	/**
	 * 删除职位
	 *
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/admin/jobs/delete", method = RequestMethod.POST)
	@ResponseBody
	//接收int型数组
	public JSONObject deleteCompany(@RequestParam(value = "ids[]") int[] ids) {
		JSONObject object = new JSONObject();
		int count = jobService.deleteJobs(ids);
		if (count == ids.length) {
			object.put("msg", "删除成功");
		} else {
			object.put("msg", "未完全删除");
		}
		return object;
	}

	/**
	 * 查找简历
	 *
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/admin/resumes/list/{page}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject searchResumes(@PathVariable("page") Integer page) {
		JSONObject object = new JSONObject();
		List<Resume> resumes = jobService.searchResume(0, 127, null, 0, page);

		object.put("total", resumes.size());
		object.put("rows", resumes);
		return object;
	}

	/**
	 * 根据id返回简历
	 *
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/admin/resumes/detail/{id}", method = RequestMethod.GET)
	@ResponseBody
	public JSONObject getResumeById(@PathVariable("id") Integer id) {
		Resume resume = jobService.getResumeById(id);
		List<Position> positions = new ArrayList<Position>();
		String[] types = null;
		if(types != null) {
			types = resume.getJob_type().split("#");
			for (String type : types) {
				if (StringUtil.isNumber(type)) {
					int temp = Integer.parseInt(type);
					Position position = jobService.getPositionById(temp);
					positions.add(position);
				}
			}
		}

		resume.setPositions(positions);

		JSONObject object = JSONObject.fromObject(resume);

		return object;
	}

	/**
	 * 更新简历信息
	 *
	 * @param id
	 * @param major_id
	 * @param birth
	 * @param resume
	 * @param result
	 * @return
	 */
	@RequestMapping(value = "/admin/resumes/update/{id}", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateJob(@PathVariable("id") Integer id, int major_id, String birth,
	                            @ModelAttribute("resume") Resume resume, BindingResult result) {
		resume.setBirthday(DateUtil.toDate(birth));

		Major major = new Major();
		major.setId(major_id);
		resume.setMajor(major);

		JSONObject object = new JSONObject();
		resumeService.updateResume(resume);
		object.put("success", true);

		return object;
	}

	@RequestMapping(value = "/admin/resumes/create", method = RequestMethod.POST)
	@ResponseBody
	public JSONObject updateJob(int major_id, String birth,
	                            @ModelAttribute("resume") Resume resume, BindingResult result) {
		JSONObject object = new JSONObject();

		resume.setBirthday(DateUtil.toDate(birth));

		Major major = new Major();
		major.setId(major_id);
		resume.setMajor(major);

		resumeService.insertResume(resume);
		object.put("success", true);

		return object;
	}

	/**
	 * 返回院系数据
	 *
	 * @return
	 */
	@RequestMapping(value = "/school_data.do")
	@ResponseBody
	public JSONArray getSchoolData() {
		JSONArray array = new JSONArray();
		List<Major> majors = jobService.getSchoolsAndMajors();
		Map<Integer, School> map = new HashMap<Integer, School>();
		List<School> schools = new ArrayList<School>();

		for (Major major : majors) {
			School school = major.getSchool();
			if (!map.containsKey(school.getId())) {
				map.put(school.getId(), school);
			}
		}
		for (Map.Entry<Integer, School> entry : map.entrySet()) {
			schools.add(entry.getValue());
			JSONObject object = JSONObject.fromObject(entry.getValue());
			List<Major> list = new ArrayList<Major>();

			Iterator<Major> iterator = majors.iterator();
			while (iterator.hasNext()) {
				Major major = iterator.next();
				if (entry.getKey() == major.getSchool().getId()) {
					list.add(major);
					iterator.remove();
				}
			}
			object.put("majors", list);
			array.add(object);
		}

		return array;
	}
}
