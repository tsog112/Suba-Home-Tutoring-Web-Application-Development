package BAGSH;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class student_edit_profile_password_process implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
        String user_id = (String) session.getAttribute("id");

        String current_password = request.getParameter("password");
        String new_password = request.getParameter("new_password");
        String confirm_password = request.getParameter("confirm_password");

        if (!new_password.equals(confirm_password)) {
            request.setAttribute("error", "New passwords do not match.");
            return "student_edit_profile_password"; // Return to the password change page with error
        }

        dbconn db = new dbconn();
        Connection conn = db.getConn();

        String sql = "select password from users where user_id = ? and password = ?";

        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, user_id);
        psmt.setString(2, current_password);

        ResultSet rs = psmt.executeQuery();

        if (rs.next()) {
            sql = "update users set password = ? where user_id = ?";
            psmt = conn.prepareStatement(sql);
            psmt.setString(1, new_password);
            psmt.setString(2, user_id);
            psmt.executeUpdate();

            session.setAttribute("message", "Password successfully changed.");
            response.sendRedirect("student_edit_profile_password.do"); // Redirect to the same page to show the message
            return null;
        } else {
            request.setAttribute("error", "Current password is incorrect.");
            return "student_edit_profile_password"; 
        }
    }
}
