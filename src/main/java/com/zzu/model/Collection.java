package com.zzu.model;

import java.util.Date;

/**
 * Created by Administrator on 2016/3/14.
 */
public class Collection {
	private User user;
	private Job job;
	private Date collect_time;

	public Date getCollect_time() {
		return collect_time;
	}

	public void setCollect_time(Date collect_time) {
		this.collect_time = collect_time;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Job getJob() {
		return job;
	}

	public void setJob(Job job) {
		this.job = job;
	}
}
