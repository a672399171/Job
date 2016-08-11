package com.zzu.util.coder;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;
import java.security.Key;
import java.security.SecureRandom;

/**
 * Created by zhanglei53 on 2016/8/10.
 */
public class PBECoder {
    private static final String ALGORITHM = "PBEWITHMD5andDES";
    private static final int ITERATION_COUNT = 10;

    // 初始化salt，8字节
    public static byte[] initSalt() throws Exception {

        return new byte[]{(byte) 1, (byte) 0, (byte) 4, (byte) 5, (byte) 3, (byte) 2, (byte) 3, (byte) 5};
    }

    // 转换秘钥
    private static Key toKey(String password) throws Exception {
        PBEKeySpec keySpec = new PBEKeySpec(password.toCharArray());
        SecretKeyFactory factory = SecretKeyFactory.getInstance(ALGORITHM);
        return factory.generateSecret(keySpec);
    }

    // 加密
    public static byte[] encrypt(byte[] data, String password, byte[] salt) throws Exception {
        Key key = toKey(password);
        PBEParameterSpec pbeParameterSpec = new PBEParameterSpec(salt, ITERATION_COUNT);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, key, pbeParameterSpec);
        return cipher.doFinal(data);
    }

    // 解密
    public static byte[] decrypt(byte[] data, String password, byte[] salt) throws Exception {
        Key key = toKey(password);
        PBEParameterSpec pbeParameterSpec = new PBEParameterSpec(salt, ITERATION_COUNT);
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, key, pbeParameterSpec);
        return cipher.doFinal(data);
    }
}
