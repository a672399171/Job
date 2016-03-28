package com.zzu.model;

/**
 * Created by Administrator on 2016/3/7.
 */
public class Poor {
	private int u_id;
	private String name;
	private String email;
	private Major major;
	private String src;
	private int status;
	private boolean isNew;

	public boolean isNew() {
		return isNew;
	}

	public void setNew(boolean aNew) {
		isNew = aNew;
	}

	public int getU_id() {
		return u_id;
	}

	public void setU_id(int u_id) {
		this.u_id = u_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Major getMajor() {
		return major;
	}

	public void setMajor(Major major) {
		this.major = major;
	}

	public String getSrc() {
		return src;
	}

	public void setSrc(String src) {
		this.src = src;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
}
