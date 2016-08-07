package com.zzu.util;

import com.zzu.common.Common;

import javax.crypto.*;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

public class CookieUtil {
    // 3DES 加密
    private static final String Algorithm = "DESede";
    private static final String KEY = "job_zzuzl_cn";

    public static void addCookie(String serverName, HttpServletResponse response, String username) {
        String s = new String(encrypt(username.getBytes()));

        Cookie c = new Cookie(Common.JOB_COOKIE_USER_REMEMBER, s);
        c.setDomain(serverName);
        c.setPath("/");
        c.setMaxAge(Common.MAX_AGE);
        response.addCookie(c);
    }

    public static String getUserName(byte[] src) {
        return new String(decrypt(src));
    }

    // 加密
    private static byte[] encrypt(byte[] src) {
        SecretKey secretKey = new SecretKeySpec(build3DesKey(KEY), Algorithm);
        try {
            Cipher cipher = Cipher.getInstance(Algorithm);
            // 初始化为加密模式
            cipher.init(Cipher.ENCRYPT_MODE, secretKey);
            return cipher.doFinal(src);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (InvalidKeyException e) {
            e.printStackTrace();
        } catch (BadPaddingException e) {
            e.printStackTrace();
        } catch (IllegalBlockSizeException e) {
            e.printStackTrace();
        }

        return src;
    }

    // 解密
    public static byte[] decrypt(byte[] src) {
        try {
            SecretKey secretKey = new SecretKeySpec(build3DesKey(KEY), Algorithm);
            Cipher c1 = Cipher.getInstance(Algorithm);
            // 初始化为解密模式
            c1.init(Cipher.DECRYPT_MODE, secretKey);
            return c1.doFinal(src);
        } catch (java.security.NoSuchAlgorithmException e1) {
            e1.printStackTrace();
        } catch (javax.crypto.NoSuchPaddingException e2) {
            e2.printStackTrace();
        } catch (java.lang.Exception e3) {
            e3.printStackTrace();
        }
        return src;
    }

    public static byte[] build3DesKey(String keyStr) {
        byte[] key = new byte[24];    //声明一个24位的字节数组，默认里面都是0
        byte[] temp = new byte[0];    //将字符串转成字节数组
        try {
            temp = keyStr.getBytes("UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        if (key.length > temp.length) {
            //如果temp不够24位，则拷贝temp数组整个长度的内容到key数组中
            System.arraycopy(temp, 0, key, 0, temp.length);
        } else {
            //如果temp大于24位，则拷贝temp数组24个长度的内容到key数组中
            System.arraycopy(temp, 0, key, 0, key.length);
        }
        return key;
    }

    public static void main(String[] args) {
        String s = new String(encrypt("a672399171".getBytes()));
        String d = new String(decrypt(s.getBytes()));
        System.out.println(s);
        System.out.println(d);
    }
}
