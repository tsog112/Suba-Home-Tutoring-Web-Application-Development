package BAGSH;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class tutor_edit_profile_price_process implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");

        // Ensure the user is logged in
        if (id == null) {
            request.setAttribute("error", "You need to log in to update your pricing.");
            return "login"; // Redirect to login page if user is not logged in
        }

        // Fetch the hourly rate from the database
        Integer hourlyRate = null;
        try {
            dbconn db = new dbconn();
            Connection conn = db.getConn();

            String fetchSql = "SELECT hourly_rate FROM tutors WHERE tutor_id = ?";
            PreparedStatement fetchPsmt = conn.prepareStatement(fetchSql);
            fetchPsmt.setString(1, id);

            ResultSet rs = fetchPsmt.executeQuery();
            if (rs.next()) {
                hourlyRate = rs.getInt("hourly_rate");
            }

            request.setAttribute("hourlyRate", hourlyRate);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while fetching your hourly rate.");
            return "tutor_edit_profile_price";
        }

        // Handle form submission
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            // Parse the hourly rate from the request
            try {
                hourlyRate = Integer.parseInt(request.getParameter("hourly_rate"));
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid hourly rate value.");
                return "tutor_edit_profile_price";
            }

            // Update the hourly rate in the tutors table
            try {
                dbconn db = new dbconn();
                Connection conn = db.getConn();

                String updateSql = "UPDATE tutors SET hourly_rate = ? WHERE tutor_id = ?";
                PreparedStatement updatePsmt = conn.prepareStatement(updateSql);
                updatePsmt.setInt(1, hourlyRate);
                updatePsmt.setString(2, id);
                updatePsmt.executeUpdate();

                request.setAttribute("message", "Price successfully updated.");
                session.setAttribute("hourly_rate", hourlyRate);

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "An error occurred while updating your pricing.");
                return "tutor_edit_profile_price";
            }
        }

        return "tutor_edit_profile_price";
    }
}