package BAGSH;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class delete implements CommandHandler {

	@Override
	public String porcess(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		
		String user_id = (String)session.getAttribute("id");
		
		dbconn db = new dbconn();
		Connection conn = db.getConn();
		
		
		String sql = "select user_id from Users where user_id =?";
		PreparedStatement psmt = conn.prepareStatement(sql);
		psmt.setString(1, user_id);
		
		ResultSet rs = psmt.executeQuery(); //table hadgalj ogno(select)
		
		if(rs.next()) {
			try {
				sql="delete from Users where user_id=?";
				psmt=conn.prepareStatement(sql);
				
				psmt.setString(1, user_id);
				
				psmt.executeUpdate();
				
			}
			catch(Exception e) {
				
			}
		}
		
		session.removeAttribute("id");
		return "index";
	}

}
