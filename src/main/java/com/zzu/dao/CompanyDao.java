package com.zzu.dao;

import com.zzu.model.Collection;
import com.zzu.model.Company;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface CompanyDao {
    Company existsCompany(String username);

    Company searchCompanyByEmail(String email);

    Company getCompanyById(int id);

    void updateCompany(Company company);

    void addCompany(Company company);

    void modifyCompanyPassword(int id, String s);

    List<Company> searchCompanies(int page, int[] audit, String filter);

    void auditCompany(int id, int audit);

    int getUsersCount(String filter);

    int getCompaniesCount(int[] audit, String filter);

    int getNewCompanyCount();


}
