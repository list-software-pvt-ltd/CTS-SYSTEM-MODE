package cts.filter;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SecurityHeaderFilter implements Filter {
	private static final List<String> ALLOWED_METHODS = Arrays.asList("GET", "POST");

  	    @Override
	    public void init(FilterConfig filterConfig) throws ServletException {
	        // Initialization code if needed
	    }
  	    
  		@Override
		public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
				throws IOException, ServletException {
			// TODO Auto-generated method stub
  			HttpServletRequest req = (HttpServletRequest) request;
			 HttpServletResponse res = (HttpServletResponse) response;

			 String method = req.getMethod();
		        if (!ALLOWED_METHODS.contains(method)) {
		            // Send 405 Method Not Allowed
		            res.setStatus(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
		            res.setHeader("Allow", "GET, POST"); // RFC requirement for 405 responses
		            res.getWriter().write("Error: HTTP Method " + method + " is not allowed.");
		            return; // STOP processing here
		        }
		        // Set Security Headers
		        res.setHeader("X-Frame-Options", "SAMEORIGIN");
		        res.setHeader("X-XSS-Protection", "1; mode=block");
		        res.setHeader("X-Content-Type-Options", "nosniff");
		        res.setHeader("Content-Security-Policy", "frame-ancestors 'self';");
		        res.setHeader("Strict-Transport-Security", "max-age=31536000; includeSubDomains");
		        res.setHeader("X-Permitted-Cross-Domain-Policies", "none");
		        res.setHeader("Referrer-Policy", "no-referrer");

		        // Continue with the next filter or servlet
		        chain.doFilter(request, response);
		} 
		 @Override
		    public void destroy() {
		        // Cleanup code if needed
		    }
	}