package com.first.board.board.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.first.board.board.service.BoardService;
import com.first.board.board.vo.BoardVo;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	ServletContext sc;
	
	@Autowired
	private BoardService service;
	
	@RequestMapping("")
	public ModelAndView boardHome(ModelAndView mv, HttpSession session,
			@RequestParam(value = "p_no", defaultValue = "1") int currentPage,
			@RequestParam(value = "s_title", required = false) String s_title,
			@RequestParam(value = "s_content", required = false) String s_content,
			@RequestParam(value = "k_no", required = false) String k_no
			) {
		List<Map<String, Object>> kind = service.selectKind();
		mv.addObject("kind",kind);
		
		if(s_title=="") {
			s_title = null;
		}
		if(s_content=="") {
			s_content = null;
		}
		if(k_no=="") {
			k_no = null;
		}
		
		final int pageSize = 10;
		final int pageBlock = 5;
		int totalCnt = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("s_title", s_title);
		map.put("s_content", s_content);
		map.put("k_no", k_no);
		
		if(k_no == null && s_title == null) {
			totalCnt = service.totalCnt();
		} else if (k_no != null && s_title == null) {
			totalCnt = service.totalCntKind(k_no);
		} else if (k_no == null && s_title != null) {
			totalCnt = service.totalCntSearch(map);
		} else {
			totalCnt = service.totalCntKindSearch(map);
		}
		
		// paging 처리
		// 총 페이지 수
		int pageCnt = (totalCnt/pageSize) + (totalCnt%pageSize==0 ? 0 : 1);
		int startPage = 1;
		int endPage = 1;
		if(currentPage%pageBlock == 0) {
			startPage = ((currentPage/pageBlock)-1)*pageBlock + 1;
		} else {
			startPage = (currentPage/pageBlock)*pageBlock + 1;
		}
		endPage = startPage + pageBlock - 1;
		if(endPage > pageCnt) {
			endPage = pageCnt;
		}
		// System.out.println("paging" + startPage+"~"+endPage);
		
		// rownum 처리
		int startRnum = 0;
		int endRnum = 0;
		startRnum = (currentPage-1)*pageSize + 1;
		endRnum = startRnum + pageSize - 1;
		if(endRnum > totalCnt) {
			endRnum = totalCnt;
		}
		
		map.put("startRnum", startRnum);
		map.put("endRnum", endRnum);
		
		List<Map<String, Object>> list;
		
		if(k_no == null && s_title == null) {
			list = service.selectBoardList(map);
			mv.addObject("list", list);
		} else if (k_no != null && s_title == null) {
			list = service.selectBoardListKind(map);
			mv.addObject("list", list);
		} else if (k_no == null && s_title != null) {
			list = service.selectBoardListSearch(map);
			mv.addObject("list", list);
		} else {
			list = service.selectBoardListKindSearch(map);
			mv.addObject("list", list);
		}
		mv.addObject("p_no",currentPage);
		mv.addObject("startPage",startPage);
		mv.addObject("endPage",endPage);
		mv.addObject("pageCnt",pageCnt);
		
		mv.addObject("s_title", s_title);
		mv.addObject("s_content", s_content);
		mv.addObject("k_no", k_no);
		
		mv.setViewName("board/board");
		return mv;
	}
	
	@RequestMapping("/write")
	public ModelAndView boardWriteHome(ModelAndView mv, HttpSession session) {
		List<Map<String, Object>> kind = service.selectKind();
		mv.addObject("kind",kind);
		mv.setViewName("board/write");
		return mv;
	}
	
	@RequestMapping("/detail")
	public ModelAndView boardDetailHome(ModelAndView mv, HttpSession session,
			@RequestParam String b_no
			) {
		service.updateCount(b_no);
		BoardVo list = service.selectBoardRecommentDetail(b_no);
		mv.addObject("list", list);
		mv.setViewName("board/detail");
		return mv;
	}

	@PostMapping("/insertBoard")
	public ModelAndView insertBoard(
			ModelAndView mv,
			@RequestParam String b_title,
			@RequestParam String b_content,
			@RequestParam String k_no,
			HttpSession session,
			RedirectAttributes rttr,
			MultipartFile[] files,
			HttpServletRequest req
			) throws IllegalStateException, IOException {

		String realPath = req.getSession().getServletContext().getRealPath("")+"resources\\upload";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();
		String today = sdf.format(c1.getTime());
		String savePath = File.separator + today;
		String path = realPath + savePath;
		String dbPath = "\\resources\\upload"+savePath+"\\";
		File folder = new File(path);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		String realname = "";
		List<Map<String, Object>> fileInfo = new ArrayList<Map<String,Object>>();
		for(MultipartFile mfile : files) {
			Map<String, Object> fileMap = new HashMap<String, Object>();
			realname = mfile.getOriginalFilename();
			if(!realname.isEmpty()) {
				String newname = UUID.randomUUID().toString() + realname.substring(realname.lastIndexOf('.'));
				fileMap.put("f_path", dbPath);
				fileMap.put("f_realname", realname);
				fileMap.put("f_newname", newname);
				fileInfo.add(fileMap);
				mfile.transferTo(new File(folder, newname));
			}
		}
		
		Map<String, Object> sessionInfo = (Map<String, Object>) session.getAttribute("sessionInfo");
		String m_id = (String) sessionInfo.get("M_ID");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("b_title", b_title);
		map.put("b_content", b_content);
		map.put("k_no", k_no);
		map.put("m_id", m_id);
		map.put("files", fileInfo);
		int b_no = service.selectMaxBNo();
		map.put("b_no", b_no);
		int result = service.insertBoard(map);
		if(result > 0) {
			rttr.addFlashAttribute("msg", "등록하였습니다");
		} else {
			rttr.addFlashAttribute("msg", "등록실패했습니다");
		}
		mv.setViewName("redirect:/board");
		return mv;
	}
	
	@PostMapping("/update")
	public ModelAndView updateBoard(
			ModelAndView mv,
			@RequestParam String b_title,
			@RequestParam String b_content,
			@RequestParam String b_no,
			RedirectAttributes rttr,
			HttpServletRequest req,
			List<MultipartFile> files
			) throws IllegalStateException, IOException {
		String realPath = req.getSession().getServletContext().getRealPath("")+"resources\\upload";
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();
		String today = sdf.format(c1.getTime());
		String savePath = File.separator + today;
		String path = realPath + savePath;
		String dbPath = "\\resources\\upload"+savePath+"\\";
		File folder = new File(path);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		String realname = "";
		List<Map<String, Object>> fileInfo = new ArrayList<Map<String,Object>>();
		for(MultipartFile mfile : files) {
			Map<String, Object> fileMap = new HashMap<String, Object>();
			realname = mfile.getOriginalFilename();
			if(!realname.isEmpty()) {
				String newname = UUID.randomUUID().toString() + realname.substring(realname.lastIndexOf('.'));
				fileMap.put("f_path", dbPath);
				fileMap.put("f_realname", realname);
				fileMap.put("f_newname", newname);
				fileInfo.add(fileMap);
				mfile.transferTo(new File(folder, newname));
			}
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("files", fileInfo);
		map.put("b_title", b_title);
		map.put("b_content", b_content);
		map.put("b_no", b_no);
		int result = service.updateBoard(map);
		if(result > 0) {
			if(files.isEmpty()) {
				service.updateBoardFile(map);
			}
			rttr.addFlashAttribute("msg", "수정하였습니다");
		} else {
			rttr.addFlashAttribute("msg", "수정실패했습니다");
		}
		mv.setViewName("redirect:/board");
		return mv;
	}
	
	@PostMapping("/delete")
	public ModelAndView deleteBoard(
			ModelAndView mv,
			@RequestParam String b_no,
			RedirectAttributes rttr
			) {
		int result = service.deleteBoard(b_no);
		if(result > 0) {
			rttr.addFlashAttribute("msg", "삭제하였습니다");
		} else {
			rttr.addFlashAttribute("msg", "삭제실패했습니다");
		}
		mv.setViewName("redirect:/board");
		return mv;
	}
	
	@PostMapping("/recommentWrite")
	@ResponseBody
	public String recommentWrite(
			@RequestParam String r_content,
			@RequestParam String m_id,
			@RequestParam String b_no
			) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("r_content", r_content);
		map.put("m_id", m_id);
		map.put("b_no", b_no);
		
		int result = service.recommentWrite(map);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String str = gson.toJson(result);
		return str;
	}
	
	@PostMapping("/recommentDelete")
	@ResponseBody
	public String recommentDelete(
			@RequestParam String r_no
			) {
		
		int result = service.recommentDelete(r_no);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String str = gson.toJson(result);
		return str;
	}
	
	@PostMapping("/fileRemove")
	@ResponseBody
	public String fileRemove(
			@RequestParam String file_name,
			@RequestParam String file_path,
			HttpSession session
			) {
		
		String real_path = session.getServletContext().getRealPath("");
		
		File file = new File(real_path+file_path+file_name);
		String msg = "";
		if( file.exists() ){
    		if(file.delete()){
    			msg = "파일삭제 성공";
    			service.fileRemove(file_name);
    		}else{
    			msg = "파일삭제 실패";
    		}
    	}else{
    		msg = "파일이 존재하지 않습니다.";
    	}
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String str = gson.toJson(msg);
		return str;
	}
	
	@Transactional
	@PostMapping("/rerecommentWrite")
	@ResponseBody
	public String rerecommentWrite (
			@RequestParam String r_no,
			@RequestParam String r_content,
			@RequestParam String b_no,
			@RequestParam String m_id
			) {
		
		Map<String, Object> map = service.selectRGno(r_no);
		
		map.put("r_content", r_content);
		map.put("b_no", b_no);
		map.put("m_id", m_id);
		int result = 0;
		result = service.updateRGno(map);
		if(result > 0) {
			result = service.insertRerecomment(map);
		}
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String str = gson.toJson(result);
		return str;
	}
	
	@PostMapping("/statistics_join")
	@ResponseBody
	public String statistics_join (
			HttpServletResponse response,
			HttpServletRequest request,
			ModelAndView mv
			) throws IOException {
		response.setContentType("text/xml;charset=UTF-8");
		 

		HttpURLConnection conn=null;

		String str="http://localhost:8090/projob/statistics";

		

		//사이트연결 객체 생성

		URL url=new URL(str);

		//사이트 연결해서 결과값리턴

		conn=(HttpURLConnection)url.openConnection();

		 

		BufferedInputStream is

		=new BufferedInputStream(conn.getInputStream());

		byte[] b =new byte[4096];//2 4 8 16 1024 2048 4096

		StringBuffer buffer=new StringBuffer();

		 int i;

		     while( (i = is.read(b)) != -1){ 

		       buffer.append(new String(b, 0, i)); 

		    }

		     String str2 = buffer.toString();

		     System.out.println(str2);
		
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String result = gson.toJson(str2);
		return result;
	}

}
