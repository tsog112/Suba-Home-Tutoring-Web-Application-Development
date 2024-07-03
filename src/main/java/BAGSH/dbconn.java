package BAGSH;

import java.sql.*;

public class dbconn {
	private Connection conn = null; //나중에 PreparedStatement pstmt = conn.PreparedStatement(SQL)을 사용할때 쓰기위해 conn저장할 변수 생성 
	
	
	public dbconn() { //생성자 
		String url = "jdbc:mysql://localhost:3306/test";
		String user = "root";
		String pwd = "rootpw";
		 try {
			Class.forName("com.mysql.cj.jdbc.Driver");	 //driver가 잘있으면(jar이 잘있으면)
		} catch (ClassNotFoundException e) { //driver가 없으면,
			e.printStackTrace();
		}
		 try {
			conn = DriverManager.getConnection(url,user,pwd);//driver가 있고 잘 접속이 됐으면 conn에 저장
			
		} catch (SQLException e) { //없으면 실행
			e.printStackTrace();
		}
	}
	public Connection getConn() { //getter선언.
		return conn;
	}
	
	public void dbclose() {
		 try {
			 if(conn!= null) {
				 conn.close();
			 }
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
