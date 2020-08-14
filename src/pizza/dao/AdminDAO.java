package pizza.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import pizza.admin.vo.AdminVO;

public class AdminDAO {

	private static AdminDAO admin_dao;
	
	private AdminDAO() {
		
	} 
	
	public static AdminDAO getInstance() {
		if ( admin_dao == null) {
			admin_dao = new AdminDAO();
		} // end if
		return admin_dao;
	} 
	
	private Connection getConn() throws SQLException{
		Connection con = null;
		
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/pizza_dbcp");

			con = ds.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
		return con;
	} // getConn
	
	public boolean selectAdminId(AdminVO aVO) throws SQLException{
		boolean flag = false;
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	      
	    try {
	       con = getConn();
	       
	       String selectAdminId = "   select admin_id, admin_pass from admin   ";
	       selectAdminId += "   where admin_id=? and admin_pass=?   ";
	       pstmt = con.prepareStatement(selectAdminId);
	         
	       pstmt.setString(1, aVO.getAdmin_id());
	       pstmt.setString(2, aVO.getAdmin_pass());
	         
	       rs = pstmt.executeQuery();
	         
	       if (rs.next()) { //일치하는 값이 있으면
	          flag = true; 
	       } // end if
	    } finally {
	       if (rs != null) {rs.close();}
	       if (pstmt != null) {pstmt.close();}
	       if (con != null) {con.close();}
	    } // end finally
	      
	    return flag; //로그인이 되면 트루를 리턴
	} // selectAdminId
	
} // class
