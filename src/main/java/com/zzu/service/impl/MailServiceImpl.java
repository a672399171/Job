package com.zzu.service.impl;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.Map;

/**
 * Created by Administrator on 2016/4/1.
 */
@Service("mailService")
public class MailServiceImpl {
	@Resource
	private JavaMailSender mailSender;
	@Resource
	private VelocityEngine velocityEngine;
	private static final String FROM = "m15617536860@163.com";

	/**
	 * 发送邮件模板
	 * @param email 发送到的地址
	 * @param subject 标题
	 * @param tplSrc 模板的文件名
	 * @param map 参数
	 */
	public void sendEmail(final String email, final String subject, final String tplSrc, final Map<String, Object> map) {
		MimeMessagePreparator preparator = new MimeMessagePreparator() {
			public void prepare(MimeMessage mimeMessage) throws Exception {
				MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
				message.setTo(email);
				message.setFrom(FROM);
				message.setSentDate(new Date());
				message.setSubject(subject);
				String text = VelocityEngineUtils.mergeTemplateIntoString(
						velocityEngine, tplSrc, "utf-8", map);
				message.setText(text, true);
			}
		};
		this.mailSender.send(preparator);
	}
}
