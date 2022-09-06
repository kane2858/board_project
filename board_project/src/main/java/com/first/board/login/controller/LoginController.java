package com.first.board.login.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.first.board.login.service.LoginService;

@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Autowired
	private LoginService service;
	
	@RequestMapping("")
	public ModelAndView loginHome(ModelAndView mv) {
		mv.setViewName("login/login");
		return mv;
	}
	
	@RequestMapping("/selectInfo")
	public ModelAndView selectInfo(
			ModelAndView mv,
			@RequestParam String m_id,
			@RequestParam String m_pw,
			RedirectAttributes rttr,
			HttpSession session
			) {
		
		Map<String, Object> map = service.selectInfo(m_id);
		if(map == null) {
			rttr.addFlashAttribute("msg", "등록된 아이디가 없습니다");
			mv.setViewName("redirect:/login");
		} else if(map.get("M_PW").equals(m_pw)) {
			rttr.addFlashAttribute("msg", "로그인에 성공했습니다");
			map.remove("M_PW");
			session.setAttribute("sessionInfo", map);
			mv.setViewName("redirect:/");
		} else {
			rttr.addFlashAttribute("msg", "비밀번호를 확인해주세요");
			rttr.addFlashAttribute("m_id", m_id);
			mv.setViewName("redirect:/login");
		}
		
		return mv;
	}
	
	@RequestMapping("/logout")
	public ModelAndView logout(
			ModelAndView mv,
			RedirectAttributes rttr,
			HttpSession session
			) {
		
		session.invalidate();
		rttr.addFlashAttribute("msg", "로그아웃");
		mv.setViewName("redirect:/login");
		return mv;
	}

}
