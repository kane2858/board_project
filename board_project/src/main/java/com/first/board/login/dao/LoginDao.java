package com.first.board.login.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class LoginDao {
	
	@Autowired
	private SqlSession sqlsession;

	public Map<String, Object> selectInfo(String m_id) {
		return sqlsession.selectOne("login.selectInfo", m_id);
	}

}
