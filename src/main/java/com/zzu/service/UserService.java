package com.zzu.service;

import com.zzu.dto.Result;
import com.zzu.model.Collection;
import com.zzu.model.User;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface UserService {
    User search(String username,String password);

    User getById(int id);

    Result<Collection> searchCollections(int u_id,int page,int pageSize);
}
