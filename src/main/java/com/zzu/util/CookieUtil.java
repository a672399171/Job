package com.zzu.util;

import com.zzu.common.Common;
import com.zzu.util.coder.PBECoder;
import org.apache.commons.codec.binary.Base64;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {
    // 3DES 加密
    private static final String password = "job_application";
    private static byte[] salt = null;
    private static final Logger logger = LogManager.getLogger(CookieUtil.class);

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
}
