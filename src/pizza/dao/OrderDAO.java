package pizza.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import pizza.admin.vo.AdminOrderVO;
import pizza.admin.vo.OrderDetailVO;
import pizza.admin.vo.OrderMenuListVO;
import pizza.admin.vo.OrderMenuVO;
import pizza.admin.vo.SelectOrderVO;
import pizza.admin.vo.UpdateOrderVO;
import pizza.user.vo.OrderUserInfoVO;
import pizza.user.vo.OrderVO;

public class OrderDAO {

private static OrderDAO order_dao;
	
	private OrderDAO() {
		
	} 
	
	public static OrderDAO getInstance() {
		if ( order_dao == null) {
			order_dao = new OrderDAO();
		} // end if
		return order_dao;
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

	/**
	 * 2020-08-13 ��ȫ�� - ���� �ڵ� �� �ּ� �߰�
	 * @param user_id ���ǿ� �ִ� ������ ID
	 * @return OrderUserInfoVO ��ü�� ������ ��� ��ȯ
	 * @throws SQLException
	 */
	public OrderUserInfoVO selectUserInfo(String user_id) throws SQLException{
		OrderUserInfoVO ouiVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// Connection ��ü ���
			con = getConn();
			
			// ������ �ۼ�
			StringBuilder selectUserInfo = new StringBuilder();
			selectUserInfo.append("	select substr(user_phone,1,3)||'-'||substr(user_phone,4,4)||'-'||substr(user_phone,7,4) user_phone,  ")
						.append("	user_zipcode, user_addr1, user_addr2 ") 
						.append("	from member ")
						.append("	where user_id=?	");
			
			pstmt = con.prepareStatement(selectUserInfo.toString());
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) { // �˻������ �ִٸ�
				// �α����� ������ ��ȭ��ȣ, �����ȣ, �ּ�, ���ּҸ� ouiVO�� �ִ´�.
				ouiVO = new OrderUserInfoVO(rs.getString("user_phone"), rs.getString("user_zipcode"), rs.getString("user_addr1"), rs.getString("user_addr2"));
			} // end if
			
		} finally {
			// ���� ����
			if(rs!=null) { rs.close(); }//end if
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end catch
		return ouiVO;
	} // selectUserInfo()
	
	/**
	 * �ֹ�����(order_list ���̺�)�� �߰��ϰ� �ֹ���ȣ�� ��ȯ�ϴ� ��
	 * @param orderVO
	 * 
	 */
	//2020-08-14 ��ȫ�� - �ڵ� �߰�
	//2020-08-17 ��ȫ�� - ��ȯ�� void -> String ����
	public String insertOrder(OrderVO oVO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		OrderUserInfoVO ouiVO = oVO.getOuiVO();
		String user_phone = ouiVO.getUser_phone();
		user_phone = user_phone.replace("-","");
		String orderNo = "";
		try {
			// connection ���
			con = getConn();
			// ������ �ۼ�
			StringBuilder insertOrder = new StringBuilder();
			insertOrder.append("	insert into order_list(order_no, order_date, user_id, user_zipcode, user_addr1, user_addr2, ")
						.append("	user_phone, order_price, order_status, order_pay, user_ip)	")
						.append("	values(seq_order_no.nextval, sysdate, ?, ?, ?, ?, ?, ?, '�ֹ�����', ?, ? )	");
			// ������ ���ఴü ���
			pstmt = con.prepareStatement(insertOrder.toString());
			// bind���� �ֱ�
			pstmt.setString(1, oVO.getUser_id());
			pstmt.setString(2, ouiVO.getUser_zipcode());
			pstmt.setString(3, ouiVO.getUser_addr1());
			pstmt.setString(4, ouiVO.getUser_addr2());
			// ��ȭ��ȣ ������ ���� �ʿ�
			pstmt.setString(5, user_phone);
			pstmt.setInt(6, oVO.getOrder_price());
			pstmt.setString(7, oVO.getOrder_pay());
			pstmt.setString(8, oVO.getUser_ip());
			
			pstmt.execute();
			pstmt.close();
			
			// order_no�� �޾ƿ������� ����������� ��ȣ�� �����´�.
			pstmt = con.prepareStatement("	select seq_order_no.currval order_no from dual	");
			rs = pstmt.executeQuery();
						
			if (rs.next()) {
				// ���� ������ ��ȣ�� ����
				orderNo = String.valueOf(rs.getInt("order_no"));
				System.out.println(orderNo);
			}// end if
			
		} finally {
			if (pstmt != null) { pstmt.close();	} // end if
			if (con != null) { con.close();	} // end if
		} // end finally
		
		return orderNo;
	} // insertOrder()
	
