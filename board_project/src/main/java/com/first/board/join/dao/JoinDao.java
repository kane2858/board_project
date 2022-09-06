package com.first.board.join.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JoinDao {
	
	@Autowired
	SqlSession sqlsession;

	public String idchk(String u_id) {
		System.out.println("aaa"+u_id);
		return sqlsession.selectOne("join.idchk",u_id);
	}

	public int insertInfo(Map<String, Object> map) {
		return sqlsession.insert("join.insertInfo", map);
	}

}
