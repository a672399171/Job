package com.zzu.daoback;

import com.zzu.model.*;
import org.apache.ibatis.session.SqlSession;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/3/1.
 */
//@Component
public class UserDao {
	@Resource
	private SqlSession session;

	public User search(String username, String password) {
		Map map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("password", password);

		User user = session.selectOne("mapping.UserMapper.search", map);
		return user;
	}

	public User exists(String username) {
		User user = session.selectOne("mapping.UserMapper.exists", username);
		return user;
	}

	public void modifyInfo(String nickname, String sex, String photo_src, int u_id) {
		Map map = new HashMap<String, Object>();
		map.put("id", u_id);
		map.put("nickname", nickname);
		map.put("sex", sex);
		map.put("photo_src", photo_src);

		session.update("mapping.UserMapper.modifyInfo", map);
	}

	public User getUserById(int id) {

		User user = session.selectOne("mapping.UserMapper.getUserById", id);
		return user;
	}

	public void updateSecret(int id, boolean secret) {
		Map map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("secret", secret);

		session.update("mapping.UserMapper.updateSecret", map);
	}

	public Verify searchVarify(String username, int type) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("type", type);

		Verify varify = session.selectOne("mapping.UserMapper.searchVarify", map);
		return varify;
	}

	public void insertOrUpdateVarify(Verify varify) {
		session.insert("mapping.UserMapper.insertOrUpdateVarify", varify);
	}

	public void deleteVarify(Verify varify) {
		session.delete("mapping.UserMapper.deleteVarify",varify);
	}

	public Admin adminLogin(String username, String password) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("password", password);
		Admin admin = session.selectOne("mapping.UserMapper.adminLogin", map);
		return admin;
	}

	public List<User> searchUsers(int page, String filter) {
		List<User> users = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("start", (page - 1) * Common.COUNT);
		map.put("count", Common.COUNT);
		map.put("filter", filter);

		users = session.selectList("mapping.UserMapper.searchUsers", map);

		return users;
	}

	//判断该用户名的公司是否存在
	public Company existsCompany(String username) {
		Company company = null;
		company = session.selectOne("mapping.UserMapper.existsCompany",username);
		return company;
	}

	//根据email查找公司
	public Company searchCompanyByEmail(String email) {
		Company company = null;
		company = session.selectOne("mapping.UserMapper.searchCompanyByEmail",email);
		return company;
	}

	//根据学号查找用户
	public User searchUserBySchoolNum(String school_num) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("school_num", school_num);

		User user = null;
		user = session.selectOne("mapping.UserMapper.searchUserBySchoolNum", map);
		return user;
	}

	public Poor searchPoor(int u_id) {
		Poor poor = session.selectOne("mapping.UserMapper.searchPoor", u_id);
		return poor;
	}

	public void insertPoor(Poor poor) {
		session.insert("mapping.UserMapper.insertPoor", poor);
	}

	public Company searchCompany(String username, String password) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("password", password);
		Company company = session.selectOne("mapping.UserMapper.searchCompany", map);
		return company;
	}

	//根据id返回公司
	public Company getCompanyById(int id) {
		Company company = session.selectOne("mapping.UserMapper.getCompanyById", id);
		return company;
	}

	//更新公司信息
	public void updateCompany(Company company) {
		session.update("mapping.UserMapper.updateCompany", company);
	}

	//添加公司
	public void addCompany(Company company) {
		session.insert("mapping.UserMapper.addCompany", company);
	}

	//公司修改密码
	public void modifyCompanyPassword(int id, String s) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("password", s);
		session.update("mapping.UserMapper.modifyCompanyPassword", map);
	}

	//添加用户
	public void addUser(User user) {
		session.insert("mapping.UserMapper.addUser", user);
	}

	//修改用户
	public void modifyUser(User user) {
		session.update("mapping.UserMapper.modifyUser", user);
	}

	//删除用户
	public int deleteUsers(int[] ids) {
		int count = 0;
		count = session.delete("mapping.UserMapper.deleteUsers", ids);
		return count;
	}

	public List<Company> searchCompanies(int page, int[] audit, String filter) {
		List<Company> companies = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("start", (page - 1) * Common.COUNT);
		map.put("count", Common.COUNT);
		map.put("audit", audit);
		map.put("filter", filter);

		companies = session.selectList("mapping.UserMapper.searchCompanies", map);
		return companies;
	}

	//修改密码
	public void changeUserPassword(User user) {
		session.update("mapping.UserMapper.changePassword", user);
	}

	//绑定email
	public void bindEmail(User user) {
		session.update("mapping.UserMapper.bindEmail", user);
	}

	//判断用户名或学号是否存在重复
	public boolean isUserOrSchoolNumRepeat(User user) {
		User u = session.selectOne("mapping.UserMapper.isUserOrSchoolNumRepeat", user);
		if (u != null) {
			return true;
		} else {
			return false;
		}
	}

	//判断公司用户名是否存在重复
	public boolean isUsernameRepeat(Company company) {
		Company c = session.selectOne("mapping.UserMapper.isUsernameRepeat", company);
		if (c != null) {
			return true;
		} else {
			return false;
		}
	}

	//查找所有贫困生信息
	public List<Poor> searchPoors(int page) {
		List<Poor> poors = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", page);
		map.put("start", (page - 1) * Common.COUNT);
		map.put("count", Common.COUNT);

		poors = session.selectList("mapping.UserMapper.searchPoors", map);
		return poors;
	}

	//认证贫困信息
	public void authPoor(int u_id, int status) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("status", status);
		map.put("isNew", false);

		session.update("mapping.UserMapper.authPoor", map);
	}

	//审核公司
	public void auditCompany(int id, int audit) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("audit", audit);

		session.update("mapping.UserMapper.auditCompany", map);
	}

	//查找该用户的收藏
	public List<Collection> searchCollections(int id, int page) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_id", id);
		map.put("page", page);
		map.put("start", (page - 1) * Common.COUNT);
		map.put("count", Common.COUNT);

		List<Collection> collections = null;
		collections = session.selectList("mapping.JobMapper.searchCollections", map);
		return collections;
	}

	//取消收藏
	public void deleteCollection(int u_id, int j_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("u_id", u_id);
		map.put("j_id", j_id);

		session.delete("mapping.JobMapper.deleteCollection", map);
	}

	//搜索到的用户总数
	public int getUsersCount(String filter) {
		int count = 0;
		// count = session.selectOne("mapping.UserMapper.getUsersCount", filter);
		return count;
	}

	//搜索到的公司数
	public int getCompaniesCount(int[] audit, String filter) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("audit", audit);
		map.put("filter", filter);

		int count = 0;
		// count = session.selectOne("mapping.UserMapper.getCompaniesCount", map);
		return count;
	}

	//获取未处理的贫困生认定的数量
	public int getNewPoorCount() {
		int count = 0;
		// count = session.selectOne("mapping.UserMapper.getNewPoorCount");
		return count;
	}

	//获取未审核的公司数量
	public int getNewCompanyCount() {
		int count = 0;
		// count = session.selectOne("mapping.UserMapper.getNewCompanyCount");
		return count;
	}

	//添加评论
	public void addComment(Comment comment) {
		session.insert("mapping.UserMapper.addComment", comment);
	}

	//获取所有的管理员
	public List<Admin> getAllAdmins() {
		List<Admin> admins = null;
		admins = session.selectList("mapping.UserMapper.getAllAdmins");
		return admins;
	}
}
