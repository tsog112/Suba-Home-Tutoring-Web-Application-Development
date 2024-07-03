package BAGSH;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class tutor_edit_profile_description_process implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");

        if (id == null) {
            request.setAttribute("error", "You need to log in to update your profile.");
            response.sendRedirect("login.do");
            return null;
        }

        String introduction = request.getParameter("introduction");
        String lesson_experience = request.getParameter("lesson_experience");
        String motivation = request.getParameter("motivation");
        String catchy_title = request.getParameter("catchy_title");

        dbconn db = new dbconn();
        Connection conn = db.getConn();

        String updateDescriptionSql = "update tutors set introduction = ?, lesson_experience = ?, motivation = ?, catchy_title = ? where tutor_id = ?";
        try {
            PreparedStatement psmt = conn.prepareStatement(updateDescriptionSql);
            psmt.setString(1, introduction);
            psmt.setString(2, lesson_experience);
            psmt.setString(3, motivation);
            psmt.setString(4, catchy_title);
            psmt.setString(5, id);

            int rowsUpdated = psmt.executeUpdate();
            if (rowsUpdated > 0) {
                session.setAttribute("message", "Profile description updated successfully.");
            } else {
                session.setAttribute("error", "Failed to update profile description.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("error", "An error occurred while updating your profile description.");
        }

        // Redirect to avoid resubmission of form on refresh
        response.sendRedirect("tutor_edit_profile_description.do");
        return null;
    }
}
