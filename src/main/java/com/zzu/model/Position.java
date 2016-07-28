package com.zzu.model;

import java.io.Serializable;

/**
 * Created by Administrator on 2016/3/8.
 */
public class Position implements Serializable {
	private int id;
	private int cId;
	private String name;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getcId() {
		return cId;
	}

	public void setcId(int cId) {
		this.cId = cId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
