package pizza.user.vo;

import java.util.List;

import pizza.admin.vo.OrderMenuVO;

public class UserOrderVO {
	private String user_id, order_status, order_date;
	private int menu_order_price;
	private List<OrderMenuVO> menuListVO;
	// 2020-08-08 ±èÈ«¼® - º¯¼ö¸í¼öÁ¤
	// status -> order_status / orderPrice -> menu_order_price
	// 2020-08-08 ±èÈ«¼® - º¯¼ö Ãß°¡
	// user_id
	
	public UserOrderVO() {
	}

	public UserOrderVO(String user_id, String order_status, String order_date, int menu_order_price,
			List<OrderMenuVO> menuListVO) {
		super();
		this.user_id = user_id;
		this.order_status = order_status;
		this.order_date = order_date;
		this.menu_order_price = menu_order_price;
		this.menuListVO = menuListVO;
	}

	public String getUser_id() {
		return user_id;
	}

	public String getOrder_status() {
		return order_status;
	}

	public String getOrder_date() {
		return order_date;
	}

	public int getMenu_order_price() {
		return menu_order_price;
	}

	public List<OrderMenuVO> getMenuListVO() {
		return menuListVO;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public void setMenu_order_price(int menu_order_price) {
		this.menu_order_price = menu_order_price;
	}

	public void setMenuListVO(List<OrderMenuVO> menuListVO) {
		this.menuListVO = menuListVO;
	}

}// class
