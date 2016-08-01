package com.zzu.service;

import com.zzu.model.Classify;
import com.zzu.model.School;
import com.zzu.model.Verify;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface RedisService {
    List<Classify> getClassifies();

    List<School> getSchools();

    void insertVerify(Verify verify);

    Verify searchVerify(String verify,String type);
}
