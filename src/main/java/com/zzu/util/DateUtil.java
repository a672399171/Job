package com.zzu.util;

import net.sf.json.JSONObject;
import org.jsoup.Connection;
import org.jsoup.Jsoup;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * Created by Administrator on 2016/3/4.
 */
public class DateUtil {
	//字符串转换成日期类型
	public static Date toDate(String dateStr) {
		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			date = sdf.parse(dateStr);
		} catch (ParseException e) {
			e.printStackTrace();
			date = new Date();
		}
		return date;
	}

	//根据时间戳产生日期
	public static Date toDate(long time) {
		Date date = new Date(time);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println(sdf.format(date));
		return date;
	}

	public static boolean scan() {
		String body = "";
		Connection.Response response = null;
		try {
			response = Jsoup.connect("http://qibao.gyyx.cn/Buy/GetItemDetail")
					.data("r", Math.random() + "")
					.data("ItemCode", "23140006")
					.ignoreContentType(true)
					.timeout(30000)
					.execute();

			body = response.body();
		} catch (IOException e) {
			e.printStackTrace();
		}

		JSONObject object = JSONObject.fromObject(body);
		System.out.println(object.getJSONObject("Data"));
		String str1 = object.getJSONObject("Data").getString("CurrentTime");
		str1 = StringUtil.getNumberList(str1).get(0);
		System.out.println(toDate(Long.parseLong(str1)));

		String str2 = object.getJSONObject("Data").getString("BusinessEndDate");
		str2 = StringUtil.getNumberList(str2).get(0);
		System.out.println(toDate(Long.parseLong(str2)));

		return object.getBoolean("Show");
	}

	public static void main(String[] args) {
		long l = 1458536322941l;
		//System.out.println(toDate(l));
		scan();
	}
}
