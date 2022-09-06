package com.first.board.login.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.first.board.login.dao.LoginDao;

@Service
public class LoginService {
	
	@Autowired
	private LoginDao dao;

	public Map<String, Object> selectInfo(String m_id) {
		return dao.selectInfo(m_id);
	}

}
