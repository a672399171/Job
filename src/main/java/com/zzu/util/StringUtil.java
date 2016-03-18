package com.zzu.util;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import server.smsService;
import sun.misc.BASE64Encoder;

import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

/**
 * Created by Administrator on 2016/3/2.
 */
public class StringUtil {
	public static final String STR = "0123456789ABCDEFGHIJKLMNabcdefghijklmn";

	public static boolean isEmpty(String s) {
		return s == null || s.trim().equals("");
	}

	public static String toMd5(String str) {
		//确定计算方法
		MessageDigest md5 = null;
		String newStr = null;
		try {
			md5 = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		BASE64Encoder base64en = new BASE64Encoder();
		//加密后的字符串
		try {
			newStr = base64en.encode(md5.digest(str.getBytes("utf-8")));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return newStr;
	}

	public static void showAllCitys() {
		FileOutputStream fileOutputStream = null;
		BufferedWriter bw = null;
		try {
			fileOutputStream = new FileOutputStream("F:/a.json");
			bw = new BufferedWriter(new OutputStreamWriter(fileOutputStream));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		Document doc = null;
		try {
			doc = Jsoup.connect("http://www.maps7.com/china_province.php").get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Elements hrefs = doc.select("a");
		StringBuilder stringBuilder = new StringBuilder();
		for (Element href : hrefs) {
			System.out.println(href.html());
			stringBuilder.append("\"" + href.html() + "\"" + ",");
		}
		try {
			bw.write(stringBuilder.toString());
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				bw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static String randomString(int length) {
		StringBuilder sb = new StringBuilder();
		Random r = new Random();

		for(int i=0;i<length;i++) {
			int index = r.nextInt(STR.length() - 1);
			sb.append(STR.charAt(index));
		}
		return sb.toString();
	}

	public static void sendMsg() {
		// 发送短信
		String userid = "a672399171";   //你的用户名
		String pass = "a1703628649";    //你的密码
		String mobiles = "15617536860"; //对方接收的手机号
		String msg = "JAVA测试短信通过2008-11-13,验证码123456789";  //内容
		String time = "";

		smsService service = new smsService();
		String result = service.sendSms(userid, pass, mobiles, msg, time);
		System.out.println("结果：" + result);
	}

	public static void main(String[] args) {
		System.out.println(toMd5("admin"));
		//showAllCitys();
		//sendMsg();
	}
}
