package com.zzu.model;

import java.util.Date;

/**
 * Created by Administrator on 2016/3/4.
 */
public class Varify {
	private String username;
	private String varify;
	private Date time;
	private String email;

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

	public String getVarify() {
		return varify;
	}

	public void setVarify(String varify) {
		this.varify = varify;
	}

}
