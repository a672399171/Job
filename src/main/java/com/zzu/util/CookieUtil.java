package com.zzu.util;

import com.zzu.common.Common;
import org.apache.commons.codec.binary.Hex;

import javax.crypto.*;
import javax.crypto.spec.DESedeKeySpec;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class CookieUtil {
    // 3DES 加密
    private static final String Algorithm = "DESede";
    private static Key key = null;
    private static Cipher cipher = null;

    static {
        try {
            key = build3DesKey();
            cipher = Cipher.getInstance(Algorithm);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (NoSuchPaddingException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void addCookieCore(String serverName, HttpServletResponse response, String username, int expiry) {
        String s = null;
        try {
            s = Hex.encodeHexString(encrypt(username));
        } catch (Exception e) {
            e.printStackTrace();
        }

        Cookie c = new Cookie(Common.JOB_COOKIE_USER_REMEMBER, s);
        c.setDomain(serverName);
        c.setPath("/");
        c.setMaxAge(expiry);
        response.addCookie(c);
    }

    public static void addCookie(String serverName, HttpServletResponse response, String username) {
        addCookieCore(serverName, response, username, Common.MAX_AGE);
    }

    public static void deleteCookie(String serverName, HttpServletResponse response, String username) {
        addCookieCore(serverName, response, username, 0);
    }

    public static String getUserName(String src) {
        String s = null;
        try {
            s = new String(decrypt(src));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return s;
    }

    // 加密
    private static byte[] encrypt(String src) throws Exception {
        cipher.init(Cipher.ENCRYPT_MODE, key);
        return cipher.doFinal(src.getBytes());
    }

    // 解密
    private static byte[] decrypt(String src) throws Exception {
        cipher.init(Cipher.DECRYPT_MODE, key);
        return cipher.doFinal(Hex.decodeHex(src.toCharArray()));
    }

    private static Key build3DesKey() throws Exception {
        // 生成KEY
        KeyGenerator generator = KeyGenerator.getInstance(Algorithm);
        generator.init(new SecureRandom());
        SecretKey secretKey = generator.generateKey();
        byte[] byteKey = secretKey.getEncoded();

        // Key转换
        DESedeKeySpec deSedeKeySpec = new DESedeKeySpec(byteKey);
        SecretKeyFactory factory = SecretKeyFactory.getInstance(Algorithm);

        return factory.generateSecret(deSedeKeySpec);
    }

    public static void main(String[] args) throws Exception {
        try {
            String str = Hex.encodeHexString(encrypt("a672399171"));
            System.out.println(str);
            // System.out.println(new String(decrypt(Hex.decodeHex(str.toCharArray()))));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