	/**
	 * 2020-08-14 ��ȫ�� - �ڵ� �߰�
	 * �ֹ��޴�(order_menu)�� �߰��ϴ� ��
	 * @param OrderMenuVO
	 * @throws SQLException
	 */
	public void insertOrderMenu(OrderMenuVO omVO) throws SQLException{
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// connection ���
			con = getConn();
			// ������ ����
			StringBuilder insertOrderMenu = new StringBuilder();
			insertOrderMenu.append("	insert into order_menu (menu_name, order_no, order_menu_price, order_menu_cnt)"	)
							.append("	values(?, ?, ?, ?)	");
			
			pstmt = con.prepareStatement(insertOrderMenu.toString());
			
			// bind ���� �ֱ�
			pstmt.setString(1, omVO.getMenu_name());
			pstmt.setString(2, omVO.getOrder_no());
			pstmt.setInt(3, (omVO.getOrder_menu_price() * omVO.getOrder_menu_cnt()));
			pstmt.setInt(4, omVO.getOrder_menu_cnt());
			
			pstmt.execute();
			
		} finally {
			if (pstmt != null) { pstmt.close(); }
			if (con != null) { con.close(); }
		} // end finally
	} // insertOrderMenu()
	
	public List<AdminOrderVO> selectOrderList(SelectOrderVO soVO) throws SQLException{
		List<AdminOrderVO> selectOrderList = new ArrayList<AdminOrderVO>();
		
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// Connection ��ü ���
			con = getConn();
			
			//�ֹ���ȣ�� �޴��� ������ ������ ����
			Map<String,Integer> menuCnt = new HashMap<String,Integer>();
			
			//�ֹ���ȣ�� �޴��� ������ ���ϴ� ������
			StringBuilder selectMenuCnt = new StringBuilder();
			selectMenuCnt
			.append("	select order_no, count(order_no) cnt	")
			.append("	from(select ol.order_no	")
			.append("		from order_list ol, order_menu om	")
			.append("		where ol.order_no(+) = om.order_no)	")
			.append("	group by order_no	")
			.append("	order by order_no desc	");
			
			pstmt = con.prepareStatement(selectMenuCnt.toString());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				menuCnt.put(rs.getString("order_no"),rs.getInt("cnt"));
			}//end while
			
			pstmt.close();
			rs.close();
			
			// �ֹ����̺��� ��ȸ�ϴ� ������ �ۼ�
			StringBuilder selectOrder = new StringBuilder();
			selectOrder
			.append("	select order_no, user_id, order_status, to_char(order_date,'yyyy-mm-dd hh24:mi') order_date, order_price, menu_name	")
			.append("	from(select ol.order_no, ol.user_id, ol.order_status, ol.order_date, ol.order_price, om.menu_name, om.menu_type	")
			.append("		from order_list ol, (select om.order_no, om.menu_name, m.menu_type	")
			.append("							from menu m, order_menu om	")
			.append("							where m.menu_name = om.menu_name) om	")
			.append("		where ol.order_no = om.order_no	")
			.append("		order by ol.order_no desc, om.menu_type, om.menu_name)	");
			
			// �˻� ���� �Է½� ������ �߰�
			if(!"none".equals(soVO.getSelectType()) && !"".equals(soVO.getSelectData())
					&& !(soVO.getSelectData() == null)) {
				if ("order_no".equals(soVO.getSelectType())) {//�˻������� �ֹ���ȣ�� ���
					selectOrder
					.append("	where order_no = ?	");
				} else if("order_price".equals(soVO.getSelectType())) {//�˻������� ������ ���
					selectOrder
					.append("	where order_price = ?	");
				} else {	//�˻� ������ �ֹ���ȣ�� ������ �ƴ� ���
					selectOrder
					.append(" where ")
					.append(soVO.getSelectType())
					.append(" like '%'||?||'%'");
				}//end else
			}//end if
			
			//������ ���� ��ü ���
			pstmt = con.prepareStatement(selectOrder.toString());
			
			//���ε� ������ �� �ֱ�
			if(!"none".equals(soVO.getSelectType()) && !"".equals(soVO.getSelectData())
					&& !(soVO.getSelectData() == null)) {
				pstmt.setString(1, soVO.getSelectData());
			}//end if
			
			//���� ���� �� ��� ���
			rs = pstmt.executeQuery();
			
			//�����ֹ���ȣ�� ��� ���� ����.
			String temp = "";
			AdminOrderVO aoVO = null;
			while(rs.next()) {	
				if("".equals(temp)) {			//��ó�� ���̺��� ��ȸ�Ҷ� 
					temp = rs.getString("order_no");	//��ó�� ��ȸ�� ���̺��� �ֹ���ȣ�� ����
				}//end if
				
				//�����ֹ���ȣ�� �����ֹ���ȣ�� ���ٸ� ���� ����Ʈ�� �߰��� �ʿ䰡 ����.
				if(!temp.equals(rs.getString("order_no"))) {	//�����ֹ���ȣ�� �����ֹ���ȣ�� �ٸ����
					selectOrderList.add(aoVO);			//�������� ����� aoVO�� ����Ʈ�� �߰�
					temp = rs.getString("order_no");	//���� �ֹ���ȣ�� ���ϱ� ���� ���� �ֹ���ȣ�� temp�� ���� 
				}//end if
				
				aoVO = new AdminOrderVO(rs.getString("order_no"), rs.getString("user_id"),
						rs.getString("menu_name"), rs.getString("order_status"),
						rs.getString("order_date"), rs.getInt("order_price"), menuCnt.get(rs.getString("order_no")));
			}//end while
			
			//������ ���̺� ��� �����ֹ���ȣ�� ���� ���� �ֹ���ȣ�� ���� ������ ����Ʈ�� �߰����� ���ϰ� while�� �������´�.
			//�׷� ��츦 �����ϱ� ���� while �ۿ��� ����Ʈ�� aoVO�� �ѹ� �߰����ش�.
			if(aoVO != null) {	//�˻��� ���̺��� �ִٸ�
				selectOrderList.add(aoVO);	//����Ʈ�� aoVO �߰�
			}//end if
			
		} finally {
			if(rs!=null) { rs.close(); }//end if
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end catch
		
		return selectOrderList;
	} // selectOrderList()
	
	public OrderDetailVO selectOrderDetail(String orderNo) throws SQLException{
		OrderDetailVO odVO = null;
		
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// Connection ��ü ���
			con = getConn();
			
			// ������ �ۼ�
			StringBuilder selectOrder = new StringBuilder();
			selectOrder
			.append("	select order_no, order_date, user_id, user_zipcode, user_addr1, user_addr2, user_phone, order_price, order_status, order_pay, user_ip	")
			.append("	from order_list	")
			.append("	where order_no = ?	");
			
			//������ ���� ��ü ���
			pstmt = con.prepareStatement(selectOrder.toString());
			
			//���ε� ������ �� �ֱ�
			pstmt.setString(1, orderNo);
			
			//���� ���� �� ��� ���
			rs = pstmt.executeQuery();
			
			List<OrderMenuListVO> list = new ArrayList<OrderMenuListVO>();
			while(rs.next()) {				
				odVO = new OrderDetailVO(rs.getString("order_date"), rs.getString("user_id"), 
						rs.getString("user_zipcode"), rs.getString("user_addr1"), rs.getString("user_addr2"), 
						rs.getString("user_phone"), rs.getString("order_status"), rs.getString("order_pay"), 
						rs.getString("user_ip"), rs.getInt("order_price"), list);
			}//end while
			
			pstmt.close();
			rs.close();
			
			StringBuilder selectMenu = new StringBuilder();
			selectMenu
			.append("	select menu_name, order_menu_price, order_menu_cnt	")
			.append("	from order_menu	")
			.append("	where order_no = ?	");
			
			pstmt = con.prepareStatement(selectMenu.toString());
			
			pstmt.setString(1, orderNo);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(new OrderMenuListVO(rs.getString("menu_name"), rs.getInt("order_menu_price"),
						rs.getInt("order_menu_cnt")));
			}//end while
			
			odVO.setMenuListVO(list);
			
		} finally {
			if(rs!=null) { rs.close(); }//end if
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end catch
		
		return odVO;
	}
	
	public List<OrderVO> selectOrderMenu(String orderNo) {
		List<OrderVO> selectOrderMenulist = new ArrayList<OrderVO>();
		
		return selectOrderMenulist;
	} // selectOrderMenu()
	
	
	public int updateOrder(UpdateOrderVO uoVO) throws SQLException{
		int updateCnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = getConn();
			
			StringBuilder updateOrder = new StringBuilder();
			updateOrder
			.append("	update order_list	")
			.append("	set order_status=?	")
			.append("	where order_no=?	");
			
			pstmt = con.prepareStatement(updateOrder.toString());
			
			pstmt.setString(1, uoVO.getOrder_status());
			pstmt.setString(2, uoVO.getOrder_no());
			
			updateCnt = pstmt.executeUpdate();
			
		} finally {
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end catch
		
		return updateCnt;
	} // updateOrder()
	
	public boolean deleteOrder(String orderNo) {
		boolean deleteOrderFlag = false;
		
		return deleteOrderFlag;
	} // deleteOrder()	
} // class
