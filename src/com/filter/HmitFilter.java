package com.filter;


import com.sun.net.httpserver.HttpExchange;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class HmitFilter
 */
public class HmitFilter implements Filter {
       
    /**
     * @see Filter#Filter()
     */
    public HmitFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		// pass the request along the filter chain
		HttpServletRequest hrequest = (HttpServletRequest) request;
		HttpSession session = hrequest.getSession();
		if (session.getAttribute("current_user") == null
				|| session.getAttribute("current_user").equals("")) {
			// 如果没登录，则跳到登录页面，这里假设登录页面的目录为/web/Login.jsp
			hrequest.getRequestDispatcher("/jsp/loginPage.jsp").forward(request,
					response);

		} else {
			// 如果登录了，继续往下执行 */
			chain.doFilter(request, response);
		}
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}


}
