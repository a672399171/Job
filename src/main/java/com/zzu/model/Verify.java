package com.zzu.model;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2016/3/4.
 */
public class Verify implements Serializable {
	private String username;
	private String verify;
	private Date time;
	private String email;
	private String type;
	private Map<String,Serializable> data = new HashMap<String, Serializable>();

	public Map<String, Serializable> getData() {
		return data;
	}

	public void setData(Map<String, Serializable> data) {
		this.data = data;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
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
