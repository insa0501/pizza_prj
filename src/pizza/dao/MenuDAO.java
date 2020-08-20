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

import pizza.admin.vo.AddMenuVO;
import pizza.admin.vo.MenuDetailVO;
import pizza.admin.vo.MenuListVO;
import pizza.admin.vo.SelectMenuVO;
import pizza.admin.vo.UpdateMenuVO;
import pizza.user.vo.MainMenuVO;

public class MenuDAO {

	private static MenuDAO menu_dao;

	// 2020-08-08 ��ȫ�� - �⺻������ �߰� (private)
	private MenuDAO() {
		
	}
	
	// 2020-08-08 ��ȫ�� - getInstance ���������� ����
	// private -> public
	public static MenuDAO getInstance() {
		if (menu_dao == null) {
			menu_dao = new MenuDAO();
		} // end if
		return menu_dao;
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
	
	// �޴� �߰� insert, ���� update (���º�������), �޴��˻�, �޴��˻��� 
	/** �޴� �߰� ������
	* @param amVO
	* @throws SQLException
	*/
	public void insertMenu(AddMenuVO amVO)throws SQLException {
	     Connection con = null;
	     PreparedStatement pstmt = null;
	         
	     try {
	    	 //conection
	         con = getConn();
	            
	         StringBuilder insertMenu = new StringBuilder();
	            
	         insertMenu
	         .append("   insert into menu (menu_name, menu_type, menu_price, menu_img, menu_activity, admin_id)   ")
	         .append("   values (?,?,?,?,?,?)  ");
	            
	         pstmt = con.prepareStatement(insertMenu.toString());
	            
	         pstmt.setString(1,amVO.getMenu_name() );//menu_name
	         pstmt.setString(2,amVO.getMenu_type() );//menu_type
	         pstmt.setInt(3,amVO.getMenu_price());//menu_price
	         pstmt.setString(4,amVO.getMenu_img() );
	            
	         if(amVO.getMenu_activity() == null) {
	            pstmt.setString(5,"Y");
	         } else {
	            pstmt.setString(5,"N");
	         } 
	         //pstmt.setString(5,amVO.getMenu_activity() );
	         pstmt.setString(6,amVO.getAdmin_id());
	            
	         pstmt.executeUpdate();
	            
	         }finally {
	            if(pstmt != null) {pstmt.close();}
	            if(con != null) {con.close();}
	         }//end finally
	      
	} // insertMenu()
	
    //��� �޴��� �ҷ����� �۾�, 2020-08-08, ����
    //throws SQLException�� �߰�, 2020-08-08, ����
    public List<MainMenuVO> selectMainMenu(String menuType) throws SQLException {
       List<MainMenuVO> list = new ArrayList<MainMenuVO>();
       
       Connection con = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       
       try {
          con = getConn();
          String selectMenu = "   select * from menu where menu_type=?   ";
          selectMenu += "   and menu_activity='Y'   ";
          
          pstmt = con.prepareStatement(selectMenu);
          pstmt.setString(1, menuType);
          
          rs = pstmt.executeQuery();
          
          MainMenuVO temp = null;
          
          while(rs.next()) {
             temp = new MainMenuVO(rs.getString("menu_img"),rs.getString("menu_name"), rs.getInt("menu_price"));
             list.add(temp);
          }
       
       } finally {
          if(rs!=null) { rs.close(); }
          if(pstmt!=null) { pstmt.close(); }
          if(con!=null) { con.close(); }
       }//end finally
       
       return list;
    } // selectMainMenu()
	
	public List<MenuListVO> selectMenu(SelectMenuVO smVO) throws SQLException{
		List<MenuListVO> selectMenuList = new ArrayList<MenuListVO>();
		
		Connection con =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// Connection ��ü ���
			con = getConn();
			
			// ������ �ۼ�
			StringBuilder selectMenu = new StringBuilder();
			selectMenu
			.append("	select menu_name, menu_price, menu_type, menu_activity")
			.append("	from menu	");
			
			// �˻� ���� �Է½� ������ �߰�
			if(!"".equals(smVO.getSelectData()) && !(smVO.getSelectData() == null)) {
				if ("menu_price".equals(smVO.getSelectType())) {	//�˻������� ������ ���
					selectMenu
					.append("	where menu_price = ?	");
				} else {	//�˻� ������ ������ �ƴ� ���
					selectMenu
					.append(" where ")
					.append(smVO.getSelectType())
					.append(" like '%'||?||'%'");
				}//end else
			}//end if
			
			selectMenu
			.append("	order by menu_type desc, menu_activity desc	");
			
			//������ ���� ��ü ���
			pstmt = con.prepareStatement(selectMenu.toString());
			
			//���ε� ������ �� �ֱ�
			if(!"".equals(smVO.getSelectData()) && !(smVO.getSelectData() == null)) {
				pstmt.setString(1, smVO.getSelectData());
			}//end if
			
			//���� ���� �� ��� ���
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				selectMenuList.add(new MenuListVO(rs.getString("menu_name"), rs.getString("menu_type"),
						rs.getString("menu_activity"), rs.getInt("menu_price")));
			}//end while
			
		} finally {
			if(rs!=null) { rs.close(); }//end if
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end catch
		
		return selectMenuList;
	} // selectMenu()
	
	
	public MenuDetailVO selectMenuDetail(String menu_name) throws SQLException {
		MenuDetailVO mdVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			con = getConn();
			
			StringBuilder selectMenuDetail = new StringBuilder();
			selectMenuDetail
			.append("	select menu_name, menu_type, menu_price, menu_img, menu_activity, menu_input_date ")
			.append("	from menu ")
			.append("	where menu_name=? ");
		
			pstmt = con.prepareStatement(selectMenuDetail.toString());
			
			pstmt.setString(1, menu_name);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mdVO = new MenuDetailVO(rs.getString("menu_name"), rs.getString("menu_type"), rs.getString("menu_img"), rs.getString("menu_activity"), rs.getString("menu_input_date"), rs.getInt("menu_price"));
			}
		
		}finally {
			if(rs!=null) { rs.close(); }//end if
			if(pstmt!=null) { pstmt.close(); }//end if
			if(con!=null) { con.close(); }//end if
		}//end finally
		
		return mdVO;
	} // selectMenuDetail()
	
	//2020-08-12 �赵�� return boolean -> int
		public int updateMenu(UpdateMenuVO mVO) throws SQLException {
			int updateMenuFlag = 0;
			
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = getConn();
				
				StringBuilder updateMenu = new StringBuilder();
				updateMenu
				.append("	update menu ")
				.append("	set menu_type=?, menu_price=?, menu_img=?, menu_activity=?, admin_id=? ")
				.append("	where menu_name=? ");
				
				pstmt = con.prepareStatement(updateMenu.toString());
				
				pstmt.setString(1, mVO.getMenu_type());
				pstmt.setInt(2, mVO.getMenu_price());
				pstmt.setString(3, mVO.getMenu_img());
				pstmt.setString(4, mVO.getMenu_activity());	
				pstmt.setString(5, mVO.getAdmin_id());
				pstmt.setString(6, mVO.getMenu_name());

				
				updateMenuFlag = pstmt.executeUpdate();
				
			}finally {
				if(pstmt!=null) { pstmt.close(); }//end if
				if(con!=null) { con.close(); }//end if
			}
			
			return updateMenuFlag;
		} // updateMenu()
	
} // class