package BAGSH;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class signup_process implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            return "signup"; 
        }

        dbconn db = new dbconn();
        Connection conn = db.getConn();
        String sql = "select email from users where email=?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, email);
        ResultSet rs = psmt.executeQuery();

        if (rs.next()) {
            request.setAttribute("duplicate", "-1");
            return "signup"; 
        } else {
            String fullName = request.getParameter("fullname");
            String gender = request.getParameter("gender");
            String birthdate = request.getParameter("birthdate");
            String phoneNumber = request.getParameter("phone");

            String sqlInsert = "insert into users (user_id, full_name, phone_number, email, password, gender, birth_date, user_type) values (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement insertStmt = conn.prepareStatement(sqlInsert)) {
                insertStmt.setString(1, request.getParameter("id"));
                insertStmt.setString(2, fullName);
                insertStmt.setString(3, phoneNumber);
                insertStmt.setString(4, email);
                insertStmt.setString(5, password);
                insertStmt.setString(6, gender);
                insertStmt.setString(7, birthdate);
                insertStmt.setString(8, "student");

                int affectedRows = insertStmt.executeUpdate();
                if (affectedRows > 0) {
                    return "login"; 
                } else {
                    request.setAttribute("error", "Signup failed");
                    return "signup"; 
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error occurred");
                return "error"; 
            }
        }
    }
}
