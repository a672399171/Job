package com.zzu.model;

/**
 * Created by Administrator on 2016/3/1.
 */
public class User {
	private int id;
	private String username;
	private String password;
	private String school_num;
	private String nickname;
	private String phone;
	private String email;
	private String photo_src;
	private String sex;
	private boolean push;

	public int getId() {
		return id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoto_src() {
		return photo_src;
	}

	public void setPhoto_src(String photo_src) {
		this.photo_src = photo_src;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public boolean isPush() {
		return push;
	}

	public void setPush(boolean push) {
		this.push = push;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSchool_num() {
		return school_num;
	}

	public void setSchool_num(String school_num) {
		this.school_num = school_num;
	}
}
