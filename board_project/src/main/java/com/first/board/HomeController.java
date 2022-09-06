package com.first.board;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	@RequestMapping("")
	public ModelAndView home(
			ModelAndView mv,
			HttpSession session
			) {
		mv.setViewName("home");
		return mv;
	}
	
}
