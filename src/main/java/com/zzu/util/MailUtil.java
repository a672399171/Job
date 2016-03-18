package com.zzu.util;


import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * Created by Administrator on 2016/3/4.
 */
public class MailUtil {

	public static void sendEmail(String url,String email) {
		StringBuilder sb = new StringBuilder();
		sb.append("<html><head></head><body>");
		sb.append("<a href='" + url + "'>点击验证</a>48小时有效");
		sb.append("</body></html>");

		JavaMailSenderImpl sender = new JavaMailSenderImpl();
		sender.setHost("smtp.qq.com");

		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message);
		try {
			helper.setTo(email);
			helper.setFrom("672399171@qq.com");
			helper.setSubject("测试");
			helper.setText(sb.toString(),true);
		} catch (MessagingException e) {
			e.printStackTrace();
		}

		sender.setUsername("672399171@qq.com"); // 根据自己的情况,设置username
		sender.setPassword("didiaozuoren"); // 根据自己的情况, 设置password
		Properties prop = new Properties();
		prop.put("mail.smtp.auth", true); // 将这个参数设为true，让服务器进行认证,认证用户名和密码是否正确
		prop.put("mail.smtp.timeout", 25000);
		prop.put("mail.smtp.starttls.enable", true);
		sender.setJavaMailProperties(prop);
		// 发送邮件
		sender.send(message);

		System.out.println("邮件发送成功..");
	}

	public static void main(String[] args) {

	}
}
