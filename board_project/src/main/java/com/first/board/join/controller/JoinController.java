package com.first.board.join.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.first.board.join.service.JoinService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
@RequestMapping("/join")
public class JoinController {
	
	@Autowired
	private JoinService service;
	
	@RequestMapping("")
	public ModelAndView joinHome(
			ModelAndView mv
			) {
		
		mv.setViewName("join/join");
		
		return mv;
	}
	
	@PostMapping("/idchk")
	@ResponseBody
	public String idchk(
			@RequestParam String m_id
			) {
		String result = service.idchk(m_id);
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		String res = gson.toJson(result);
		return res;
	}
	
	@PostMapping("/insertInfo")
	public ModelAndView insertInfo(
			ModelAndView mv,
			@RequestParam(value = "us_name") String m_name,
			@RequestParam(value = "us_id") String m_id,
			@RequestParam(value = "us_pw") String m_pw,
			RedirectAttributes rttr
			) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("m_name", m_name);
		map.put("m_id", m_id);
		map.put("m_pw", m_pw);
		
		int result = service.insertInfo(map);
		
		if(result > 0) {
			rttr.addFlashAttribute("msg", "회원가입에 성공하였습니다");
		} else {
			rttr.addFlashAttribute("msg", "회원가입에 실패하였습니다");
		}
		mv.setViewName("redirect:/");		
		return mv;
	}

}
