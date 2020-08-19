package pizza.dao;

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

import pizza.admin.vo.MemberDetailVO;
import pizza.admin.vo.MemberVO;
import pizza.admin.vo.OrderMenuVO;
import pizza.admin.vo.ResignMemberVO;
import pizza.admin.vo.SelectMemberVO;
import pizza.admin.vo.UpdateResignVO;
import pizza.user.vo.InsertMemberVO;
import pizza.user.vo.LoginVO;
import pizza.user.vo.SelectIdVO;
import pizza.user.vo.SelectOrderListVO;
import pizza.user.vo.SelectPassVO;
import pizza.user.vo.UpdatePassVO;
import pizza.user.vo.UpdateUserInfoVO;
import pizza.user.vo.UserInfoVO;
import pizza.user.vo.UserOrderVO;

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
			//�뜝�럥�뒗占쎄콪占쎈빝筌믩끃�굲�뜝�룞�삕 占쎈쐻占쎈윥占쎄숱占쎈섀占쎈Ŋ�굲
			con = getConn();
			StringBuilder sb = new StringBuilder();
			sb
			.append("	insert into member (user_id, user_pass, user_name, user_phone, user_zipcode, user_addr1, user_addr2, user_ip )	")
			.append("	values ( ?, ?, ?, ?, ?, ?, ?, ? )	");
			//�뜝�럥�맗�뜝�럥�땻�뜝�럥�돱�뜝�럥�떛占쎈쐻�뜝占� 占쎈쐻占쎈윞�눧硫⑤쐻占쎈윞占쎈렰 占쎈쨬占쎈즵�뜮�꼯�쇊�뜝占� 占쎈쐻占쎈윥占쎄숱占쎈섀占쎈Ŋ�굲
			pstmt = con.prepareStatement(sb.toString());
			//占쎈쎗占쎈즴占쎈씔�뜝�럥�뜲占쎈쐻占쎈윥�뤃占� 占쎌녃域밟뫁�굲占쎈쐻占쎈윥占쎈묄占쎈쐻占쎈윥占쎈군 占쎈쨬占쎈즸占쎌굲 占쎈쐻占쎈윞占쎈쭨占쎈섀占쎈Ŋ�굲
			pstmt.setString(1, imVO.getUser_id());
			pstmt.setString(2, imVO.getUser_pass());
			pstmt.setString(3, imVO.getUser_name());
			pstmt.setString(4, imVO.getUser_phone());
			pstmt.setString(5, imVO.getUser_zipcode());
			pstmt.setString(6, imVO.getUser_addr1());
			pstmt.setString(7, imVO.getUser_addr2());
			pstmt.setString(8, imVO.getUser_ip());
			//�뜝�럥�맗�뜝�럥�땻�뜝�럥�돱 癲ル슣�돳占쎌맆�뜝�럥爰� 占쎈쐻占쎈윥占쎈묄占쎈쐻占쎈윥筌묕옙
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
	 * �뜝�럥�닡�뜝�럩逾졾뜝�럥�꺏 嶺뚢돦堉먪뵳占�
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
			//3.Conntection �뜝�럥�꽢�뼨�먯삕
			con=getConn();
			
			//4.占쎈쐩占쎈닑占쎈뉴占쎈닱�뜝占� �뜝�럡臾멨뜝�럡�뎽 �뤆�룇鍮섊뙼占� �뜝�럥�꽢�뼨�먯삕
			String selectId="select user_id from member where user_name=? and user_phone=?";
			pstmt=con.prepareStatement(selectId);
			
			//�뛾�룆�뾼占쎈데�뜝�럥援� �솻洹⑥삕�뜝�럥�빢 �뤆�룊�삕 �뜝�럡�맜�뼨�먯삕
			pstmt.setString(1, siVO.getUser_name());
			pstmt.setString(2, siVO.getUser_phone());
			
			//5.占쎈쐩占쎈닑占쎈뉴 �뜝�럥�빢�뜝�럥六� �뜝�럩�쐩 �뇦猿됲�쀯옙沅� �뜝�럥�꽢�뼨�먯삕
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
	 * 占쎈쑏熬곣뫅�삕�뵓怨뺣쐡占쎄퉰 嶺뚢돦堉먪뵳占�
	 * 0808- �뜝�럩�궋�뜝�룞�삕�뜝�럩援� SelectPassVO soVO�뜝�럥�뱺�뜝�럡�맋 spVO�슖�댙�삕 �솻洹⑥삕�뇦猿볦삕 
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
			//3.Conntection �뜝�럥�꽢�뼨�먯삕
			con=getConn();
			
			//4.占쎈쐩占쎈닑占쎈뉴占쎈닱�뜝占� �뜝�럡臾멨뜝�럡�뎽 �뤆�룇鍮섊뙼占� �뜝�럥�꽢�뼨�먯삕 user_id, user_name, user_phone;
			String selectPass="select user_pass from member where user_id=? and user_name=? and user_phone=?";
			pstmt=con.prepareStatement(selectPass);
			
			//�뛾�룆�뾼占쎈데�뜝�럥援� �솻洹⑥삕�뜝�럥�빢 �뤆�룊�삕 �뜝�럡�맜�뼨�먯삕
			pstmt.setString(1, spVO.getUser_id());
			pstmt.setString(2, spVO.getUser_name());
			pstmt.setString(3, spVO.getUser_phone());
			
			//5.占쎈쐩占쎈닑占쎈뉴 �뜝�럥�빢�뜝�럥六� �뜝�럩�쐩 �뇦猿됲�쀯옙沅� �뜝�럥�꽢�뼨�먯삕
			rs=pstmt.executeQuery();
			
			if(rs.next()) { //占쎈쐩占쎈닑占쎈뉴占쎈닱筌뤾쑬�뱺�뜝�럡�맋 user_pass�뤆�룊�삕 �뜝�럡�맂�뜝�럥�꽑�뜝�럩沅롧춯濡녹삕
				
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
			
			String updatePass="update member set user_pass = 1234 where user_id = 'test1'";
			//update member set user_pass='0000' where user_id='grace';
			pstmt=con.prepareStatement(updatePass);
			
			
			System.out.println("DAO "+upVO.getUser_pass());
			System.out.println("DAO "+upVO.getUser_id());
			
			//pstmt.setString(1, upVO.getUser_pass());
			//pstmt.setString(2, upVO.getUser_id());
		 
			System.out.println("updatePassFlag �븵");
			updatePassFlag =  pstmt.executeUpdate();
			System.out.println("updatePassFlag �뮘");
			
		}finally {
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
			System.out.println("DAO �걹");
		}//end finally
		
		return updatePassFlag; 
	} // updatePass()
	
	
	
	public UserInfoVO selectMyData(LoginVO lVO) throws SQLException{
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
			pstmt.setString(1, lVO.getUser_id());
			pstmt.setString(2, lVO.getUser_pass());
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
			pstmt.setString(1, uuiVO.getUser_pass());
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
			// connection �뜝�럥�꽢�뼨�먯삕
			con = getConn();
			
			// 占쎈쐩占쎈닑占쎈뉴占쎈닱�뜝占� �뜝�럡臾멨뜝�럡�뎽�뜝�럥由��뼨�먯삕
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
			// �뛾�룆�뾼占쎈데�뜝�럥援� �솻洹⑥삕�뜝�럥�빢 �뤆�룊�삕 �뜝�럡�맜�뼨�먯삕
			pstmt.setString(1, solVO.getUser_id());
			
			if(solVO.getStrDate() != null) {
				//System.out.println(solVO.getStrDate()+"부터");
				//System.out.println(solVO.getEndDate()+"까지 조회");
				
				pstmt.setString(2, solVO.getStrDate());
				pstmt.setString(3, solVO.getEndDate());
			}

			// 占쎈쐩占쎈닑占쎈뉴占쎈닱�뜝占� �뜝�럥�빢�뜝�럥六� �뜝�럩�쐩 �뇦猿됲�쀯옙沅� �뜝�럥�꽢�뼨�먯삕
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
	 * �썒�슣�닑�룇 �뜝�럡���뜝�럥�뿴�뜝�럩踰� 嶺뚮∥��占쎈� 占쎄껀�뜝�띂寃ヨ쥈�뫗諭� List�슖�댙�삕 �뛾�룇瑗뱄옙�꼶�뜝�럥由��뜝�럥裕� Method
	 * 
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
			// 占쎈슔�걞�땻戮녹삕占쏙옙 �뜝�럥�꽢�뼨�먯삕
			con = getConn();
			// 占쎈쐩占쎈닑占쎈뉴占쎈닱�뜝占� �뜝�럡臾멨뜝�럡�뎽�뤆�룇鍮섊뙼占� �뜝�럥�꽢�뼨�먯삕
			StringBuilder selectOrderMenu = new StringBuilder();
			selectOrderMenu
			.append("	select menu_name, order_no, order_menu_price, order_menu_cnt ")
			.append("	from order_menu")
			.append("	where order_no = ?");

			pstmt = con.prepareStatement(selectOrderMenu.toString());
			// �뛾�룆�뾼占쎈데�뜝�럥援� �솻洹⑥삕�뜝�럥�빢 �뜝�럥�꽢�뼨�먯삕
			pstmt.setString(1, orderNo);

			// 占쎈쐩占쎈닑占쎈뉴�뜝�럥�빢�뜝�럥六� �뜝�럩�쐩 �뇦猿됲�쀯옙沅� �뜝�럥�꽢�뼨�먯삕
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
			// Connection �뤆�룇鍮섊뙼占� �뜝�럥�꽢�뼨�먯삕
			con = getConn();
			
			// 占쎈쐩占쎈닑占쎈뉴占쎈닱�뜝占� �뜝�럩�굚�뜝�럡�뎽
			StringBuilder selectOrder = new StringBuilder();
			selectOrder
			.append("	select user_id, user_name, user_addr1, user_phone, user_status")
			.append("	from member	");
			
			// �뇦猿볦삕�뜝�럡�돰 �댖怨뚰�쀦뤃占� �뜝�럩肉��뜝�럩�졑�뜝�럥六� 占쎈쐩占쎈닑占쎈뉴占쎈닱�뜝占� 占쎈퉲�겫�룞�삕
			if(!"".equals(smVO.getSelectData()) && smVO.getSelectData() != null) {
				selectOrder
				.append(" where ")
				.append(smVO.getSelectType())
				.append(" like '%'||?||'%' ");
			}//end if

			
			selectOrder
			.append("	order by user_status desc	");
			
			//占쎈쐩占쎈닑占쎈뉴占쎈닱�뜝占� �뜝�럥�빢�뜝�럥六� �뤆�룇鍮섊뙼占� �뜝�럥�꽢�뼨�먯삕
			pstmt = con.prepareStatement(selectOrder.toString());
			
			//�뛾�룆�뾼占쎈데�뜝�럥援� �솻洹⑥삕�뜝�럥�빢�뜝�럥�뱺 �뤆�룊�삕 �뜝�럡�맜�뼨�먯삕
			if(!"".equals(smVO.getSelectData()) && smVO.getSelectData() != null) {
				pstmt.setString(1, smVO.getSelectData());
			}//end if
			
			//占쎈쐩占쎈닑占쎈뉴 �뜝�럥�빢�뜝�럥六� �뜝�럩�쐩 �뇦猿됲�쀯옙沅� �뜝�럥�꽢�뼨�먯삕
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
			// Connection 揶쏆빘猿� 占쎈섯疫뀐옙
			con = getConn();
			
			// �뜎�눖�봺�눧占� 占쎌삂占쎄쉐
			StringBuilder selectMeber = new StringBuilder();
			selectMeber
			.append("	select user_name, user_phone, user_zipcode, user_addr1, user_addr2, user_hiredate, user_ip	")
			.append("	from member	")
			.append("	where user_id = ?	");
			
			//�뜎�눖�봺�눧占� 占쎈땾占쎈뻬 揶쏆빘猿� 占쎈섯疫뀐옙
			pstmt = con.prepareStatement(selectMeber.toString());
			
			//獄쏅뗄�뵥占쎈굡 癰귨옙占쎈땾占쎈퓠 揶쏉옙 占쎄퐫疫뀐옙
			pstmt.setString(1, user_id);
			
			//�뜎�눖�봺 占쎈땾占쎈뻬 占쎌뜎 野껉퀗�궢 占쎈섯疫뀐옙
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
			.append("	, user_status='占쎄퉱占쎈닚', user_resdata=?, user_resign_date=sysdate	")
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
			// Connection 揶쏆빘猿� 占쎈섯疫뀐옙
			con = getConn();
			
			// �뜎�눖�봺�눧占� 占쎌삂占쎄쉐
			StringBuilder selectMeber = new StringBuilder();
			selectMeber
			.append("	select user_resdata, user_resign_date	")
			.append("	from member	")
			.append("	where user_id = ?	");
			
			//�뜎�눖�봺�눧占� 占쎈땾占쎈뻬 揶쏆빘猿� 占쎈섯疫뀐옙
			pstmt = con.prepareStatement(selectMeber.toString());
			
			//獄쏅뗄�뵥占쎈굡 癰귨옙占쎈땾占쎈퓠 揶쏉옙 占쎄퐫疫뀐옙
			pstmt.setString(1, user_id);
			
			//�뜎�눖�봺 占쎈땾占쎈뻬 占쎌뜎 野껉퀗�궢 占쎈섯疫뀐옙
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
