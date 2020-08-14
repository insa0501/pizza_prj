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

	// 2020-08-08 ��ȫ�� - �⺻������ �߰� (private)
	
	private LoginDAO() {
		
	}
	
	public static LoginDAO getInstance() {
		if (login__dao == null) {
			login__dao = new LoginDAO();
		} // end if
		return login__dao;
	}

	/**
	 * JNDI�� ����Ͽ� DBCP���� DB���ᰴü(java.sql.DataSource)�� ����
	 * DBConnection(java.sql.Connection) �޾� ��ȯ�ϴ� ��
	 * 
	 * @return
	 */
	private Connection getConn() throws SQLException {
		Connection con = null;
		try {
			// 1. JNDI ��� ��ü ����
			Context ctx = new InitialContext();
			// 2. DBCPã�� DB���ᰴü ���
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/pizza_dbcp");
			// 3. DB���ᰴü���� Connection ���
			con = ds.getConnection();
		} catch (NamingException ne) {
			ne.printStackTrace();
		} // end catch

		return con;
	} // getConn()

	/**
	 * ������ ��� ��ȸ
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
					// 3. Connection ���
					con = getConn();
					// 4. ������ ������ü ���
					String selectName = "select user_name from member where user_id=? and user_pass=?";
					pstmt = con.prepareStatement(selectName);
					
					//���ε� ������ �� �ֱ�
					pstmt.setString(1, lVO.getUser_id());
					pstmt.setString(2, lVO.getUser_pass());
					
					// 5. ���� ���� �� ��� ���
					rs = pstmt.executeQuery();
					
					if (rs.next()) {
						LoginName = rs.getString("user_name");
					} // end if

					// 6. ���� ����
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
