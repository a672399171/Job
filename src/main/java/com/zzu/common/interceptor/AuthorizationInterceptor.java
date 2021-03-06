package com.zzu.common.interceptor;

import com.zzu.common.annotaion.Authorization;
import com.zzu.common.Common;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Created by Administrator on 2016/7/30.
 */
public class AuthorizationInterceptor implements HandlerInterceptor {

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        HandlerMethod method = (HandlerMethod) handler;
        Authorization auth = method.getMethodAnnotation(Authorization.class);
        if (auth != null) {
            String[] values = auth.value();

            for(String value : values) {
                if (value.equals(Common.AUTH_USER_LOGIN)
                        && session.getAttribute(Common.USER) != null) {
                    return true;
                } else if (value.equals(Common.AUTH_COMPANY_LOGIN)
                        && session.getAttribute(Common.COMPANY) != null) {
                    return true;
                } else if (value.equals(Common.AUTH_ADMIN_LOGIN)
                        && session.getAttribute(Common.ADMIN) != null) {
                    return true;
                }
            }
            response.sendRedirect("/login");
            return false;
        }
        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
