package com.zzu.service.impl;

import com.zzu.dao.ClassifyDao;
import com.zzu.model.Classify;
import com.zzu.model.Position;
import com.zzu.service.RedisService;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
@Service("redisService")
public class RedisServiceImpl implements RedisService {
    @Resource
    private RedisTemplate<String, String> redisTemplate;
    @Resource
    private ClassifyDao classifyDao;

    public List<Classify> getClassifies() {
        List<Classify> classifies = null;
        classifies = (List<Classify>) redisTemplate.boundHashOps("hashData").get("classifies");

        if (classifies == null) {
            classifies = classifyDao.getAllClassifies();
            List<Position> positions = classifyDao.searchPositions(0);

            for (Classify classify : classifies) {
                for (Position position : positions) {
                    if (position.getcId() == classify.getId()) {
                        classify.getPositions().add(position);
                    }
                }
            }
            redisTemplate.boundHashOps("hashData").put("classifies", classifies);
        }

        return classifies;
    }
}
