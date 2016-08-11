package com.zzu.service;

import com.zzu.dto.Result;
import com.zzu.model.Apply;
import com.zzu.model.Company;

/**
 * Created by zhanglei53 on 2016/8/5.
 */
public interface CompanyService {

    Result login(String username,String password);

    Company getById(int id);

    Result modifyPassword(int id,String password);

    Result addCompany(Company company);

    Result updateCompany(Company company);

    Company exists(String username);

    Company searchByEmail(String email);

    Result<Apply> getApplies(int id,int page,int pageSize);

    Result updateApply(int jId,int rId,int state);
}
