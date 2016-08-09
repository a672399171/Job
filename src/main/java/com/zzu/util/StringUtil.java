package com.zzu.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Administrator on 2016/3/2.
 */
public class StringUtil {
	public static final String STR = "0123456789ABCDEFGHIJKLMNabcdefghijklmn";

	//判断字符串是否为空
	public static boolean isEmpty(String s) {
		return s == null || s.trim().equals("");
	}

	//MD5加密
	public static String toMd5(String str) {
		String result = "";
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			byte b[] = md.digest();
			int i;
			StringBuffer buf = new StringBuffer("");
			for (int offset = 0; offset < b.length; offset++) {
				i = b[offset];
				if (i < 0)
					i += 256;
				if (i < 16)
					buf.append("0");
				buf.append(Integer.toHexString(i));
			}
			result = buf.toString();
		} catch (NoSuchAlgorithmException e) {
			System.out.println(e);
		}
		return result;
	}

	//判断是否为email
	public static boolean isEmail(String email) {
		if (isEmpty(email)) {
			return false;
		}
		boolean flag = false;
		try {
			String check = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
			Pattern regex = Pattern.compile(check);
			Matcher matcher = regex.matcher(email);
			flag = matcher.matches();
		} catch (Exception e) {
			flag = false;
		}
		return flag;
	}

	//产生指定长度的字符串
	public static String randomString(int length) {
		StringBuilder sb = new StringBuilder();
		Random r = new Random();

		for (int i = 0; i < length; i++) {
			int index = r.nextInt(STR.length() - 1);
			sb.append(STR.charAt(index));
		}
		return sb.toString();
	}

	//判断是否为数字
	public static boolean isNumber(String str) {
		Pattern pattern = Pattern.compile("\\d+");
		Matcher matcher = pattern.matcher(str);
		return matcher.find();
	}

	//提取字符串中的数字
	public static List<String> getNumberList(String str) {
		List<String> list = new ArrayList<String>();
		Pattern pattern = Pattern.compile("(\\d+)");
		Matcher matcher = pattern.matcher(str);
		while (matcher.find()) {
			list.add(matcher.group(1));
		}
		return list;
	}

	public static void main(String[] args) {
		List<Long> longs = new ArrayList<Long>();
		longs.add(new Long(2));
		longs.add(new Long(3));

		System.out.println(longs.contains(new Long(2)));
	}
}
