package com.zzu.service;

import com.zzu.dao.UserDao;
import com.zzu.model.*;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
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

	public List<User> searchUsers() {
		return userDao.searchUsers();
	}

	public Poor searchPoor(int u_id) {
		return userDao.searchPoor(u_id);
	}

	public void insertPoor(Poor poor) {
		userDao.insertPoor(poor);
	}

	public Company searchCompany(String username, String password) {
		return userDao.searchCompany(username,password);
	}

	public Company getCompanyById(int id) {
		return userDao.getCompanyById(id);
	}

	public void updateCompany(Company company) {
		userDao.updateCompany(company);
	}

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
	public void deleteUser(int id) {
		userDao.deleteUser(id);
	}

	public List<Company> searchCompanies() {
		return userDao.searchCompanies();
	}

	//修改密码
	public void changeUserPassword(User user) {
		userDao.changeUserPassword(user);
	}

	//绑定email
	public void bindEmail(User user) {
		userDao.bindEmail(user);
	}
}
