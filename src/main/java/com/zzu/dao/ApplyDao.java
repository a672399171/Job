package com.zzu.dao;

import com.zzu.model.Apply;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface ApplyDao {

    List<Apply> getApplies(@Param("uId") int uId,
                           @Param("jId") int jId);

    int addApply(Apply apply);

    List<Apply> getAppliesByCompany(@Param("id") int id,
                                    @Param("start") int start,
                                    @Param("count") int count);

    int getCompanyApplyCount(@Param("id") int id);

    int updateApply(@Param("jId") int jId,
                    @Param("rId") int rId,
                    @Param("state") int state);
}
