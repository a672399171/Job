package com.zzu.model;

import java.util.Date;

/**
 * Created by Administrator on 2016/3/9.
 */
public class Job {
	private int id;
	private Position type;
	private String name;
	private String description;
	private int person_count;
	private String skill;
	private int low_salary;
	private int high_salary;
	private Date post_time;
	private Company post_company;
	private String tag;
	private String work_time;
	private int status;

	public Position getType() {
		return type;
	}

	public void setType(Position type) {
		this.type = type;
	}

	public Company getPost_company() {
		return post_company;
	}

	public void setPost_company(Company post_company) {
		this.post_company = post_company;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPerson_count() {
		return person_count;
	}

	public void setPerson_count(int person_count) {
		this.person_count = person_count;
	}

	public String getSkill() {
		return skill;
	}

	public void setSkill(String skill) {
		this.skill = skill;
	}

	public int getLow_salary() {
		return low_salary;
	}

	public void setLow_salary(int low_salary) {
		this.low_salary = low_salary;
	}

	public int getHigh_salary() {
		return high_salary;
	}

	public void setHigh_salary(int high_salary) {
		this.high_salary = high_salary;
	}

	public Date getPost_time() {
		return post_time;
	}

	public void setPost_time(Date post_time) {
		this.post_time = post_time;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getWork_time() {
		return work_time;
	}

	public void setWork_time(String work_time) {
		this.work_time = work_time;
	}
}
