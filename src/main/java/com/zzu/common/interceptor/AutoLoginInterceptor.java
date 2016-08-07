package com.zzu.common.interceptor;

import com.zzu.common.Common;
import com.zzu.model.Company;
import com.zzu.model.User;
import com.zzu.service.CompanyService;
import com.zzu.service.UserService;
import com.zzu.util.CookieUtil;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2016/8/7.
 */
public class AutoLoginInterceptor implements HandlerInterceptor {
    @Resource
    private UserService userService;
    @Resource
    private CompanyService companyService;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(Common.USER);
        Company company = (Company) session.getAttribute(Common.COMPANY);

        if (user == null && session.getAttribute(Common.COOKIE_USER_CHECKED) == null &&
                request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals(Common.JOB_COOKIE_USER_REMEMBER)) {
                    String username = CookieUtil.getUserName(cookie.getValue());
                    session.setAttribute(Common.USER, userService.exists(username));
                    session.setAttribute(Common.COOKIE_USER_CHECKED, true);
                    break;
                }
            }
        }

        if (company == null && session.getAttribute(Common.COOKIE_COMPANY_CHECKED) == null &&
                request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if (cookie.getName().equals(Common.JOB_COOKIE_COMPANY_REMEMBER)) {
                    String username = CookieUtil.getUserName(cookie.getValue());
                    session.setAttribute(Common.COMPANY, companyService.exists(username));
                    session.setAttribute(Common.COOKIE_COMPANY_CHECKED, true);
                    break;
                }
            }
        }

        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
