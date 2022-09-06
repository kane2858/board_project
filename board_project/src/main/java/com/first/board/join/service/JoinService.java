package com.first.board.join.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.first.board.join.dao.JoinDao;

@Service
public class JoinService {
	
	@Autowired
	JoinDao dao;

	public String idchk(String u_id) {
		return dao.idchk(u_id);
	}

	public int insertInfo(Map<String, Object> map) {
		return dao.insertInfo(map);
	}

}
