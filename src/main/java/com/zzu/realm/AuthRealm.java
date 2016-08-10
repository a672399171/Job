package com.zzu.realm;

import com.zzu.model.User;
import com.zzu.service.UserService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.authc.*;
import org.apache.shiro.realm.jdbc.JdbcRealm;
import org.apache.shiro.util.ByteSource;

import javax.annotation.Resource;

/**
 * Created by zhanglei53 on 2016/8/10.
 */
public class AuthRealm extends JdbcRealm {
    @Resource
    private UserService userService;

    private static final Logger logger = LogManager.getLogger(AuthRealm.class);

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken upToken = (UsernamePasswordToken) token;
        String username = upToken.getUsername();
        String password = new String(upToken.getPassword());

        // Null username is invalid
        if (username == null) {
            throw new AccountException("用户名不能为空");
        }

        AuthenticationInfo info = null;
        User user = userService.search(username, password);
        if (user != null) {
            SimpleAuthenticationInfo saInfo = new SimpleAuthenticationInfo(user.getUsername(), password, user.getNickname());
            saInfo.setCredentialsSalt(ByteSource.Util.bytes(username));
            info = saInfo;
        } else {
            throw new UnknownAccountException("用户名或密码错误");
        }

        return info;
    }

}
