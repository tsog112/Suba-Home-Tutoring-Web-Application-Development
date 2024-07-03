package BAGSH;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class delete_process implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");

        if (id == null) {
            request.setAttribute("error", "You need to log in to delete your account.");
            response.sendRedirect("login.do"); 
            return null;
        }

        dbconn db = new dbconn();
        Connection conn = db.getConn();

        String deleteAccountSql = "delete from users where user_id = ?";
        try {
            PreparedStatement psmt = conn.prepareStatement(deleteAccountSql);
            psmt.setString(1, id);

            int rowsDeleted = psmt.executeUpdate();
            if (rowsDeleted > 0) {
                session.invalidate(); 
                response.sendRedirect("index.do"); 
                return null;
            } else {
                request.setAttribute("error", "Failed to delete account.");
                response.sendRedirect("student_edit_profile_account.do"); 
                return null;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while deleting your account.");
            response.sendRedirect("student_edit_profile_account.do"); 
            return null;
        }
    }
}
