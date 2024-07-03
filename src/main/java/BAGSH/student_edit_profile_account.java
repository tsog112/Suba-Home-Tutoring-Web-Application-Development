package BAGSH;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class student_edit_profile_account implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		dbconn db = new dbconn();
		Connection conn = db.getConn();
		
		// Query to get user details
		String userSql = "SELECT * FROM users WHERE user_id=?";
		PreparedStatement userPsmt = conn.prepareStatement(userSql);
		userPsmt.setString(1, id);
		ResultSet userRs = userPsmt.executeQuery();
		
		if (userRs.next()) {
			request.setAttribute("fullname", userRs.getString("full_name"));
			request.setAttribute("id", userRs.getString("user_id"));
			request.setAttribute("phone", userRs.getString("phone_number"));
			request.setAttribute("email", userRs.getString("email"));
			request.setAttribute("password", userRs.getString("password"));
			request.setAttribute("gender", userRs.getString("gender"));
			request.setAttribute("birthdate", userRs.getString("birth_date"));
			request.setAttribute("usertype", userRs.getString("user_type"));
			request.setAttribute("profile_picture", userRs.getString("profile_picture"));
		}
		
		// Query to get selected subject for the tutor
		String selectedSubjectSql = "SELECT subject_id FROM tutors_subjects WHERE tutor_id = ?";
		PreparedStatement subjectPsmt = conn.prepareStatement(selectedSubjectSql);
		subjectPsmt.setString(1, id);
		ResultSet subjectRs = subjectPsmt.executeQuery();

		Integer selectedSubject = null;
		if (subjectRs.next()) {
			selectedSubject = subjectRs.getInt("subject_id");
		}
		session.setAttribute("selected_subject", selectedSubject);

		return "student_edit_profile_account";
	}
}
