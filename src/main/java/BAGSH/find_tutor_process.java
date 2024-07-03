package BAGSH;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class find_tutor_process implements CommandHandler {
	private static final Logger LOGGER = Logger.getLogger(find_tutor_process.class.getName());
	
	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = new dbconn().getConn();

            // Parse the request body
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = request.getReader().readLine()) != null) {
                sb.append(line);
            }
            JSONObject filters = new JSONObject(sb.toString());

            boolean fetchAll = filters.optBoolean("fetchAll", false);
            String subject = filters.optString("subject", "all");
            int minPrice = filters.optInt("minPrice", 1000);
            int maxPrice = filters.optInt("maxPrice", 50000);
            JSONObject availability = filters.optJSONObject("availability");
            String gender = filters.optString("gender", "all");
            String age = filters.optString("age", "all");
            String specialty = filters.optString("specialty", "all");
            String sortBy = filters.optString("sortBy", "none");

            StringBuilder sql = new StringBuilder("SELECT u.user_id, u.full_name, u.profile_picture, t.introduction, t.lesson_experience, t.hourly_rate, t.catchy_title, " +
                    "e.university, e.degree, e.specialization, e.start_year, e.end_year, " +
                    "(SELECT AVG(r.rating) FROM ratings r WHERE r.tutor_id = t.tutor_id) AS average_rating, " +
                    "(SELECT COUNT(r.rating) FROM ratings r WHERE r.tutor_id = t.tutor_id) AS rating_count " +
                    "FROM tutors t " +
                    "JOIN users u ON t.tutor_id = u.user_id " +
                    "LEFT JOIN education e ON t.tutor_id = e.tutor_id " +
                    "LEFT JOIN schedules s ON t.tutor_id = s.tutor_id ");

            List<String> conditions = new ArrayList<>();
            List<Object> parameters = new ArrayList<>();

            if (!fetchAll) {
                if (!"all".equals(subject)) {
                    conditions.add("t.tutor_id IN (SELECT tutor_id FROM tutors_subjects WHERE subject_id = (SELECT subject_id FROM subjects WHERE name COLLATE utf8mb4_unicode_ci = ?))");
                    parameters.add(subject);
                }

                if (minPrice > 1000 || maxPrice < 50000) {
                    conditions.add("t.hourly_rate BETWEEN ? AND ?");
                    parameters.add(minPrice);
                    parameters.add(maxPrice);
                }

                if (!"all".equals(gender)) {
                    conditions.add("u.gender COLLATE utf8mb4_unicode_ci = ?");
                    parameters.add(gender);
                }

                if (!"all".equals(age)) {
                    switch (age) {
                        case "20-30":
                            conditions.add("YEAR(u.birth_date) BETWEEN ? AND ?");
                            parameters.add(1994);
                            parameters.add(2004);
                            break;
                        case "30-40":
                            conditions.add("YEAR(u.birth_date) BETWEEN ? AND ?");
                            parameters.add(1984);
                            parameters.add(1994);
                            break;
                        case "40-50":
                            conditions.add("YEAR(u.birth_date) BETWEEN ? AND ?");
                            parameters.add(1974);
                            parameters.add(1984);
                            break;
                    }
                }

                if (availability != null) {
                    JSONArray days = availability.optJSONArray("days");
                    JSONArray times = availability.optJSONArray("times");
                    if (days != null && days.length() > 0 && times != null && times.length() > 0) {
                        List<String> availabilityConditions = new ArrayList<>();
                        for (int i = 0; i < days.length(); i++) {
                            for (int j = 0; j < times.length(); j++) {
                                availabilityConditions.add("(s.day_of_week = ? AND s.start_time <= ? AND s.end_time >= ?)");
                                parameters.add(days.getString(i));
                                String[] timeRange = times.getString(j).split("-");
                                parameters.add(timeRange[0] + ":00:00");
                                parameters.add(timeRange[1] + ":00:00");
                            }
                        }
                        conditions.add("(" + String.join(" OR ", availabilityConditions) + ")");
                    }
                }

                if (!conditions.isEmpty()) {
                    sql.append("WHERE ");
                    sql.append(String.join(" AND ", conditions));
                }

                switch (sortBy) {
                    case "price-low-high":
                        sql.append(" ORDER BY t.hourly_rate ASC");
                        break;
                    case "price-high-low":
                        sql.append(" ORDER BY t.hourly_rate DESC");
                        break;
                    case "rating":
                        sql.append(" ORDER BY average_rating DESC");
                        break;
                }
            }

            pstmt = conn.prepareStatement(sql.toString(), ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            for (int i = 0; i < parameters.size(); i++) {
                pstmt.setObject(i + 1, parameters.get(i));
            }

            LOGGER.log(Level.INFO, "Executing SQL: {0}", pstmt.toString());

            rs = pstmt.executeQuery();
            JSONArray tutorArray = new JSONArray();
            while (rs.next()) {
                JSONObject tutor = new JSONObject();
                tutor.put("id", rs.getString("user_id"));
                tutor.put("name", rs.getString("full_name"));

                byte[] imageBytes = rs.getBytes("profile_picture");
                if (imageBytes != null) {
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    String imageSrc = "data:image/jpeg;base64," + base64Image;
                    tutor.put("image", imageSrc);
                } else {
                    tutor.put("image", "https://via.placeholder.com/300");
                }

                tutor.put("introduction", rs.getString("introduction"));
                tutor.put("experience", rs.getString("lesson_experience"));
                tutor.put("price", rs.getDouble("hourly_rate"));
                tutor.put("title", rs.getString("catchy_title"));
                tutor.put("average_rating", rs.getDouble("average_rating"));
                tutor.put("rating_count", rs.getInt("rating_count"));

                JSONArray educationArray = new JSONArray();
                do {
                    if (rs.getString("university") != null) {
                        JSONObject education = new JSONObject();
                        education.put("university", rs.getString("university"));
                        education.put("degree", rs.getString("degree"));
                        education.put("specialization", rs.getString("specialization"));
                        education.put("start_year", rs.getString("start_year"));
                        education.put("end_year", rs.getString("end_year"));
                        educationArray.put(education);
                    }
                } while (rs.next() && rs.getString("user_id").equals(tutor.getString("id")));

                rs.previous(); // Move one step back to continue outer loop correctly

                tutor.put("education", educationArray);

                tutorArray.put(tutor);
            }

            PrintWriter out = response.getWriter();
            out.print(tutorArray.toString());
            out.flush();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return null;
    }
}