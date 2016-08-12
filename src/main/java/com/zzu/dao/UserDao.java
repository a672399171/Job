package com.zzu.dao;

import com.zzu.model.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    User search(@Param("username") String username,
                @Param("password") String password);

    User exists(String username);

    List<User> list(@Param("start") int start,
                    @Param("count") int count,
                    @Param("filter") String filter);

    int listCount(@Param("filter") String filter);

    int modifyInfo(User user);

    User getById(int id);

    void updateSecret(int id, boolean secret);

    Admin adminLogin(@Param("username") String username,
                     @Param("password") String password);

    List<User> searchUsers(int page, String filter);

    User searchBySchoolNum(String schoolNum);

    List<Poor> searchPoor(@Param("uId") int uId);

    int insertPoor(Poor poor);

    int addUser(User user);

    void modifyUser(User user);

    int deleteUsers(int[] ids);

    int changeUserPassword(@Param("id") int id,
                           @Param("password") String password);

    void bindEmail(User user);

    boolean isUserOrSchoolNumRepeat(User user);

    boolean isUsernameRepeat(Company company);

    List<Poor> searchPoors(int page);

    void authPoor(int uId, int status);

    int getNewPoorCount();

    List<Admin> getAllAdmins();
}
