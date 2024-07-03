package BAGSH;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class tutor_edit_profile_education_process implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");

        if (id == null) {
            request.setAttribute("error", "You need to log in to update your education details.");
            response.sendRedirect("login.do");
            return null;
        }

        boolean noHigherEducation = "on".equals(request.getParameter("no_higher_education"));

        dbconn db = new dbconn();
        Connection conn = db.getConn();

        if (noHigherEducation) {
            // Remove existing education records
            String deleteEducationSql = "delete from education where tutor_id = ?";
            try {
                PreparedStatement psmt = conn.prepareStatement(deleteEducationSql);
                psmt.setString(1, id);
                psmt.executeUpdate();
                session.setAttribute("message", "Education details updated successfully.");
            } catch (SQLException e) {
                e.printStackTrace();
                session.setAttribute("error", "An error occurred while updating your education.");
            }
        } else {
            // Remove existing education records
            String deleteEducationSql = "delete from education where tutor_id = ?";
            try {
                PreparedStatement psmt = conn.prepareStatement(deleteEducationSql);
                psmt.setString(1, id);
                psmt.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
                session.setAttribute("error", "An error occurred while updating your education.");
            }

            // Add new education records
            String[] universities = request.getParameterValues("university");
            String[] degrees = request.getParameterValues("degree");
            String[] specializations = request.getParameterValues("specialization");
            String[] startYears = request.getParameterValues("start_year");
            String[] endYears = request.getParameterValues("end_year");

            String insertEducationSql = "insert into education (tutor_id, university, degree, specialization, start_year, end_year) values (?, ?, ?, ?, ?, ?)";
            try {
                for (int i = 0; i < universities.length; i++) {
                    if (universities[i].isEmpty() && degrees[i].isEmpty() && specializations[i].isEmpty() && startYears[i].isEmpty() && endYears[i].isEmpty()) {
                        continue;
                    }
                    PreparedStatement psmt = conn.prepareStatement(insertEducationSql);
                    psmt.setString(1, id);
                    psmt.setString(2, universities[i]);
                    psmt.setString(3, degrees[i]);
                    psmt.setString(4, specializations[i]);
                    psmt.setString(5, startYears[i]);
                    psmt.setString(6, endYears[i]);
                    psmt.executeUpdate();
                }
                session.setAttribute("message", "Education details updated successfully.");
            } catch (SQLException e) {
                e.printStackTrace();
                session.setAttribute("error", "An error occurred while updating your education.");
            }
        }

        // Redirect to avoid resubmission of form on refresh
        response.sendRedirect("tutor_edit_profile_description.do");
        return null;
    }
}
