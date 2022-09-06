package com.first.board.board.vo;

import java.util.List;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class BoardVo {
	
	private String b_no;
	private String b_title;
	private String b_content;
	private String m_id;
	private String m_name;
	private String k_no;
	private String k_title;
	private String b_date;
	private String b_count;
	private List<RecommentVo> list_recomment;
	private List<FileinfoVo> list_fileinfo;

}
