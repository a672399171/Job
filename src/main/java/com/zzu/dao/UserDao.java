package com.zzu.dao;

import com.zzu.model.*;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;

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
	private SqlSessionFactory factory = null;
	private SqlSession session = null;

	public UserDao() {
		try {
			Reader reader = Resources.getResourceAsReader("SqlMapConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public User search(String username, String password) {
		session = factory.openSession();
		Map map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("password", password);

		User user = session.selectOne("mapping.UserMapper.search", map);
		session.commit();
		return user;
	}

	public User exists(String username) {
		session = factory.openSession();

		User user = session.selectOne("mapping.UserMapper.exists", username);
		session.commit();
		return user;
	}

	public void modifyInfo(String nickname, String sex, String photo_src, int u_id) {
		session = factory.openSession();
		Map map = new HashMap<String, Object>();
		map.put("id", u_id);
		map.put("nickname", nickname);
		map.put("sex", sex);
		map.put("photo_src", photo_src);

		session.update("mapping.UserMapper.modifyInfo", map);
		session.commit();
	}

	public User getUserById(int id) {
		session = factory.openSession();

		User user = session.selectOne("mapping.UserMapper.getUserById", id);
		session.commit();
		return user;
	}

	public void updateSecret(int id, boolean secret) {
		session = factory.openSession();
		Map map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("secret", secret);

		session.update("mapping.UserMapper.updateSecret", map);
		session.commit();
	}

	public Varify searchVarifyByUsername(String username) {
		session = factory.openSession();
		Varify varify = session.selectOne("mapping.UserMapper.searchVarifyByUsername", username);
		session.commit();
		return varify;
	}

	public void insertVarify(Varify varify) {
		session = factory.openSession();
		session.insert("mapping.UserMapper.insertVarify", varify);
		session.commit();
	}

	public void updateVarify(Varify varify) {
		session = factory.openSession();
		session.update("mapping.UserMapper.updateVarify", varify);
		session.commit();
	}

	public Admin adminLogin(String username, String password) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("password", password);
		session = factory.openSession();
		Admin admin = session.selectOne("mapping.UserMapper.adminLogin", map);
		session.commit();
		return admin;
	}

	public List<User> searchUsers() {
		List<User> users = null;
		session = factory.openSession();
		users = session.selectList("mapping.UserMapper.searchUsers");
		session.commit();

		return users;
	}

	public Poor searchPoor(int u_id) {
		session = factory.openSession();
		Poor poor = session.selectOne("mapping.UserMapper.searchPoor",u_id);
		session.commit();
		return poor;
	}

	public void insertPoor(Poor poor) {
		session = factory.openSession();
		session.insert("mapping.UserMapper.insertPoor",poor);
		session.commit();
	}

	public Company searchCompany(String username,String password) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("username",username);
		map.put("password",password);
		session = factory.openSession();
		Company company = session.selectOne("mapping.UserMapper.searchCompany",map);
		session.commit();
		return company;
	}

	public Company getCompanyById(int id) {
		session = factory.openSession();
		Company company = session.selectOne("mapping.UserMapper.getCompanyById",id);
		session.commit();
		return company;
	}

	public void updateCompany(Company company) {
		session = factory.openSession();
		session.update("mapping.UserMapper.updateCompany",company);
		session.commit();
	}

	public void modifyCompanyPassword(int id, String s) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("password",s);
		session = factory.openSession();
		session.update("mapping.UserMapper.modifyCompanyPassword",map);
		session.commit();
	}

	//添加用户
	public void addUser(User user) {
		session = factory.openSession();
		session.insert("mapping.UserMapper.addUser",user);
		session.commit();
	}

	//修改用户
	public void modifyUser(User user) {
		session = factory.openSession();
		session.update("mapping.UserMapper.modifyUser",user);
		session.commit();
	}

	//删除用户
	public void deleteUser(int id) {
		session = factory.openSession();
		session.delete("mapping.UserMapper.deleteUser",id);
		session.commit();
	}
}
