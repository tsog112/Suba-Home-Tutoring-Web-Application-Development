package BAGSH;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class become_tutor_pricing_process implements CommandHandler {

    @Override
    public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String tutorId = (String) request.getSession().getAttribute("id");

        dbconn db = new dbconn();
        Connection conn = db.getConn();

        try {
            saveAllData(conn, request, tutorId);
        } finally {
            conn.close();
        }

        response.sendRedirect("login.do"); // Redirect to the login page after successful registration
        return null;
    }

    private void saveAllData(Connection conn, HttpServletRequest request, String tutorId) throws SQLException {
        // Save user data
        String sqlInsertUser = "insert into users (user_id, full_name, phone_number, email, password, gender, birth_date, user_type, profile_picture) values (?, ?, ?, ?, ?, ?, ?, 'tutor', ?)";
        PreparedStatement psmtUser = conn.prepareStatement(sqlInsertUser);
        psmtUser.setString(1, tutorId);
        psmtUser.setString(2, (String) request.getSession().getAttribute("fullname"));
        psmtUser.setString(3, (String) request.getSession().getAttribute("phone"));
        psmtUser.setString(4, (String) request.getSession().getAttribute("email"));
        psmtUser.setString(5, (String) request.getSession().getAttribute("password"));
        psmtUser.setString(6, (String) request.getSession().getAttribute("gender"));
        psmtUser.setString(7, (String) request.getSession().getAttribute("birthdate"));

        // Set the profile picture as a Blob
        String photoPath = (String) request.getSession().getAttribute("photoPath");
        if (photoPath != null) {
            try {
                byte[] photoBytes = Files.readAllBytes(Paths.get(photoPath));
                psmtUser.setBytes(8, photoBytes);
            } catch (IOException e) {
                e.printStackTrace();
                psmtUser.setNull(8, java.sql.Types.BLOB);
            }
        } else {
            psmtUser.setNull(8, java.sql.Types.BLOB);
        }

        psmtUser.executeUpdate();

        // Save tutor data
        String sqlInsertTutor = "insert into tutors (tutor_id, introduction, lesson_experience, motivation, catchy_title, hourly_rate) values (?, ?, ?, ?, ?, ?)";
        PreparedStatement psmtTutor = conn.prepareStatement(sqlInsertTutor);
        psmtTutor.setString(1, tutorId);
        psmtTutor.setString(2, (String) request.getSession().getAttribute("introduction"));
        psmtTutor.setString(3, (String) request.getSession().getAttribute("experience"));
        psmtTutor.setString(4, (String) request.getSession().getAttribute("motivation"));
        psmtTutor.setString(5, (String) request.getSession().getAttribute("title"));
        psmtTutor.setInt(6, Integer.parseInt(request.getParameter("hourly_rate"))); // Save hourly rate
        psmtTutor.executeUpdate();

        // Save education data if exists
        Boolean noHigherEducation = (Boolean) request.getSession().getAttribute("noHigherEducation");
        if (noHigherEducation == null || !noHigherEducation) {
            String sqlInsertEducation = "insert into education (tutor_id, university, degree, specialization, start_year, end_year) values (?, ?, ?, ?, ?, ?)";
            PreparedStatement psmtEducation = conn.prepareStatement(sqlInsertEducation);
            psmtEducation.setString(1, tutorId);
            psmtEducation.setString(2, (String) request.getSession().getAttribute("university"));
            psmtEducation.setString(3, (String) request.getSession().getAttribute("degree"));
            psmtEducation.setString(4, (String) request.getSession().getAttribute("specialization"));
            String startYearStr = (String) request.getSession().getAttribute("startYear");
            String endYearStr = (String) request.getSession().getAttribute("endYear");
            if (startYearStr == null || startYearStr.isEmpty()) {
                psmtEducation.setNull(5, java.sql.Types.INTEGER);
            } else {
                psmtEducation.setInt(5, Integer.parseInt(startYearStr));
            }
            if (endYearStr == null || endYearStr.isEmpty()) {
                psmtEducation.setNull(6, java.sql.Types.INTEGER);
            } else {
                psmtEducation.setInt(6, Integer.parseInt(endYearStr));
            }
            psmtEducation.executeUpdate();
        }

        // Save subject data
        String subject = (String) request.getSession().getAttribute("subject");
        String sqlInsertTutorSubject = "insert into tutors_subjects (tutor_id, subject_id) values (?, ?)";
        PreparedStatement psmtTutorSubject = conn.prepareStatement(sqlInsertTutorSubject);
        psmtTutorSubject.setString(1, tutorId);
        psmtTutorSubject.setInt(2, Integer.parseInt(subject));
        psmtTutorSubject.executeUpdate();

        // Save schedule data
        @SuppressWarnings("unchecked")
        Map<String, List<String>> availability = (Map<String, List<String>>) request.getSession().getAttribute("availability");
        String sqlInsertSchedule = "insert into schedules (tutor_id, day_of_week, start_time, end_time) values (?, ?, ?, ?)";
        PreparedStatement psmtSchedule = conn.prepareStatement(sqlInsertSchedule);
        for (Map.Entry<String, List<String>> entry : availability.entrySet()) {
            String day = entry.getKey();
            for (String timeSlot : entry.getValue()) {
                String[] times = timeSlot.split("-");
                psmtSchedule.setString(1, tutorId);
                psmtSchedule.setString(2, day);
                psmtSchedule.setString(3, times[0]);
                psmtSchedule.setString(4, times[1]);
                psmtSchedule.addBatch();
            }
        }
        psmtSchedule.executeBatch();
    }
}