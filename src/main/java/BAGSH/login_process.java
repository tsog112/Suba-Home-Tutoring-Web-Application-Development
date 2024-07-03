package BAGSH;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Base64;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class login_process implements CommandHandler {

    @Override
    public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String user_id = request.getParameter("id");
        String password = request.getParameter("password");

        dbconn db = new dbconn();
        Connection conn = db.getConn();

        String sql = "select user_id, password, profile_picture, full_name, phone_number, email, birth_date, user_type from users where user_id = ? and password = ?";
        PreparedStatement psmt = conn.prepareStatement(sql);
        psmt.setString(1, user_id);
        psmt.setString(2, password);

        ResultSet rs = psmt.executeQuery();

        if (rs.next()) {
            HttpSession session = request.getSession(true);
            byte[] profilePictureBytes = rs.getBytes("profile_picture");
            String profilePictureBase64 = null;

            if (profilePictureBytes != null) {
                profilePictureBase64 = Base64.getEncoder().encodeToString(profilePictureBytes);
            }

            session.setAttribute("id", user_id);
            session.setAttribute("profile_picture", profilePictureBase64);
            session.setAttribute("fullname", rs.getString("full_name"));
            session.setAttribute("phone", rs.getString("phone_number"));
            session.setAttribute("email", rs.getString("email"));
            session.setAttribute("birthdate", rs.getString("birth_date"));
            session.setAttribute("usertype", rs.getString("user_type"));

            if ("tutor".equals(rs.getString("user_type"))) {
                // Fetch tutor's subjects
                String subjectsSql = "select s.name from subjects s join tutors_subjects ts on s.subject_id = ts.subject_id where ts.tutor_id = ?";
                PreparedStatement subjectsPsmt = conn.prepareStatement(subjectsSql);
                subjectsPsmt.setString(1, user_id);
                ResultSet subjectsRs = subjectsPsmt.executeQuery();
                StringBuilder subjects = new StringBuilder();
                while (subjectsRs.next()) {
                    if (subjects.length() > 0) subjects.append(", ");
                    subjects.append(subjectsRs.getString("name"));
                }
                session.setAttribute("subjects", subjects.toString());
            }

            return "index";
        } else {
            request.setAttribute("error", "-1");
            return "login";
        }
    }
}
