package com.zzu.model;

import java.util.Date;

/**
 * Created by Administrator on 2016/3/4.
 */
public class Verify {
	private String username;
	private String verify;
	private Date time;
	private String email;
	private int type;
	private String u;

	public String getU() {
		return u;
	}

	public void setU(String u) {
		this.u = u;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getEmail() {
		return email;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getVerify() {
		return verify;
	}

	public void setVerify(String verify) {
		this.verify = verify;
	}

}