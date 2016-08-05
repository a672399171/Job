package com.zzu.dao;

import com.zzu.model.Company;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface CompanyDao {
    Company search(@Param("username") String username,
                   @Param("password") String password,
                   @Param("email") String email);

    Company getById(int id);

    int updateCompany(Company company);

    int addCompany(Company company);

    int modifyPassword(int id, String s);

    List<Company> searchCompanies(int page, int[] audit, String filter);

    void auditCompany(int id, int audit);

    int getUsersCount(String filter);

    int getCompaniesCount(int[] audit, String filter);

    int getNewCompanyCount();


}
