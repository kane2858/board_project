package com.first.board.board.vo;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class RecommentVo {
	
	private String r_no;
	private String b_no;
	private String r_content;
	private String m_id;
	private String m_name;
	private String r_date;
	private String r_pno;
	private String r_depth;
	private String r_gno;
	private String r_useyn;

}
