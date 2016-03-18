package com.zzu.dao;

import com.zzu.model.Resume;
import com.zzu.model.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.Reader;

/**
 * Created by Administrator on 2016/3/4.
 */
@Component
public class ResumeDao {
	private SqlSessionFactory factory = null;
	private SqlSession session = null;

	public ResumeDao() {
		try {
			Reader reader = Resources.getResourceAsReader("SqlMapConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public Resume getResumeByUid(int u_id) {
		session = factory.openSession();

		Resume resume = session.selectOne("mapping.ResumeMapper.getResumeByUid", u_id);
		session.commit();
		return resume;
	}

	public void insertResume(Resume resume) {
		session = factory.openSession();

		session.insert("mapping.ResumeMapper.insertResume", resume);
		session.commit();
	}

	public void updateResume(Resume resume) {
		session = factory.openSession();

		session.update("mapping.ResumeMapper.updateResume", resume);
		session.commit();
	}
}
