package com.zzu.service;

import com.zzu.dto.Result;
import com.zzu.model.*;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface UserService {
    User search(String username, String password);

    User getById(int id);

    Result<Collection> searchCollections(int u_id, int page, int pageSize);

    Collection getCollection(int u_id, int j_id);

    Result deleteCollection(int u_id, int j_id);

    Result addCollection(int u_id, int j_id);

    List<Apply> getApplies(int uId, int jId);

    Result addApply(Resume resume, int jId);

    List<Poor> searchPoor(int uId);

    Result modifyInfo(User user);

    User exists(String username);

    void bindEmail(User user);

    Result changeUserPassword(int id, String password);

    User searchBySchoolNum(String schoolNum);

    Result addUser(User user);

    Result insertPoor(Poor poor);

    Admin adminLogin(String username,String password);

    Result<User> list(int page,int pageSize,String filter);
}
