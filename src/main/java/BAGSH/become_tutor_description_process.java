package BAGSH;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class become_tutor_description_process implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 request.getSession().setAttribute("introduction", request.getParameter("introduce"));
	        request.getSession().setAttribute("experience", request.getParameter("experience"));
	        request.getSession().setAttribute("motivation", request.getParameter("motivate"));
	        request.getSession().setAttribute("title", request.getParameter("title"));

	        request.getSession().setAttribute("university", request.getParameter("university"));
	        request.getSession().setAttribute("degree", request.getParameter("degree"));
	        request.getSession().setAttribute("specialization", request.getParameter("specialization"));
	        request.getSession().setAttribute("startYear", request.getParameter("start_year"));
	        request.getSession().setAttribute("endYear", request.getParameter("end_year"));
	        request.getSession().setAttribute("noHigherEducation", request.getParameter("no-higher-education") != null);

	        return "become_tutor_availability"; // Redirect to the next step in the tutor registration process
	    }
	}