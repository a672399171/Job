package com.zzu.service.impl;

import com.zzu.common.Common;
import com.zzu.dao.ClassifyDao;
import com.zzu.dao.SchoolDao;
import com.zzu.model.*;
import com.zzu.service.RedisService;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Service("redisService")
public class RedisServiceImpl implements RedisService {
    @Resource
    private RedisTemplate<String, String> redisTemplate;
    @Resource
    private ClassifyDao classifyDao;
    @Resource
    private SchoolDao schoolDao;

    public RedisServiceImpl() {
        redisTemplate.expire(Common.AUTH_TOKEN, 30, TimeUnit.MINUTES);
    }

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

    public List<School> getSchools() {
        List<School> schools = null;
        schools = (List<School>) redisTemplate.boundHashOps("hashData").get("schools");
        if (schools == null) {
            schools = schoolDao.getSchools();
            List<Major> majors = schoolDao.getMajors();

            for (School school : schools) {
                for (Major major : majors) {
                    if (major.getSchool().getId() == school.getId()) {
                        school.getMajors().add(major);
                    }
                }
            }
            redisTemplate.boundHashOps("hashData").put("schools", schools);
        }
        return schools;
    }

    public void insertVerify(Verify verify) {
        redisTemplate.boundHashOps(verify.getType()).put(verify.getVerify(), verify);
    }

    public void deleteVerify(Verify verify) {
        if (verify != null && verify.getVerify() != null && verify.getType() != null) {
            redisTemplate.boundHashOps(verify.getType()).delete(verify.getVerify());
        }
    }

    public void insertToken(Token token) {
        if (token != null) {
            redisTemplate.boundHashOps(Common.AUTH_TOKEN).put(token.getToken(), token);
        }
    }

    public Token getToken(String key) {
        if (key != null) {
            redisTemplate.boundHashOps(Common.AUTH_TOKEN).get(key);
        }
        return null;
    }

    public Verify searchVerify(String verify, String type) {
        Verify v = (Verify) redisTemplate.boundHashOps(type).get(verify);
        redisTemplate.boundHashOps(type).delete(verify);
        return v;
    }
}
