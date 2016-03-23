package com.zzu.dao;

import com.zzu.model.Resume;
import com.zzu.model.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.Reader;

/**
 * Created by Administrator on 2016/3/4.
 */
@Component
public class ResumeDao {
	@Resource
	private SqlSession session;

	public Resume getResumeByUid(int u_id) {
		Resume resume = session.selectOne("mapping.ResumeMapper.getResumeByUid", u_id);
		return resume;
	}

	public void insertResume(Resume resume) {
		session.insert("mapping.ResumeMapper.insertResume", resume);
	}

	public void updateResume(Resume resume) {
		session.update("mapping.ResumeMapper.updateResume", resume);
	}
}
