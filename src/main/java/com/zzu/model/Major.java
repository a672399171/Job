package com.zzu.model;

import java.io.Serializable;

/**
 * Created by Administrator on 2016/3/10.
 */
public class Major implements Serializable {
	private int id;
	private School school;
	private String major;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public School getSchool() {
		return school;
	}

	public void setSchool(School school) {
		this.school = school;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}
}
