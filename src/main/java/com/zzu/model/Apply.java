package com.zzu.model;

import java.util.Date;

/**
 * Created by Administrator on 2016/3/15.
 */
public class Apply {
	private Resume resume;
	private Job job;
	private int state;
	private Date apply_date;

	public Date getApply_date() {
		return apply_date;
	}

	public void setApply_date(Date apply_date) {
		this.apply_date = apply_date;
	}

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
