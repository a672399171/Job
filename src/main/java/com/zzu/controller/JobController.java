package com.zzu.controller;

import com.zzu.model.*;
import com.zzu.model.Collection;
import com.zzu.service.JobService;
import com.zzu.service.MailService;
import com.zzu.service.ResumeService;
import com.zzu.service.UserService;
import com.zzu.util.DateUtil;
import com.zzu.util.StringUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
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
	@Resource
	private MailService mailService;

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

		List<Job> jobs = jobService.getRecentJobs(5);
		model.addAttribute("recentJobs", jobs);

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

		List<Job> jobs = jobService.getCompanyJobs(company.getId(), 0);
		model.addAttribute("jobs", jobs);

		return "company/job_manage";
	}

	/**
	 * 公司简历管理
	 *
	 * @return
	 */
	@RequestMapping("/resume_manage.do")
	public String resumeManage(HttpSession session, Model model) {
		Company company = (Company) session.getAttribute(Common.COMPANY);
		if (company == null) {
			return "redirect:/user/toCompanyLogin.do";
		}

		return "company/resume_manage";
	}

	/**
	 * 获取投递该公司的简历
	 *
	 * @param session
	 * @return
	 */
	@RequestMapping("/resumeOfCompany.do")
	@ResponseBody
	public JSONObject resumeOfCompany(HttpSession session) {
		JSONObject object = new JSONObject();
		Company company = (Company) session.getAttribute(Common.COMPANY);
		if (company == null) {
			object.put("error", "未登录");
			return object;
		}

		List<Apply> applies = jobService.getAppliesByCompany(company.getId(), 1);
		int count = jobService.getCompanyApplyCount(company.getId());

		JSONArray array = new JSONArray();
		for (Apply apply : applies) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("state", apply.getState());

			JSONObject resume = new JSONObject();
			resume.put("id", apply.getResume().getId());
			resume.put("grade", apply.getResume().getGrade());
			resume.put("name", apply.getResume().getName());

			JSONObject job = new JSONObject();
			job.put("id", apply.getJob().getId());
			job.put("name", apply.getJob().getName());

			jsonObject.put("resume", resume);
			jsonObject.put("job", job);

			array.add(jsonObject);
		}
		object.put("rows", array);
		object.put("total", count);

		return object;
	}

	/**
	 * 更新简历投递状态
	 *
	 * @param j_id
	 * @param r_id
	 * @param state
	 * @param session
	 * @return
	 */
	@RequestMapping("/updateApply.do")
	@ResponseBody
	public JSONObject updateApply(int j_id, int r_id, int state, HttpSession session) {
		JSONObject object = new JSONObject();
		Company company = (Company) session.getAttribute(Common.COMPANY);
		if (company == null) {
			object.put("error", "未登录");
		} else {
			if (state != Common.APPLYING && state != Common.APPLYFILED &&
					state != Common.APPLYSUCCESS) {
				object.put("error", "操作错误，请刷新后重试");
			} else {
				Resume resume = jobService.getResumeById(r_id);
				User user = userService.getUserById(resume.getU_id());
				if (!StringUtil.isEmail(user.getEmail())) {
					Map<String, Object> map = new HashMap<String, Object>();
					if (state == Common.APPLYFILED) {
						map.put("text", "I'm sorry! 您的申请被回绝！请不要伤心，'职来了'还有一大波工作等着你呢！");
					} else if (state == Common.APPLYSUCCESS) {
						map.put("text", "恭喜您，你的职位申请已通过！");
					}
					mailService.sendEmail(user.getEmail(), "求职进展", "applyChange.ftl", map);
				}
				jobService.updateApply(j_id, r_id, state);
			}
		}
		return object;
	}

	/**
	 * 公司查找简历
	 *
	 * @param model
	 * @return
	 */
	@RequestMapping("/search_resume.do")
	public String toSearchResume(Model model) {

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
	public String toPost(HttpSession session, Model model) {
		Company company = (Company) session.getAttribute(Common.COMPANY);
		company = userService.getCompanyById(company.getId());

		if (company.getAuth() != Common.AUTHED) {
			model.addAttribute("msg", "公司暂未认证或认证未通过，不能发布职位，请完善公司信息后发布职位");
			return "company/account_setting";
		}

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
	public String postJob(@Valid @ModelAttribute("job") Job job, BindingResult result,
	                      Integer type, HttpSession session, Model model) {
		Company company = (Company) session.getAttribute(Common.COMPANY);
		if (company == null) {
			return "redirect:/user/toCompanyLogin.do";
		} else {
			company = userService.getCompanyById(company.getId());
			session.setAttribute(Common.COMPANY, company);
			if (company.getAuth() != Common.AUTHED) {
				model.addAttribute("msg", "公司暂未认证或认证未通过，不能发布职位，请完善公司信息后发布职位");
				return "company/account_setting";
			}
		}
		Position position = new Position();
		position.setId(type);
		job.setType(position);

		job.setPost_time(new Date());
		job.setPost_company(company);
		jobService.addJob(job);

		return "redirect:job_manage.do";
	}

	/**
	 * 查找职位列表
	 *
	 * @param c_id
	 * @param p_id
	 * @param model
	 * @return
	 */
	@RequestMapping("/job_list.do")
	public String jobList(int c_id, int p_id, Model model) {
		model.addAttribute("p_id", p_id);
		model.addAttribute("c_id", c_id);

		return "job_list";
	}

	/**
	 * 返回一个大类下的所有小类
	 *
	 * @param c_id
	 * @return
	 */
	@RequestMapping("/positions.do")
	@ResponseBody
	public JSONArray getPositions(int c_id) {
		List<Position> positions = jobService.searchPositions(c_id);
		JSONArray array = JSONArray.fromObject(positions);
		return array;
	}

	@RequestMapping("/searchJobs.do")
	@ResponseBody
	public JSONObject searchJobs(int p_id, Integer time, String low, String high, Integer page) {
		JSONObject object = new JSONObject();

		int l = getSalaryNumber(low);
		int h = getSalaryNumber(high);

		if (time == null || time <= 0 || time >= 127) {
			time = 127;
		}

		int[] p_ids = null;
		if (p_id != 0) {
			p_ids = new int[]{p_id};
		}
		List<Job> jobs = jobService.searchJobsByPid(p_ids, time, l, h, page, null, 0);
		int count = jobService.getJobCount(p_ids, time, l, h, null, 0);

		object.put("rows", jobs);
		object.put("total", count);

		return object;
	}

	/**
	 * 返回所有大类
	 *
	 * @return
	 */
	@RequestMapping("/classifyList.do")
	@ResponseBody
	public JSONArray getClassifyList() {
		List<Classify> classifies = jobService.getAllClassifies();
		JSONArray array = JSONArray.fromObject(classifies);
		return array;
	}

	/**
	 * 模糊搜索工作
	 *
	 * @param keyword
	 * @param page
	 * @param c_id
	 * @param time
	 * @param low
	 * @param high
	 * @return
	 */
	@RequestMapping("/vagueSearchJobs.do")
	@ResponseBody
	public JSONObject searchJobs(String keyword, Integer page, Integer c_id, Integer time, String low, String high) {
		JSONObject object = new JSONObject();
		if (page == null || page <= 0) {
			page = 1;
		}

		int l = getSalaryNumber(low);
		int h = getSalaryNumber(high);

		if (c_id == null || c_id <= 0) {
			c_id = 0;
		}

		if (time == null || time <= 0 || time >= 127) {
			time = 127;
		}

		List<Job> jobs = jobService.searchJobs(keyword, page, l, h, time, c_id);
		int count = jobService.getJobCount(keyword, l, h, time, c_id);

		object.put("rows", jobs);
		object.put("total", count);

		return object;
	}

	/**
	 * 模糊搜索职位
	 *
	 * @param keyword
	 * @param model
	 * @return
	 */
	@RequestMapping("/vague_search_job.do")
	public String searchJobs(String keyword, Model model) {
		model.addAttribute("keyword", keyword);

		return "vague_search_job";
	}

	private int getSalaryNumber(String str) {
		int num = -1;
		if (!StringUtil.isEmail(str) && StringUtil.isNumber(str)) {
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
	 * @param time
	 * @param salary
	 * @param school
	 * @return
	 */
	@RequestMapping("/searchResume.do")
	@ResponseBody
	public JSONObject searchResume(int grade, Integer time, String salary, int school, int page) {
		if (time > 127 || time <= 0) {
			time = 127;
		}

		JSONObject object = new JSONObject();
		List<Resume> resumes = jobService.searchResume(grade, time, salary, school, page, null, true);
		int count = jobService.getResumeCount(grade, time, salary, school, null, true);

		object.put("rows", resumes);
		object.put("total", count);

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

	@RequestMapping("/changeJobStatus.do")
	@ResponseBody
	public JSONObject changeJobStatus(int j_id, int status) {
		JSONObject object = new JSONObject();

		jobService.changeJobStatus(j_id, status);

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

	/**
	 * 推荐职位
	 * @param u_id
	 * @param j_id
	 * @return
	 */
	@RequestMapping("/getRecommendJobs.do")
	@ResponseBody
	public JSONArray getRecommendJobs(Integer u_id,Integer j_id) {
		if(u_id == null) {
			u_id = 0;
		}
		if(j_id == null) {
			j_id = 0;
		}

		JSONArray array = null;

		if(u_id != 0 && j_id != 0) {
			Resume resume = resumeService.getResumeByUid(u_id);
			int time = resume.getSpare_time();
			Job job = jobService.getJobById(j_id);

			List<Job> jobs = jobService.getRecommendJobs(time,job.getType().getId());
			array = JSONArray.fromObject(jobs);
		}

		return array;
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
	public JSONObject getComments(Integer page, int id) {
		JSONObject jsonObject = new JSONObject();
		if (page == null || page <= 0) {
			page = 1;
		}

		JSONArray array = new JSONArray();
		int count = jobService.getCommentCount(id);
		List<Comment> comments = jobService.getComments(id, page);

		for (Comment comment : comments) {
			JSONObject object = new JSONObject();
			object.put("user", comment.getUser());
			object.put("id", comment.getId());
			object.put("c_time", comment.getC_time());
			object.put("content", comment.getContent());
			array.add(object);
		}

		jsonObject.put("rows", array);
		jsonObject.put("total", count);
		return jsonObject;
	}

	@RequestMapping("/getJobsByCompany.do")
	@ResponseBody
	public JSONObject getJobsByCompany(Integer page, int id) {
		JSONObject jsonObject = new JSONObject();
		if (page == null || page <= 0) {
			page = 1;
		}

		List<Job> jobs = jobService.getCompanyJobs(id, page);
		JSONArray array = JSONArray.fromObject(jobs);

		int count = jobService.getCompanyJobCount(id);

		jsonObject.put("rows", array);
		jsonObject.put("total", count);
		return jsonObject;
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
			map.put("msg", "请登陆后申请！");
			return map;
		}

		Resume resume = jobService.getResumeById(user.getId());

		Job job = new Job();
		job.setId(j_id);
		Apply apply = new Apply();
		apply.setResume(resume);
		apply.setJob(job);
		apply.setState(Common.APPLYING);

		jobService.addApply(apply);

		return map;
	}

	@RequestMapping("/applySuccess.do")
	public String applySuccess(HttpSession session) {
		User user = (User) session.getAttribute(Common.USER);

		if (!StringUtil.isEmail(user.getEmail())) {
			Map<String, Object> valMap = new HashMap<String, Object>();
			valMap.put("text", "恭喜你，简历投递成功！请耐心等待，我们将以邮件的方式向您汇报职位进展情况，谢谢！");
			mailService.sendEmail(user.getEmail(), "求职进展", "applyChange.ftl", valMap);
		}
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
	public JSONObject searchJobs(@PathVariable("page") Integer page, String filter, Integer state) {
		JSONObject object = new JSONObject();

		if (state == null) {
			state = 0;
		}

		List<Job> jobs = jobService.searchJobsByPid(null, 127, 0, -1, page, filter, state);
		int count = jobService.getJobCount(null, 127, 0, -1, filter, state);

		object.put("total", count);
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
	public JSONObject searchResumes(@PathVariable("page") Integer page, String filter, Integer grade, String salary, Integer school) {
		JSONObject object = new JSONObject();

		if (StringUtil.isEmpty(filter)) {
			filter = null;
		}

		if (grade == null || grade < 0) {
			grade = 0;
		}

		if (StringUtil.isEmpty(salary)) {
			salary = null;
		}

		if (school == null || school < 0) {
			school = 0;
		}

		List<Resume> resumes = jobService.searchResume(grade, 127, salary, school, page, filter, false);
		int count = jobService.getResumeCount(grade, 127, salary, school, filter, false);

		object.put("total", count);
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
		if (!StringUtil.isEmpty(resume.getJob_type())) {
			types = resume.getJob_type().split("#");
			for (String type : types) {
				if (StringUtil.isNumber(type)) {
					int temp = Integer.parseInt(type);
					Position position = jobService.getPositionById(temp);
					positions.add(position);
				}
			}
		}

		if (resume != null) {
			resume.setPositions(positions);
		}

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

	/**
	 * 新建简历
	 *
	 * @param major_id
	 * @param birth
	 * @param resume
	 * @param result
	 * @return
	 */
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
