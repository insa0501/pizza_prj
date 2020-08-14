package pizza.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import pizza.user.vo.LoginVO;

public class LoginDAO {

	private static LoginDAO login__dao;

	// 2020-08-08 김홍석 - 기본생성자 추가 (private)
	
	private LoginDAO() {
		
	}
	
	public static LoginDAO getInstance() {
		if (login__dao == null) {
			login__dao = new LoginDAO();
		} // end if
		return login__dao;
	}

	/**
	 * JNDI를 사용하여 DBCP에서 DB연결객체(java.sql.DataSource)를 얻어와
	 * DBConnection(java.sql.Connection) 받아 반환하는 일
	 * 
	 * @return
	 */
	private Connection getConn() throws SQLException {
		Connection con = null;
		try {
			// 1. JNDI 사용 객체 생성
			Context ctx = new InitialContext();
			// 2. DBCP찾고 DB연결객체 얻기
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/pizza_dbcp");
			// 3. DB연결객체에서 Connection 얻기
			con = ds.getConnection();
		} catch (NamingException ne) {
			ne.printStackTrace();
		} // end catch

		return con;
	} // getConn()

	/**
	 * 제조사 목록 조회
	 * 
	 * @return
	 * @throws SQLException
	 */
	public String selectLoginId(LoginVO lVO) throws SQLException {
		//String LoginId = "";
				String LoginName ="";
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				try {
					// 3. Connection 얻기
					con = getConn();
					// 4. 쿼리문 생성객체 얻기
					String selectName = "select user_name from member where user_id=? and user_pass=?";
					pstmt = con.prepareStatement(selectName);
					
					//바인드 변수의 값 넣기
					pstmt.setString(1, lVO.getUser_id());
					pstmt.setString(2, lVO.getUser_pass());
					
					// 5. 쿼리 수행 후 결과 얻기
					rs = pstmt.executeQuery();
					
					if (rs.next()) {
						LoginName = rs.getString("user_name");
					} // end if

					// 6. 연결 끊기
				} finally {
					if (rs != null) {
						rs.close();
					}
					if (pstmt != null) {
						pstmt.close();
					}
					if (con != null) {
						con.close();
					}
				} // end finally

				return LoginName;
			} // selectName
	
} // class
