package BAGSH;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class tutor_edit_profile_price implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		dbconn db = new dbconn();
		Connection conn = db.getConn();
		
		// Query to get user details
		String userSql = "SELECT hourly_rate FROM tutors WHERE tutor_id = ?";
		PreparedStatement userPsmt = conn.prepareStatement(userSql);
		userPsmt.setString(1, id);
		ResultSet userRs = userPsmt.executeQuery();
		
		if (userRs.next()) {
			request.setAttribute("hourly_rate",userRs.getInt("hourly_rate"));
		}
		
		
		
		

		return "tutor_edit_profile_price";
	}
}
