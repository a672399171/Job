package com.zzu.common.interceptor;

import com.zzu.common.Common;
import com.zzu.model.Token;
import com.zzu.service.RedisService;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;

public class TokenInterceptor implements HandlerInterceptor {
    @Resource
    private RedisService redisService;

    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String authToken = request.getParameter(Common.AUTH_TOKEN);
        if (authToken != null) {
            // 0.如果token不为空，说明是内部人员
            // 1.redis查询 得到过期时间，如果过期，则返回fail
            // 2.如果token有效，则更新过期时间
            // 3.放入model中
            Token token = redisService.getToken(authToken);
            if (token != null && token.getFailTime().before(new Date())) {
                request.setAttribute(Common.AUTH_TOKEN, authToken);
            }
        }

        return true;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
