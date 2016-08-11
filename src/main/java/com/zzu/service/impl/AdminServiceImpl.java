package com.zzu.service.impl;

import com.zzu.dao.CompanyDao;
import com.zzu.dao.JobDao;
import com.zzu.dao.UserDao;
import com.zzu.service.AdminService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

@Service("adminService")
public class AdminServiceImpl implements AdminService {
    @Resource
    private UserDao userDao;
    @Resource
    private JobDao jobDao;
    @Resource
    private CompanyDao companyDao;

    public int getNewPoorCount() {
        return userDao.getNewPoorCount();
    }

    public int getNewCompanyCount() {
        return companyDao.getNewCompanyCount();
    }
}
