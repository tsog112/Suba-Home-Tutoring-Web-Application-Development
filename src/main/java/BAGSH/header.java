package BAGSH;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

public class header implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String query = request.getParameter("q");
        if (query == null || query.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            return null;
        }

        dbconn db = new dbconn();
        try (Connection conn = db.getConn()) {
            String sql = "SELECT full_name FROM users WHERE full_name LIKE ?";
            PreparedStatement psmt = conn.prepareStatement(sql);
            psmt.setString(1, "%" + query + "%");
            ResultSet rs = psmt.executeQuery();

            List<User> users = new ArrayList<>();
            while (rs.next()) {
                User user = new User();
                user.setFullName(rs.getString("full_name"));
                users.add(user);
            }

            String json = new Gson().toJson(users);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
        return null;
    }

    class User {
        private String full_name;

        public String getFullName() {
            return full_name;
        }

        public void setFullName(String fullName) {
            this.full_name = fullName;
        }
    }
}
