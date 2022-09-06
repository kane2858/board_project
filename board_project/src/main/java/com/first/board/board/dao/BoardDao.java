package com.first.board.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.first.board.board.vo.BoardVo;

@Repository
public class BoardDao {
	
	@Autowired
	private SqlSession sqlsession;

	public List<Map<String, Object>> selectKind() {
		return sqlsession.selectList("board.selectKind");
	}

	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) {
		return sqlsession.selectList("board.selectBoardList", map);
	}

	public int insertBoard(Map<String, Object> map) {
		return sqlsession.insert("board.insertBoard", map);
	}

	public List<Map<String, Object>> selectdetail(String b_no) {
		return sqlsession.selectList("board.selectdetail", b_no);
	}

	public int updateBoard(Map<String, Object> map) {
		return sqlsession.update("board.updateBoard", map);
	}

	public int deleteBoard(String b_no) {
		return sqlsession.update("board.deleteBoard", b_no);
	}

	public int totalCnt() {
		return sqlsession.selectOne("board.totalCnt");
	}

	public int totalCntKind(String k_no) {
		return sqlsession.selectOne("board.totalCntKind", k_no);
	}

	public int totalCntSearch(Map<String, Object> map) {
		return sqlsession.selectOne("board.totalCntSearch", map);
	}

	public int totalCntKindSearch(Map<String, Object> map) {
		return sqlsession.selectOne("board.totalCntKindSearch", map);
	}

	public List<Map<String, Object>> selectBoardListKind(Map<String, Object> map) {
		return sqlsession.selectList("board.selectBoardListKind", map);
	}
	
	public List<Map<String, Object>> selectBoardListSearch(Map<String, Object> map) {
		return sqlsession.selectList("board.selectBoardListSearch", map);
	}
	
	public List<Map<String, Object>> selectBoardListKindSearch(Map<String, Object> map) {
		return sqlsession.selectList("board.selectBoardListKindSearch", map);
	}

	public int updateCount(String b_no) {
		return sqlsession.update("board.updateCount", b_no);
	}

	public int selectMaxBNo() {
		return sqlsession.selectOne("board.selectMaxBNo");
	}

	public int recommentWrite(Map<String, Object> map) {
		return sqlsession.insert("board.recommentWrite", map);
	}

	public List<Map<String, Object>> selectdetailRecomment(String b_no) {
		return sqlsession.selectList("board.selectdetailRecomment", b_no);
	}

	public int recommentDelete(String r_no) {
		return sqlsession.update("board.recommentDelete", r_no);
	}

	public Map<String, Object> selectRGno(String r_no) {
		return sqlsession.selectOne("board.selectRGno", r_no);
	}

	public int updateRGno(Map<String, Object> map) {
		return sqlsession.update("board.updateRGno", map);
	}

	public int insertRerecomment(Map<String, Object> map) {
		return sqlsession.insert("board.insertRerecomment", map);
	}

	public List<Map<String, Object>> poiExcel() {
		return sqlsession.selectList("board.poiExcel");
	}

	public List<Map<String, Object>> poiExcelKind(Map<String, Object> map) {
		return sqlsession.selectList("board.poiExcelKind", map);
	}

	public List<Map<String, Object>> poiExcelSearch(Map<String, Object> map) {
		return sqlsession.selectList("board.poiExcelSearch", map);
	}

	public List<Map<String, Object>> poiExcelKindSearch(Map<String, Object> map) {
		return sqlsession.selectList("board.poiExcelKindSearch", map);
	}

	public int fileRemove(String file_name) {
		return sqlsession.delete("board.fileRemove", file_name);
	}

	public int updateBoardFile(Map<String, Object> map) {
		return sqlsession.insert("board.updateBoardFile", map);
	}

	public BoardVo selectBoardRecommentDetail(String b_no) {
		return sqlsession.selectOne("board.selectBoardRecommentDetail", b_no);
	}
	
	

}