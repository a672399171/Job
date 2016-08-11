package com.zzu.util;

import com.zzu.common.Common;
import com.zzu.util.coder.PBECoder;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import javax.crypto.*;
import javax.crypto.spec.DESedeKeySpec;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class CookieUtil {
    // 3DES 加密
    private static final String password = "job_application";
    private static byte[] salt = null;

    static {
        try {
            salt = PBECoder.initSalt();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void addCookieCore(String cookieName, String serverName, HttpServletResponse response, String username, int expiry) {
        String s = null;
        try {
            s = Base64.encodeBase64String(PBECoder.encrypt(username.getBytes(), password, salt));
        } catch (Exception e) {
            e.printStackTrace();
        }

        Cookie c = new Cookie(cookieName, s);
        c.setDomain(serverName);
        c.setPath("/");
        c.setMaxAge(expiry);
        response.addCookie(c);
    }

    public static void addCookie(String cookieName, String serverName, HttpServletResponse response, String username) {
        addCookieCore(cookieName, serverName, response, username, Common.MAX_AGE);
    }

    public static void deleteCookie(String cookieName, String serverName, HttpServletResponse response, String username) {
        addCookieCore(cookieName, serverName, response, username, 0);
    }

    public static String getUserName(String src) {
        String s = null;
        try {
            s = new String(PBECoder.decrypt(Base64.decodeBase64(src), password, salt));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    public static void main(String[] args) throws Exception {
        String username = "a672399171";
        System.out.println("salt:" + Base64.encodeBase64String(salt));
        byte[] data = PBECoder.encrypt(username.getBytes(), password, salt);
        String str = Base64.encodeBase64String(data);
        System.out.println("加密后：" + str);
        System.out.println("加密后：" + getUserName(str));
    }
}
