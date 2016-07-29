package com.zzu.dao;

import com.zzu.model.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface UserDao {
    User search(@Param("username") String username,
                @Param("password") String password);

    User exists(String username);

    void modifyInfo(String nickname, String sex, String photo_src, int uId);

    User getById(int id);

    void updateSecret(int id, boolean secret);

    Admin adminLogin(String username, String password);

    List<User> searchUsers(int page, String filter);

    User searchUserBySchoolNum(String schoolNum);

    Poor searchPoor(int uId);

    void insertPoor(Poor poor);

    void addUser(User user);

    void modifyUser(User user);

    int deleteUsers(int[] ids);

    void changeUserPassword(User user);

    void bindEmail(User user);

    boolean isUserOrSchoolNumRepeat(User user);

    boolean isUsernameRepeat(Company company);

    List<Poor> searchPoors(int page);

    void authPoor(int uId, int status);

    int getNewPoorCount();

    List<Admin> getAllAdmins();
}
