package com.zzu.service;

import com.zzu.model.Classify;
import com.zzu.model.School;
import com.zzu.model.Token;
import com.zzu.model.Verify;

import java.util.List;

public interface RedisService {
    List<Classify> getClassifies();

    List<School> getSchools();

    void insertVerify(Verify verify);

    Verify searchVerify(String verify,String type);

    void deleteVerify(Verify verify);

    void insertToken(Token token);

    Token getToken(String key);
}
