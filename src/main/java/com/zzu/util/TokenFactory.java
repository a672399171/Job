package com.zzu.util;

import com.zzu.model.Token;

import java.util.UUID;

/**
 * Created by zhanglei53 on 2016/8/11.
 */
public class TokenFactory {

    public static Token getInstance() {
        return new Token(generateToken());
    }

    // 生成token
    private static String generateToken() {
        return UUID.randomUUID().toString();
    }
}
