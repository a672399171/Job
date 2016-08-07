package com.zzu.service.impl;

import com.zzu.dao.ApplyDao;
import com.zzu.dao.CompanyDao;
import com.zzu.dto.Result;
import com.zzu.common.Common;
import com.zzu.model.Apply;
import com.zzu.model.Company;
import com.zzu.service.CompanyService;
import com.zzu.util.StringUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by zhanglei53 on 2016/8/5.
 */
@Service("companyService")
public class CompanyServiceImpl implements CompanyService {
    @Resource
    private CompanyDao companyDao;
    @Resource
    private ApplyDao applyDao;

    public Result login(String username, String password) {
        Result result = new Result();
        Company company = companyDao.search(username, StringUtil.toMd5(password), null);
        if (company == null) {
            result.setSuccess(false);
            result.setError("用户名或密码错误");
        } else {
            company.setPassword(null);
            result.getData().put(Common.COMPANY, company);
        }
        return result;
    }

    public Company getById(int id) {
        return companyDao.getById(id);
    }

    public Result modifyPassword(int id, String password) {
        Result result = new Result();
        if (companyDao.modifyPassword(id, password) < 1) {
            result.setSuccess(false);
            result.setError("修改失败");
        }
        return result;
    }

    public Result addCompany(Company company) {
        Result result = new Result();
        if (companyDao.addCompany(company) < 1) {
            result.setSuccess(false);
            result.setError("添加失败");
        }
        return result;
    }

    public Result updateCompany(Company company) {
        Result result = new Result();
        if (companyDao.updateCompany(company) < 1) {
            result.setSuccess(false);
            result.setError("更新失败");
        }
        return result;
    }

    public Company exists(String username) {
        return companyDao.search(username, null, null);
    }

    public Company searchByEmail(String email) {
        return companyDao.search(null, null, email);
    }

    public Result<Apply> getApplies(int id, int page, int pageSize) {
        Result<Apply> result = new Result<Apply>(page, pageSize);
        if (page < 1) {
            result.setSuccess(false);
            result.setError("页码错误");
        } else {
            result.setList(applyDao.getAppliesByCompany(id, (page - 1) * pageSize, pageSize));
            result.setTotalItem(applyDao.getCompanyApplyCount(id));
        }

        return result;
    }
}
