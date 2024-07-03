package BAGSH;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class become_tutor_about_process implements CommandHandler {

    @Override
    public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String id = request.getParameter("id");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            return "become_tutor_about";
        }

        // Store data in session
        request.getSession().setAttribute("id", id);
        request.getSession().setAttribute("password", password);
        request.getSession().setAttribute("fullname", request.getParameter("fullname"));
        request.getSession().setAttribute("gender", request.getParameter("gender"));
        request.getSession().setAttribute("birthdate", request.getParameter("birthdate"));
        request.getSession().setAttribute("phone", request.getParameter("phone"));
        request.getSession().setAttribute("email", request.getParameter("email"));
        request.getSession().setAttribute("subject", request.getParameter("subject"));

        return "become_tutor_photo";
    }
}