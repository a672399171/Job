package com.zzu.service;

import com.zzu.dao.JobDao;
import com.zzu.dao.UserDao;
import com.zzu.model.*;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.File;
import java.util.List;

/**
 * Created by Administrator on 2016/3/1.
 */
@Component
public class UserService {

	@Resource
	private UserDao userDao;

	public User search(String username,String password) {
		return userDao.search(username,password);
	}

	public User exists(String username) {
		return userDao.exists(username);
	}

	public void modifyInfo(String nickname,String sex,String photo_src,int u_id) {
		userDao.modifyInfo(nickname,sex,photo_src,u_id);
	}

	public User getUserById(int id) {
		return userDao.getUserById(id);
	}

	public void updateSecret(int id,boolean secret) {
		userDao.updateSecret(id,secret);
	}

	public Varify searchVarifyByUsername(String username) {
		return userDao.searchVarifyByUsername(username);
	}

	public void insertVarify(Varify varify) {
		userDao.insertVarify(varify);
	}

	public void updateVarify(Varify varify) {
		userDao.updateVarify(varify);
	}

	public Admin adminLogin(String username, String password) {
		return userDao.adminLogin(username,password);
	}

	//搜索用户
	public List<User> searchUsers(int page,String filter) {
		return userDao.searchUsers(page,filter);
	}

	public Poor searchPoor(int u_id) {
		return userDao.searchPoor(u_id);
	}

	public void insertPoor(Poor poor) {
		userDao.insertPoor(poor);
	}

	//根据用户名和密码查找公司
	public Company searchCompany(String username, String password) {
		return userDao.searchCompany(username,password);
	}

	//根据id获取公司
	public Company getCompanyById(int id) {
		return userDao.getCompanyById(id);
	}

	//修改公司信息
	public void updateCompany(Company company) {
		userDao.updateCompany(company);
	}

	//添加公司
	public void addCompany(Company company) {
		userDao.addCompany(company);
	}

	//修改公司的密码
	public void modifyCompanyPassword(int id, String s) {
		userDao.modifyCompanyPassword(id,s);
	}

	//添加用户
	public void addUser(User user) {
		userDao.addUser(user);
	}

	//修改用户
	public void modifyUser(User user) {
		userDao.modifyUser(user);
	}

	//删除用户
	public int deleteUsers(int[] ids) {
		return userDao.deleteUsers(ids);
	}

	//查询公司
	public List<Company> searchCompanies(int page, int[] audit,String filter) {
		return userDao.searchCompanies(page,audit,filter);
	}

	//修改密码
	public void changeUserPassword(User user) {
		userDao.changeUserPassword(user);
	}

	//绑定email
	public void bindEmail(User user) {
		userDao.bindEmail(user);
	}

	//根据学号查找用户
	public User searchUserBySchoolNum(String school_num) {
		return userDao.searchUserBySchoolNum(school_num);
	}

	//判断用户名或学号是否存在重复
	public boolean isUserOrSchoolNumRepeat(User user) {
		return userDao.isUserOrSchoolNumRepeat(user);
	}

	//判断公司的用户名是否存在重复
	public boolean isUsernameRepeat(Company company) {
		return userDao.isUsernameRepeat(company);
	}

	//查找所有贫困生信息
	public List<Poor> searchPoors(int page) {
		return userDao.searchPoors(page);
	}

	//认证贫困信息
	public void authPoor(int u_id, int status) {
		userDao.authPoor(u_id,status);
	}

	//审核公司
	public void auditCompany(int id, int audit) {
		userDao.auditCompany(id,audit);
	}

	//查找该用户的收藏
	public List<Collection> searchCollections(int id, int page) {
		return userDao.searchCollections(id,page);
	}

	//取消收藏
	public void deleteCollection(int u_id, int j_id) {
		userDao.deleteCollection(u_id,j_id);
	}

	//搜索到的用户总数
	public int getUsersCount(String filter) {
		return userDao.getUsersCount(filter);
	}

	//搜索到的公司数
	public int getCompaniesCount(int[] audit, String filter) {
		return userDao.getCompaniesCount(audit,filter);
	}
}
