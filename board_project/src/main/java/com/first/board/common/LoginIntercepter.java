package com.first.board.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;


@Component
public class LoginIntercepter implements HandlerInterceptor {
	
    
    private void saveDestination(HttpServletRequest request) {
    	String uri = request.getRequestURI();
    	String query = request.getQueryString();
    	if(query == null || query.equals("null")) {
    		query = "";
    	}else {
    		query = "?"+query;
    	}
    	
    	if(request.getMethod().equals("GET")) {
    		request.getSession().setAttribute("destination", uri + query);
    	}
    }
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    		
    	
    	HttpSession httpSession = request.getSession();
    	
    	if(httpSession.getAttribute("sessionInfo") == null) {
    		saveDestination(request);
    		response.sendRedirect("/board/login");
    				return false;
    	}
    	return true;
    }
}
