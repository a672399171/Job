package com.zzu.dao;

import com.zzu.model.Collection;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface CollectionDao {
    Collection getCollection(@Param("uId") int uId,
                             @Param("jId") int jId);

    int deleteCollection(@Param("uId") int uId,
                         @Param("jId") int jId);

    int addCollection(@Param("uId") int uId,
                      @Param("jId") int jId);

    List<Collection> searchCollections(@Param("u_id") int u_id,
                                       @Param("start") int start,
                                       @Param("count") int count);

    int getCollectionCount(@Param("u_id") int u_id);
}
