package com.zzu.util;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;

/**
 * Created by Administrator on 2016/3/23.
 */
public class NetUtil {
	private static final String url = "http://jw.zzu.edu.cn/scripts/stuinfo.dll/check";

	public static boolean isZZUStudent(String username, String password) {
		String grade = username.substring(0, 4);
		if (!StringUtil.isNumber(username) || !StringUtil.isNumber(grade)) {
			return false;
		}
		Document document = null;
		try {
			document = Jsoup.connect(url)
					.data("xuehao", username)
					.data("nianji", grade)
					.data("mima", password)
					.data("selec","http://jw.zzu.edu.cn/scripts/stuinfo.dll/check")
					.timeout(30000)
					.post();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Elements elements = document.select("input");
		if (elements != null) {
			for(Element element : elements) {
				if (element.attr("name").equals("userid")) {
					return true;
				}
			}
		}

		return false;
	}

	public static void main(String[] args) {
		System.out.println(isZZUStudent("20133410139", "672399171"));
	}
}
