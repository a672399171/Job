package com.zzu.dao;

import com.zzu.model.Apply;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface ApplyDao {

    List<Apply> getApplies(int uId, int jId);

    void addApply(Apply apply);

    List<Apply> getAppliesByCompany(int id, int page);

    int getCompanyApplyCount(int id);

    void updateApply(int jId, int rId, int state);
}
