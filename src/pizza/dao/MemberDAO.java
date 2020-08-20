package pizza.dao;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import kr.co.sist.util.cipher.DataEncrypt;
import pizza.admin.vo.MemberDetailVO;
import pizza.admin.vo.MemberVO;
import pizza.admin.vo.ResignMemberVO;
import pizza.admin.vo.SelectMemberVO;
import pizza.user.vo.InsertMemberVO;
import pizza.user.vo.OrderMenuVO;
import pizza.user.vo.SelectIdVO;
import pizza.user.vo.SelectOrderListVO;
import pizza.user.vo.SelectPassVO;
import pizza.user.vo.UpdatePassVO;
import pizza.user.vo.UpdateResignVO;
import pizza.user.vo.UpdateUserInfoVO;
import pizza.user.vo.UserInfoVO;
import pizza.user.vo.UserOrderVO;
import pizza.user.vo.selectMyDataVO;

public class MemberDAO {

private static MemberDAO member_dao;
	
	private MemberDAO() {
		
	} 
	
	public static MemberDAO getInstance() {
		if ( member_dao == null) {
			member_dao = new MemberDAO();
		} // end if
		return member_dao;
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
	
	public void insertMember(InsertMemberVO imVO) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConn();
			
			StringBuilder sb = new StringBuilder();
			sb
			.append("	insert into member (user_id, user_pass, user_name, user_phone, user_zipcode, user_addr1, user_addr2, user_ip )	")
			.append("	values ( ?, ?, ?, ?, ?, ?, ?, ? )	");
			
			pstmt = con.prepareStatement(sb.toString());
			
			//암호화
			String pass = "";
			try {
				DataEncrypt de = new DataEncrypt("0123456789abcdef");
				pass = DataEncrypt.messageDigest("MD5", imVO.getUser_pass());
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}//end catch
			
			pstmt.setString(1, imVO.getUser_id());
			pstmt.setString(2, pass);
			pstmt.setString(3, imVO.getUser_name());
			pstmt.setString(4, imVO.getUser_phone());
			pstmt.setString(5, imVO.getUser_zipcode());
			pstmt.setString(6, imVO.getUser_addr1());
			pstmt.setString(7, imVO.getUser_addr2());
			pstmt.setString(8, imVO.getUser_ip());
			
			pstmt.execute();
		} finally {
			if( pstmt != null ) { pstmt.close(); }//end if
			if( con != null ) { con.close(); }//end if
		}
	} // insertMember()
	
	public boolean selectDupId(String user_id) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boolean result = false;
		try {
			con = getConn();
			pstmt = con.prepareStatement(" select user_id from member where user_id = ? ");
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			result = rs.next();
		} finally {
			if( rs != null ) { rs.close(); }// end if
			if( pstmt != null ) { pstmt.close(); }// end if
			if( con != null ) { con.close(); }// end if
		}// end finally
		
		
		return result;
	} // selectDupId
	
	/**
	 * @param siVO
	 * @return
	 * @throws SQLException
	 */
	public String selectId(SelectIdVO siVO) throws SQLException {
		String id = "";
		
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			con=getConn();
			
			String selectId="select user_id from member where user_name=? and user_phone=?";
			pstmt=con.prepareStatement(selectId);
			
			pstmt.setString(1, siVO.getUser_name());
			pstmt.setString(2, siVO.getUser_phone());
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				id=rs.getString("user_id");
			}//end if
		}finally {
			if(rs!=null) { rs.close(); }//end if
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end finally
		
		return id;
	} // selectId()
	
	/**
	 * @param soVO
	 * @return
	 * @throws SQLException
	 */
	public boolean selectPass(SelectPassVO spVO)throws SQLException{
		boolean selectPassFlag = false;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con=getConn();
			
			String selectPass="select user_pass from member where user_id=? and user_name=? and user_phone=?";
			pstmt=con.prepareStatement(selectPass);
			
			pstmt.setString(1, spVO.getUser_id());
			pstmt.setString(2, spVO.getUser_name());
			pstmt.setString(3, spVO.getUser_phone());
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				
				selectPassFlag = true;
	 
			}//end if
		}finally {
			if(rs!=null) { rs.close(); }//end if
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end finally
		
		return selectPassFlag;
	} // selectPass()
	
	/**
	 * @param upVO
	 * @return
	 * @throws SQLException
	 */
	public int updatePass(UpdatePassVO upVO)throws SQLException {
		int updatePassFlag = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
	 
		try {
			con=getConn();
			
			String updatePass="update member set user_pass = ? where user_id = ?";
			//update member set user_pass='0000' where user_id='grace';
			pstmt=con.prepareStatement(updatePass);
			
			//암호화
			String pass = "";
			try {
				DataEncrypt de = new DataEncrypt("0123456789abcdef");
				pass = DataEncrypt.messageDigest("MD5", upVO.getUser_pass());
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}//end catch
			
			pstmt.setString(1, pass);
			pstmt.setString(2, upVO.getUser_id());

			updatePassFlag =  pstmt.executeUpdate();
			
		}finally {
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end finally
		
		return updatePassFlag; 
	} // updatePass()
	
	
	
	public UserInfoVO selectMyData(selectMyDataVO smdVO) throws SQLException{
		UserInfoVO uiVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConn();
			StringBuilder sb = new StringBuilder();
			sb
			.append("	select user_zipcode, user_phone, user_addr1, user_addr2	")
			.append("	from member where user_id = ? and user_pass = ?	");
			pstmt = con.prepareStatement(sb.toString());
			
			//암호화
			String pass = "";
			try {
				DataEncrypt de = new DataEncrypt("0123456789abcdef");
				pass = DataEncrypt.messageDigest("MD5", smdVO.getUser_pass());
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}//end catch
			
			pstmt.setString(1, smdVO.getUser_id());
			pstmt.setString(2, pass);
			
			rs = pstmt.executeQuery();
			
			if( rs.next() ) {
				uiVO = new UserInfoVO(rs.getString("user_phone"), rs.getString("user_zipcode"), 
						rs.getString("user_addr1"), rs.getString("user_addr2") );
			}
			
		}finally {
			if( rs != null ) { rs.close(); }// end if
			if( pstmt != null ) { pstmt.close(); }// end if
			if( con != null ) { con.close(); }// end if
		}
		
		return uiVO;
	} // selectMyData
	
	public boolean updateUserInfo(UpdateUserInfoVO uuiVO) throws SQLException{
		boolean updateUserInfoFlag = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConn();
			StringBuilder sb = new StringBuilder();
			sb
			.append("	update member	")
			.append("	set user_pass=?, user_phone=?, user_zipcode=?	")
			.append("	, user_addr1=?, user_addr2=?	")
			.append("	where user_id = ?	");
			
			pstmt = con.prepareStatement(sb.toString());
			
			//암호화
			String pass = "";
			try {
				DataEncrypt de = new DataEncrypt("0123456789abcdef");
				pass = DataEncrypt.messageDigest("MD5", uuiVO.getUser_pass());
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}//end catch
			
			pstmt.setString(1, pass);
			pstmt.setString(2, uuiVO.getUser_phone());
			pstmt.setString(3, uuiVO.getUser_zipcode());
			pstmt.setString(4, uuiVO.getUser_addr1());
			pstmt.setString(5, uuiVO.getUser_addr2());
			pstmt.setString(6, uuiVO.getUser_id());
			updateUserInfoFlag = pstmt.execute();
		}finally {
			if( pstmt != null ) { pstmt.close(); }// end if
			if( con != null ) { con.close(); }// end if
		}//end finally
		return updateUserInfoFlag;
	} // updateUserInfo
	
	public List<UserOrderVO> selectOrderList(SelectOrderListVO solVO) throws SQLException {
		List<UserOrderVO> list = new ArrayList<UserOrderVO>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConn();
			
			StringBuilder selectOrder = new StringBuilder();
			selectOrder
			.append("	select ORDER_NO, ORDER_DATE, ORDER_PRICE, ORDER_STATUS ")
			.append("	from order_list ")
			.append("	where user_id = ?"); 
			
			if(solVO.getStrDate() != null) {
				selectOrder.append("and order_date between ? and ? "); 				
			}
			selectOrder.append("	order by order_date desc");
		
			pstmt = con.prepareStatement(selectOrder.toString());
			
			pstmt.setString(1, solVO.getUser_id());
			
			if(solVO.getStrDate() != null) {
				
				pstmt.setString(2, solVO.getStrDate());
				pstmt.setString(3, solVO.getEndDate());
			}

			rs = pstmt.executeQuery();

			UserOrderVO uoVO = null;
			List<OrderMenuVO> menuList = null;
			while (rs.next()) {
				menuList = selectOrderMenu(rs.getString("order_no"));
				
				uoVO = new UserOrderVO(solVO.getUser_id(), rs.getString("order_status"), rs.getString("order_date"),
						rs.getInt("order_price"), menuList);
				list.add(uoVO);
			} // end while

		} finally {
			if (rs != null) {
				rs.close();
			} // end if
			if (pstmt != null) {
				pstmt.close();
			} // end if
			if (con != null) {
				con.close();
			} // end if
		}

		return list;
	} // selectOrderList
	
	/**
	 * @param orderNo
	 * @return
	 * @throws SQLException
	 */
	public List<OrderMenuVO> selectOrderMenu(String orderNo) throws SQLException {
		List<OrderMenuVO> list = new ArrayList<OrderMenuVO>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = getConn();
			
			StringBuilder selectOrderMenu = new StringBuilder();
			selectOrderMenu
			.append("	select menu_name, order_no, order_menu_price, order_menu_cnt ")
			.append("	from order_menu")
			.append("	where order_no = ?");

			pstmt = con.prepareStatement(selectOrderMenu.toString());

			pstmt.setString(1, orderNo);

			rs = pstmt.executeQuery();

			OrderMenuVO omVO = null;

			while (rs.next()) {
				omVO = new OrderMenuVO(rs.getString("order_no"), rs.getString("menu_name"), rs.getInt("order_menu_price"),rs.getInt("order_menu_cnt"));
				list.add(omVO);
			} // end while

		} finally {
			if (rs != null) {
				rs.close();
			} // end if
			if (pstmt != null) {
				pstmt.close();
			} // end if
			if (con != null) {
				con.close();
			} // end if
		}

		return list;
	} // selectOrderMenu()
	
	public List<MemberVO> selectMemberList(SelectMemberVO smVO) throws SQLException{
		List<MemberVO> selectMemberList = new ArrayList<MemberVO>();
		
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConn();
			
			StringBuilder selectOrder = new StringBuilder();
			selectOrder
			.append("	select user_id, user_name, user_addr1,	")
			.append("		substr(user_phone,1,3)||'-'||substr(user_phone,4,4)||'-'||substr(user_phone,7,4) user_phone, user_status")
			.append("	from member	");
			
			if(!"".equals(smVO.getSelectData()) && smVO.getSelectData() != null) {
				selectOrder
				.append(" where ")
				.append(smVO.getSelectType())
				.append(" like '%'||?||'%' ");
			}//end if

			
			selectOrder
			.append("	order by user_status desc	");
			
			pstmt = con.prepareStatement(selectOrder.toString());
			
			if(!"".equals(smVO.getSelectData()) && smVO.getSelectData() != null) {
				pstmt.setString(1, smVO.getSelectData());
			}//end if
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				selectMemberList.add(new MemberVO(rs.getString("user_id"), rs.getString("user_name"),
						rs.getString("user_addr1"), rs.getString("user_phone"),
						rs.getString("user_status")));
			}//end while
			
		} finally {
			if(rs!=null) { rs.close(); }//end if
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end catch
		
		return selectMemberList;
	} // selectMemberList
	
	public MemberDetailVO selectMemberDetail(String user_id) throws SQLException{
		MemberDetailVO mdVO = null;
		
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConn();
			
			StringBuilder selectMeber = new StringBuilder();
			selectMeber
			.append("	select user_name, substr(user_phone,1,3)||'-'||substr(user_phone,4,4)||'-'||substr(user_phone,7,4) user_phone,	")
			.append("		user_zipcode, user_addr1, user_addr2, to_char(user_hiredate,'yyyy-mm-dd hh24:mi') user_hiredate, user_ip	")
			.append("	from member	")
			.append("	where user_id = ?	");
			
			pstmt = con.prepareStatement(selectMeber.toString());
			
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mdVO = new MemberDetailVO(rs.getString("user_name"), rs.getString("user_phone"),
						rs.getString("user_zipcode"), rs.getString("user_addr1"), rs.getString("user_addr2"),
						rs.getString("user_hiredate"), rs.getString("user_ip"));
			}//end if
			
		} finally {
			if(rs!=null) { rs.close(); }//end if
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end catch 
		 
		return mdVO;
	} // selectMemberDetail
	
	public int updateResign(UpdateResignVO urVO) throws SQLException {
		int updateResignFlag = 0;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConn();
			StringBuilder sb = new StringBuilder();
			sb
			.append("	update member	")
			.append("	set user_pass='', user_name='', user_phone='', user_zipcode=''	")
			.append("	, user_addr1='', user_addr2='', user_hiredate='', user_ip=''	")
			.append("	, user_status='탈퇴', user_resdata=?, user_resign_date=sysdate	")
			.append("	where user_id = ?	");
			pstmt = con.prepareStatement(sb.toString());
			pstmt.setString(1, urVO.getUser_resdata());
			pstmt.setString(2, urVO.getUser_id());
			
			updateResignFlag = pstmt.executeUpdate();
		} finally {
			if( rs != null ) { rs.close(); }//end if
			if( pstmt != null ) { pstmt.close(); }//end if
			if( con != null ) { con.close(); }//end if
		}
		
		return updateResignFlag;
	} // updateResign
	
	public ResignMemberVO selectResignMember(String user_id) throws SQLException {
		ResignMemberVO rmVO = null;
		
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = getConn();
			
			StringBuilder selectMeber = new StringBuilder();
			selectMeber
			.append("	select user_resdata, to_char(user_resign_date,'yyyy-mm-dd hh24:mi') user_resign_date	")
			.append("	from member	")
			.append("	where user_id = ?	");
			
			pstmt = con.prepareStatement(selectMeber.toString());
			
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rmVO = new ResignMemberVO(rs.getString("user_resdata"), rs.getString("user_resign_date"));
			}//end if
			
		} finally {
			if(rs!=null) { rs.close(); }//end if
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end catch 
		
		return rmVO;
	} // selectResignMember
	
} // class
