package com.zzu.service;

import com.zzu.model.Classify;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface RedisService {
    List<Classify> getClassifies();
}
