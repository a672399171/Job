package com.zzu.service;

import com.zzu.dto.Result;
import com.zzu.model.Apply;
import com.zzu.model.Collection;
import com.zzu.model.Poor;
import com.zzu.model.User;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface UserService {
    User search(String username, String password);

    User getById(int id);

    Result<Collection> searchCollections(int u_id, int page, int pageSize);

    List<Apply> getApplies(int uId, int jId);

    List<Poor> searchPoor(int uId);

    Result modifyInfo(User user);

    Result deleteCollection(int u_id, int j_id);

    User exists(String username);

    void bindEmail(User user);

    Result changeUserPassword(int id,String password);

    User searchBySchoolNum(String schoolNum);

    Result addUser(User user);

    Result insertPoor(Poor poor);
}
