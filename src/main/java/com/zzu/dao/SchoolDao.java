package com.zzu.dao;

import com.zzu.model.Major;
import com.zzu.model.School;

import java.util.List;

/**
 * Created by zhanglei53 on 2016/7/28.
 */
public interface SchoolDao {
    List<School> getSchools();

    void addSchool(String school);

    void addMajors(List<String> majors);

    List<Major> getSchoolsAndMajors();
}
