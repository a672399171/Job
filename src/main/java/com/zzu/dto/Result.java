package com.zzu.dto;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public class Result<E> extends ArrayList<E> {
    private boolean success = true;
    private Map<String, Object> data = new HashMap<String, Object>();
    private String error;
    private int totalPage;
    private int totalItem;
    private int page;
    private int pageSize;

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public Map<String, Object> getData() {
        return data;
    }

    public void setData(Map<String, Object> data) {
        this.data = data;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getTotalItem() {
        return totalItem;
    }

    public void setTotalItem(int totalItem) {
        this.totalItem = totalItem;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    private void resetPage() {

    }
}
