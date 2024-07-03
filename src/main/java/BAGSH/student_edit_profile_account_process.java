package BAGSH;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/student_edit_profile_account_process.do")
public class student_edit_profile_account_process extends HttpServlet implements CommandHandler {

	private static final long serialVersionUID = 1L;
	private static final String TEMP_UPLOAD_DIRECTORY = System.getProperty("java.io.tmpdir");
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			porcess(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
        String id = (String) session.getAttribute("id");

        JSONObject jsonResponse = new JSONObject();

        if (id == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "You need to log in to update your profile.");
            response.getWriter().write(jsonResponse.toString());
            return null;
        }

        // Create a temporary directory if it doesn't exist
        File tempDir = new File(TEMP_UPLOAD_DIRECTORY);
        if (!tempDir.exists()) {
            tempDir.mkdirs();
        }

        MultipartRequest multi = new MultipartRequest(request, TEMP_UPLOAD_DIRECTORY, 10 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());

        dbconn db = new dbconn();
        Connection conn = db.getConn();

        String fullname = multi.getParameter("fullname");
        String phone = multi.getParameter("phone");
        String email = multi.getParameter("email");
        String birthdate = multi.getParameter("birthdate");
        String subject = multi.getParameter("subject");

        if (fullname == null || fullname.isEmpty() || birthdate == null || birthdate.isEmpty()) {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Full name and birthdate cannot be empty.");
            response.getWriter().write(jsonResponse.toString());
            return null;
        }

        boolean profilePictureUpdated = false;
        File profilePictureFile = multi.getFile("profilePicture");
        if (profilePictureFile != null) {
            try (InputStream inputStream = Files.newInputStream(profilePictureFile.toPath())) {
                byte[] imageBytes = toByteArray(inputStream);

                String updateProfilePictureSql = "update users set profile_picture = ? where user_id = ?";
                try {
                    PreparedStatement psmt = conn.prepareStatement(updateProfilePictureSql);
                    psmt.setBlob(1, new javax.sql.rowset.serial.SerialBlob(imageBytes));
                    psmt.setString(2, id);

                    int rowsUpdated = psmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        String profilePicBase64 = Base64.getEncoder().encodeToString(imageBytes);
                        session.setAttribute("profile_picture", profilePicBase64);

                        jsonResponse.put("profilePicture", profilePicBase64);
                        profilePictureUpdated = true;
                    } else {
                        jsonResponse.put("profilePictureError", "Failed to update profile picture.");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    jsonResponse.put("profilePictureError", "An error occurred while updating your profile picture: " + e.getMessage());
                } finally {
                    // Clean up the temporary file
                    Files.deleteIfExists(profilePictureFile.toPath());
                }
            }
        }

        String updateProfileSql = "update users set full_name = ?, phone_number = ?, email = ?, birth_date = ? where user_id = ?";
        try {
            PreparedStatement psmt = conn.prepareStatement(updateProfileSql);
            psmt.setString(1, fullname);
            psmt.setString(2, phone);
            psmt.setString(3, email);
            psmt.setString(4, birthdate);
            psmt.setString(5, id);

            int rowsUpdated = psmt.executeUpdate();
            if (rowsUpdated > 0) {
                jsonResponse.put("message", "Profile updated successfully.");
            } else {
                jsonResponse.put("message", "Failed to update profile.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            jsonResponse.put("message", "An error occurred while updating your profile: " + e.getMessage());
        }

        if ("tutor".equals(session.getAttribute("usertype"))) {
            if (subject != null && !subject.isEmpty()) {
                // Remove existing subjects for this tutor
                String deleteSubjectsSql = "delete from tutors_subjects where tutor_id = ?";
                try {
                    PreparedStatement psmt = conn.prepareStatement(deleteSubjectsSql);
                    psmt.setString(1, id);
                    psmt.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                }

                // Insert new subject for this tutor
                String insertSubjectSql = "insert into tutors_subjects (tutor_id, subject_id) values (?, ?)";
                try {
                    PreparedStatement psmt = conn.prepareStatement(insertSubjectSql);
                    psmt.setString(1, id);
                    psmt.setInt(2, Integer.parseInt(subject)); // Assuming subject ID is passed as a parameter
                    psmt.executeUpdate();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // Set attributes in the session
        session.setAttribute("fullname", fullname);
        session.setAttribute("phone", phone);
        session.setAttribute("email", email);
        session.setAttribute("birthdate", birthdate);
        session.setAttribute("id", id);

        jsonResponse.put("success", profilePictureUpdated);

        // Write the JSON response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonResponse.toString());

        return null;
    }

    public List<subject> getAllSubjects() throws SQLException {
        List<subject> subjects = new ArrayList<>();
        dbconn db = new dbconn();
        Connection conn = db.getConn();
        String query = "select subject_id, name from subjects";
        PreparedStatement psmt = conn.prepareStatement(query);
        ResultSet rs = psmt.executeQuery();
        while (rs.next()) {
            subject subject = new subject();
            subject.setId(rs.getInt("subject_id"));
            subject.setName(rs.getString("name"));
            subjects.add(subject);
        }
        return subjects;
    }

    private byte[] toByteArray(InputStream input) throws IOException {
        ByteArrayOutputStream output = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int n;
        while (-1 != (n = input.read(buffer))) {
            output.write(buffer, 0, n);
        }
        return output.toByteArray();
    }
}
