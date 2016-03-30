package com.zzu.model;

/**
 * Created by Administrator on 2016/3/15.
 */
public class Apply {
	private Resume resume;
	private Job job;
	private int state;

	public Resume getResume() {
		return resume;
	}

	public void setResume(Resume resume) {
		this.resume = resume;
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
