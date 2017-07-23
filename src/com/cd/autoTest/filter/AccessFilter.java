package com.cd.autoTest.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AccessFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain filterChain)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) arg0;
		HttpServletResponse response = (HttpServletResponse) arg1;
		HttpSession session = request.getSession();
		String uri=request.getRequestURI();
		if(!uri.contains(".cs")&&!uri.contains(".js")&&!uri.contains(".png"))
		{
			if (session.getAttribute("user") == null&&request.getServletPath().indexOf("/loginAction")==-1) {
				System.out.println();
				response.sendRedirect("/autoTestWeb/loginAction");
				return;
			}
			if(session.getAttribute("user") != null&&request.getServletPath().equals("/")){
				response.sendRedirect("/autoTestWeb/main");
				return;
			}
		}
		filterChain.doFilter(arg0, arg1);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
