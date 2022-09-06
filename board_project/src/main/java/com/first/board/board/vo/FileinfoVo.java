package com.first.board.board.vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class FileinfoVo {
	
	private String f_no;
	private String f_realname;
	private String f_newname;
	private String f_path;
	private String b_no;
	private String m_id;

}
