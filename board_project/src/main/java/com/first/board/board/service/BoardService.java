package com.first.board.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.first.board.board.dao.BoardDao;
import com.first.board.board.vo.BoardVo;

@Service
public class BoardService {
	
	@Autowired
	private BoardDao dao;

	public List<Map<String, Object>> selectKind() {
		return dao.selectKind();
	}

	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) {
		return dao.selectBoardList(map);
	}

	public int insertBoard(Map<String, Object> map) {
		return dao.insertBoard(map);
	}

	public List<Map<String, Object>> selectdetail(String b_no) {
		return dao.selectdetail(b_no);
	}

	public int updateBoard(Map<String, Object> map) {
		return dao.updateBoard(map);
	}

	public int deleteBoard(String b_no) {
		return dao.deleteBoard(b_no);
	}

	public int totalCnt() {
		return dao.totalCnt();
	}

	public int totalCntKind(String k_no) {
		return dao.totalCntKind(k_no);
	}

	public int totalCntSearch(Map<String, Object> map) {
		return dao.totalCntSearch(map);
	}

	public int totalCntKindSearch(Map<String, Object> map) {
		return dao.totalCntKindSearch(map);
	}

	public List<Map<String, Object>> selectBoardListKind(Map<String, Object> map) {
		return dao.selectBoardListKind(map);
	}
	
	public List<Map<String, Object>> selectBoardListSearch(Map<String, Object> map) {
		return dao.selectBoardListSearch(map);
	}
	
	public List<Map<String, Object>> selectBoardListKindSearch(Map<String, Object> map) {
		return dao.selectBoardListKindSearch(map);
	}

	public int updateCount(String b_no) {
		return dao.updateCount(b_no);
		
	}

	public int selectMaxBNo() {
		return dao.selectMaxBNo();
	}

	public int recommentWrite(Map<String, Object> map) {
		return dao.recommentWrite(map);
	}

	public List<Map<String, Object>> selectdetailRecomment(String b_no) {
		return dao.selectdetailRecomment(b_no);
	}

	public int recommentDelete(String r_no) {
		return dao.recommentDelete(r_no);
	}

	public Map<String, Object> selectRGno(String r_no) {
		return dao.selectRGno(r_no);
	}

	public int updateRGno(Map<String, Object> map) {
		return dao.updateRGno(map);
	}

	public int insertRerecomment(Map<String, Object> map) {
		return dao.insertRerecomment(map);
	}

	public List<Map<String, Object>> poiExcel() {
		return dao.poiExcel();
	}

	public List<Map<String, Object>> poiExcelKind(Map<String, Object> map) {
		return dao.poiExcelKind(map);
	}

	public List<Map<String, Object>> poiExcelSearch(Map<String, Object> map) {
		return dao.poiExcelSearch(map);
	}

	public List<Map<String, Object>> poiExcelKindSearch(Map<String, Object> map) {
		return dao.poiExcelKindSearch(map);
	}

	public int fileRemove(String file_name) {
		return dao.fileRemove(file_name);
		
	}

	public int updateBoardFile(Map<String, Object> map) {
		return dao.updateBoardFile(map);
		
	}

	public BoardVo selectBoardRecommentDetail(String b_no) {
		return dao.selectBoardRecommentDetail(b_no);
	}

}
