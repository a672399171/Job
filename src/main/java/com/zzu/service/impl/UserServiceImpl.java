package com.zzu.service.impl;

import com.zzu.dao.ApplyDao;
import com.zzu.dao.CollectionDao;
import com.zzu.dao.UserDao;
import com.zzu.dto.Result;
import com.zzu.model.*;
import com.zzu.service.UserService;
import com.zzu.util.StringUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;
    @Resource
    private CollectionDao collectionDao;
    @Resource
    private ApplyDao applyDao;

    public User search(String username, String password) {
        return userDao.search(username, StringUtil.toMd5(password));
    }

    public User getById(int id) {
        return userDao.getById(id);
    }

    public Result<Collection> searchCollections(int u_id, int page, int pageSize) {
        Result<Collection> result = new Result<Collection>(page, pageSize);
        if (page < 1) {
            result.setSuccess(false);
            result.setError("页数错误");
            return result;
        }

        result.setList(collectionDao.searchCollections(u_id, (page - 1) * pageSize, pageSize));
        result.setTotalItem(collectionDao.getCollectionCount(u_id));

        return result;
    }

    public List<Apply> getApplies(int uId, int jId) {
        return applyDao.getApplies(uId, jId);
    }

    public List<Poor> searchPoor(int uId) {
        return userDao.searchPoor(uId);
    }

    public Result modifyInfo(User user) {
        Result result = new Result();
        if (userDao.modifyInfo(user) < 1) {
            result.setError("更新失败");
            result.setSuccess(false);
        }
        return result;
    }

    public Result deleteCollection(int u_id, int j_id) {
        Result result = new Result();
        if (collectionDao.deleteCollection(u_id, j_id) < 1) {
            result.setSuccess(false);
            result.setError("删除失败");
        }
        return result;
    }

    public User exists(String username) {
        return userDao.exists(username);
    }

    public void bindEmail(User user) {
        userDao.bindEmail(user);
    }

    public Result changeUserPassword(int id, String password) {
        Result result = new Result();
        if (password == null || password.length() < 6) {
            result.setSuccess(false);
            result.setError("密码长度最短6位");
        } else if (userDao.changeUserPassword(id, password) < 1) {
            result.setSuccess(false);
            result.setError("修改失败");
        }

        return result;
    }

    public User searchBySchoolNum(String schoolNum) {
        return userDao.searchBySchoolNum(schoolNum);
    }

    public Result addUser(User user) {
        Result result = new Result();
        result.setSuccess(false);
        if(StringUtil.isEmpty(user.getUsername())) {
            result.setError("用户名不能为空");
        } else if(StringUtil.isEmpty(user.getPassword())) {
            result.setError("密码不能为空");
        } else if(userDao.addUser(user) < 1) {
            result.setError("添加失败");
        } else {
            result.setSuccess(true);
        }
        return result;
    }

    /*
    public void updateSecret(int id, boolean secret) {
        userDao.updateSecret(id, secret);
    }

    public void insertOrUpdateVarify(Verify varify) {
        userDao.insertOrUpdateVarify(varify);
    }

    public void deleteVarify(Verify varify) {
        userDao.deleteVarify(varify);
    }

    public Admin adminLogin(String username, String password) {
        return userDao.adminLogin(username, password);
    }

    //搜索用户
    public List<User> searchUsers(int page, String filter) {
        return userDao.searchUsers(page, filter);
    }

    public void insertPoor(Poor poor) {
        userDao.insertPoor(poor);
    }

    //根据用户名和密码查找公司
    public Company searchCompany(String username, String password) {
        return userDao.searchCompany(username, password);
    }

    //根据id获取公司
    public Company getCompanyById(int id) {
        return userDao.getCompanyById(id);
    }

    //修改公司信息
    public void updateCompany(Company company) {
        userDao.updateCompany(company);
    }

    //添加公司
    public void addCompany(Company company) {
        userDao.addCompany(company);
    }

    //修改公司的密码
    public void modifyCompanyPassword(int id, String s) {
        userDao.modifyCompanyPassword(id, s);
    }

    //判断该用户名的公司是否存在
    public Company existsCompany(String username) {
        return userDao.existsCompany(username);
    }

    //根据email查找公司
    public Company searchCompanyByEmail(String email) {
        return userDao.searchCompanyByEmail(email);
    }

    //修改用户
    public void modifyUser(User user) {
        userDao.modifyUser(user);
    }

    //删除用户
    public int deleteUsers(int[] ids) {
        return userDao.deleteUsers(ids);
    }

    //查询公司
    public List<Company> searchCompanies(int page, int[] audit, String filter) {
        return userDao.searchCompanies(page, audit, filter);
    }

    //修改密码
    public void changeUserPassword(User user) {
        userDao.changeUserPassword(user);
    }

    //根据学号查找用户
    public User searchUserBySchoolNum(String school_num) {
        return userDao.searchUserBySchoolNum(school_num);
    }

    //判断用户名或学号是否存在重复
    public boolean isUserOrSchoolNumRepeat(User user) {
        return userDao.isUserOrSchoolNumRepeat(user);
    }

    //判断公司的用户名是否存在重复
    public boolean isUsernameRepeat(Company company) {
        return userDao.isUsernameRepeat(company);
    }

    //查找所有贫困生信息
    public List<Poor> searchPoors(int page) {
        return userDao.searchPoors(page);
    }

    //认证贫困信息
    public void authPoor(int u_id, int status) {
        userDao.authPoor(u_id, status);
    }

    //审核公司
    public void auditCompany(int id, int audit) {
        userDao.auditCompany(id, audit);
    }

    //查找该用户的收藏
    public List<Collection> searchCollections(int id, int page) {
        return userDao.searchCollections(id, page);
    }

    //取消收藏
    public void deleteCollection(int u_id, int j_id) {
        userDao.deleteCollection(u_id, j_id);
    }

    //搜索到的用户总数
    public int getUsersCount(String filter) {
        return userDao.getUsersCount(filter);
    }

    //搜索到的公司数
    public int getCompaniesCount(int[] audit, String filter) {
        return userDao.getCompaniesCount(audit, filter);
    }

    //获取未处理的贫困生认定的数量
    public int getNewPoorCount() {
        return userDao.getNewPoorCount();
    }

    //获取未审核的公司数量
    public int getNewCompanyCount() {
        return userDao.getNewCompanyCount();
    }

    //添加评论
    public void addComment(Comment comment) {
        userDao.addComment(comment);
    }

    //获取所有的管理员
    public List<Admin> getAllAdmins() {
        return userDao.getAllAdmins();
    }*/
}
