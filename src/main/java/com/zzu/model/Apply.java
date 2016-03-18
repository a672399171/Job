package com.zzu.model;

/**
 * Created by Administrator on 2016/3/15.
 */
public class Apply {
	private User user;
	private Job job;
	private int state;

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

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}
}
