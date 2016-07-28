package com.zzu.dao;

import com.zzu.model.Collection;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface CollectionDao {
    Collection getCollection(int uId, int jId);

    void deleteCollection(int uId, int jId);

    void addCollection(int uId, int jId);

    List<Collection> searchCollections(int id, int page);

}
