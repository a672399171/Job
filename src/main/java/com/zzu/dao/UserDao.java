package com.zzu.dao;

import com.zzu.model.*;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.io.IOException;
import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2016/3/1.
 */
@Component
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

	public Varify searchVarifyByUsername(String username) {
		Varify varify = session.selectOne("mapping.UserMapper.searchVarifyByUsername", username);
		return varify;
	}

	public void insertVarify(Varify varify) {
		session.insert("mapping.UserMapper.insertVarify", varify);
	}

	public void updateVarify(Varify varify) {
		session.update("mapping.UserMapper.updateVarify", varify);
	}

	public Admin adminLogin(String username, String password) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("password", password);
		Admin admin = session.selectOne("mapping.UserMapper.adminLogin", map);
		return admin;
	}

	public List<User> searchUsers() {
		List<User> users = null;
		users = session.selectList("mapping.UserMapper.searchUsers");

		return users;
	}

	//根据学号查找用户
	public User searchUserBySchoolNum(String school_num) {
		User user = null;
		user = session.selectOne("mapping.UserMapper.searchUserBySchoolNum");
		return user;
	}

	public Poor searchPoor(int u_id) {
		Poor poor = session.selectOne("mapping.UserMapper.searchPoor",u_id);
		return poor;
	}

	public void insertPoor(Poor poor) {
		session.insert("mapping.UserMapper.insertPoor",poor);
	}

	public Company searchCompany(String username,String password) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("username",username);
		map.put("password",password);
		Company company = session.selectOne("mapping.UserMapper.searchCompany",map);
		return company;
	}

	public Company getCompanyById(int id) {
		Company company = session.selectOne("mapping.UserMapper.getCompanyById",id);
		return company;
	}

	public void updateCompany(Company company) {
		session.update("mapping.UserMapper.updateCompany",company);
	}

	public void modifyCompanyPassword(int id, String s) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("password",s);
		session.update("mapping.UserMapper.modifyCompanyPassword",map);
	}

	//添加用户
	public void addUser(User user) {
		session.insert("mapping.UserMapper.addUser",user);
	}

	//修改用户
	public void modifyUser(User user) {
		session.update("mapping.UserMapper.modifyUser",user);
	}

	//删除用户
	public void deleteUser(int id) {
		session.delete("mapping.UserMapper.deleteUser",id);
	}

	public List<Company> searchCompanies() {
		List<Company> companies = null;
		companies = session.selectList("mapping.UserMapper.searchCompanies");
		return companies;
	}

	//修改密码
	public void changeUserPassword(User user) {
		session.update("mapping.UserMapper.changeUserPassword",user);
	}

	//绑定email
	public void bindEmail(User user) {
		session.update("mapping.UserMapper.bindEmail",user);
	}
}
