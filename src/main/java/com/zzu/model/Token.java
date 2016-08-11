package com.zzu.model;

import java.util.Calendar;
import java.util.Date;

/**
 * Created by zhanglei53 on 2016/8/11.
 */
public class Token {
    private String token;
    private Date failTime;

    public Token(String token, Date failTime) {
        this.token = token;
        this.failTime = failTime;
    }

    public Token(String token) {
        this.token = token;
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.MINUTE, 30);
        this.failTime = calendar.getTime();
    }

    public String getToken() {
        return token;
    }

    public Date getFailTime() {
        return failTime;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public void setFailTime(Date failTime) {
        this.failTime = failTime;
    }
}
