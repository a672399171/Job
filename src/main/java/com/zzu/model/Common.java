package com.zzu.model;

/**
 * Created by Administrator on 2016/3/4.
 */
public class Common {
	//session用 常量
	public static final String USER = "user";
	public static final String RESUME = "resume";
	public static final String ERROR = "error";
	public static final String ADMIN = "admin";
	public static final String COMPANY = "company";
	//贫困生审核信息
	public static final int NO = 0;
	public static final int AUDIT = 1;
	public static final int SUCCESS = 2;
	public static final int FAILED = 3;
	//职位信息审核
	public static final int STOP = 0;
	public static final int RUNNING = 1;
	//申请职位状态
	public static final int APPLYING = 0;
	public static final int APPLYFILED = 1;
	public static final int APPLYSUCCESS = 2;
	//分页常量
	public static final int COUNT = 10;
	public static final int SMALL_COUNT = 5;
	//性别常量
	public static final String NAN = "男";
	public static final String NV = "女";
	//公司认证状态
	public static final int UNAUTH = 0;
	public static final int AUTHING = 1;
	public static final int AUTHED = 2;
	//treenode的类型
	public static final String CLASSIFY = "classify";
	public static final String POSITION = "position";
	//邮件验证的类型
	public static final String BINGEMAIL = "email";
	public static final String FINDPWD = "findPwd";
	public static final String COMPANYREG = "companyReg";
	//默认的头像路径
	public static final String DEFAULTPHOTO = "headphoto.png";

	// 权限码
	public static final String AUTH_USER_LOGIN = "auth_user_login";
	public static final String AUTH_COMPANY_LOGIN = "auth_company_login";
	public static final String AUTH_ADMIN_LOGIN = "auth_admin_login";
}
