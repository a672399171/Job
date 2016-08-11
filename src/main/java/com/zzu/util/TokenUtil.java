package com.zzu.util;

import com.zzu.common.Common;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by zhanglei53 on 2016/8/11.
 */
public class TokenUtil {
    public static final boolean auth(HttpServletRequest request) {
        return request.getAttribute(Common.AUTH_TOKEN) != null;
    }
}
