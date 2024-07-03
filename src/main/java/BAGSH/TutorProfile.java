package BAGSH;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import org.json.JSONArray;
import java.sql.*;
import java.util.Base64;

public class TutorProfile {
    private String tutorId;
    private dbconn dbConnection;

    public TutorProfile(String tutorId) {
        this.tutorId = tutorId;
        this.dbConnection = new dbconn();
    }

    public JSONObject getTutorDetails() throws SQLException {
        JSONObject tutorDetails = new JSONObject();
        Connection conn = dbConnection.getConn();
        String query = "SELECT t.*, u.full_name, u.phone_number, u.email, u.gender, u.birth_date, u.profile_picture, " +
                       "(SELECT AVG(r.rating) FROM ratings r WHERE r.tutor_id = t.tutor_id) AS average_rating, " +
                       "(SELECT COUNT(r.rating) FROM ratings r WHERE r.tutor_id = t.tutor_id) AS rating_count, " +
                       "(SELECT JSON_OBJECT('5', SUM(CASE WHEN r.rating = 5 THEN 1 ELSE 0 END), " +
                       "'4', SUM(CASE WHEN r.rating = 4 THEN 1 ELSE 0 END), " +
                       "'3', SUM(CASE WHEN r.rating = 3 THEN 1 ELSE 0 END), " +
                       "'2', SUM(CASE WHEN r.rating = 2 THEN 1 ELSE 0 END), " +
                       "'1', SUM(CASE WHEN r.rating = 1 THEN 1 ELSE 0 END)) " +
                       "FROM ratings r WHERE r.tutor_id = t.tutor_id) AS rating_summary " +
                       "FROM tutors t JOIN users u ON t.tutor_id = u.user_id WHERE t.tutor_id = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, tutorId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                tutorDetails.put("tutorId", rs.getString("tutor_id"));
                tutorDetails.put("introduction", rs.getString("introduction"));
                tutorDetails.put("lessonExperience", rs.getString("lesson_experience"));
                tutorDetails.put("motivation", rs.getString("motivation"));
                tutorDetails.put("catchyTitle", rs.getString("catchy_title"));
                tutorDetails.put("hourlyRate", rs.getInt("hourly_rate"));
                tutorDetails.put("commission", rs.getInt("commission"));
                tutorDetails.put("noHigherEducation", rs.getInt("no_higher_education"));
                tutorDetails.put("fullName", rs.getString("full_name"));
                tutorDetails.put("phoneNumber", rs.getString("phone_number"));
                tutorDetails.put("email", rs.getString("email"));
                tutorDetails.put("gender", rs.getString("gender"));
                tutorDetails.put("birthDate", rs.getDate("birth_date"));
                tutorDetails.put("averageRating", rs.getDouble("average_rating"));
                tutorDetails.put("reviewCount", rs.getInt("rating_count"));
                tutorDetails.put("ratingSummary", new JSONObject(rs.getString("rating_summary")));

                // Get the profile picture as a base64 string
                Blob profilePicBlob = rs.getBlob("profile_picture");
                if (profilePicBlob != null) {
                    byte[] profilePicBytes = profilePicBlob.getBytes(1, (int) profilePicBlob.length());
                    String profilePicBase64 = Base64.getEncoder().encodeToString(profilePicBytes);
                    tutorDetails.put("profilePicture", profilePicBase64);
                }
            } else {
                System.out.println("No tutor found with ID: " + tutorId);
            }

            tutorDetails.put("schedules", getSchedules(conn));
            tutorDetails.put("reviews", getReviews(conn));
            tutorDetails.put("education", getEducation(conn));
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbConnection.dbclose();
        }

        return tutorDetails;
    }

    private JSONArray getSchedules(Connection conn) throws SQLException {
        JSONArray schedules = new JSONArray();
        String query = "SELECT * FROM schedules WHERE tutor_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, tutorId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                JSONObject schedule = new JSONObject();
                schedule.put("dayOfWeek", rs.getString("day_of_week"));
                schedule.put("startTime", rs.getString("start_time"));
                schedule.put("endTime", rs.getString("end_time"));
                schedules.put(schedule);
            }
        }
        return schedules;
    }

    private JSONArray getReviews(Connection conn) throws SQLException {
        JSONArray reviews = new JSONArray();
        String query = "SELECT * FROM reviews WHERE tutor_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, tutorId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                JSONObject review = new JSONObject();
                review.put("studentId", rs.getString("student_id"));
                review.put("rating", rs.getInt("rating"));
                review.put("comment", rs.getString("comment"));
                review.put("createdAt", rs.getTimestamp("created_at").getTime()); // Store as long
                reviews.put(review);
            }
        }
        return reviews;
    }

    private JSONArray getEducation(Connection conn) throws SQLException {
        JSONArray education = new JSONArray();
        String query = "SELECT * FROM education WHERE tutor_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, tutorId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                JSONObject edu = new JSONObject();
                edu.put("university", rs.getString("university"));
                edu.put("degree", rs.getString("degree"));
                edu.put("specialization", rs.getString("specialization"));
                edu.put("startYear", rs.getInt("start_year"));
                edu.put("endYear", rs.getInt("end_year"));
                education.put(edu);
            }
        }
        return education;
    }
}
