package com.zzu.service.impl;

import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Map;

/**
 * Created by Administrator on 2016/4/1.
 */
@Service("mailService")
public class MailServiceImpl {
	@Resource
	public JavaMailSenderImpl mailSender;
	@Resource
	private SimpleMailMessage mailMessage;
	@Resource
	private FreeMarkerConfigurer freeMarkerConfigurer;

	/**
	 * 发送邮件模板
	 * @param email 发送到的地址
	 * @param title 标题
	 * @param tplSrc 模板的文件名
	 * @param map 参数
	 */
	public void sendEmail(String email, String title, String tplSrc, Map<String, Object> map) {
		try {
			MimeMessage mailMsg = mailSender.createMimeMessage();

			MimeMessageHelper messageHelper = new MimeMessageHelper(mailMsg, true, "UTF-8");
			// 接收邮箱
			messageHelper.setTo(email);
			// 发送邮箱
			messageHelper.setFrom(mailMessage.getFrom());
			// 发送时间
			messageHelper.setSentDate(new Date());
			// 邮件标题
			messageHelper.setSubject(title);
			// 设置昵称
			String nick = MimeUtility.encodeText("职来了");
			messageHelper.setFrom(new InternetAddress(nick + "<m15617536860@163.com>"));
			// true 表示启动HTML格式的邮件 邮件内容
			messageHelper.setText(getMailText(tplSrc, map), true);
			// 发送
			this.mailSender.send(mailMsg);
		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	private String getMailText(String src, Map<String, Object> map) {
		String html = "";

		try {
			// 装载模板
			Template tpl = freeMarkerConfigurer.getConfiguration().getTemplate(src);
			// 加入map到模板中 输出对应变量
			html = FreeMarkerTemplateUtils.processTemplateIntoString(tpl, map);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
		return html;
	}
}
