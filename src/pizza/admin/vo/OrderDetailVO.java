package pizza.admin.vo;

import java.util.List;

public class OrderDetailVO {
	private String order_date, user_id, user_zipcode, user_addr1, user_addr2, user_phone,
					order_status, order_pay, user_ip, order_price;
	// 2020-08-08 ±èÈ«¼® - º¯¼ö¸í¼öÁ¤
	// orderNo -> order_no
	// id -> user_id / zipcode -> user_zipcode / phone -> user_phone / 
	// addr1 -> user_addr1 / addr2 -> user_addr2 / status -> order_status
	// payment -> order_pay / order_ip -> user_ip
	private List<OrderMenuListVO> menuListVO;
	
	
	public OrderDetailVO() {
	}

	public OrderDetailVO(String order_date, String user_id, String user_zipcode, String user_addr1,
			String user_addr2, String user_phone, String order_status, String order_pay, String user_ip, String order_price,
			List<OrderMenuListVO> menuListVO) {
		super();
		this.order_date = order_date;
		this.user_id = user_id;
		this.user_zipcode = user_zipcode;
		this.user_addr1 = user_addr1;
		this.user_addr2 = user_addr2;
		this.user_phone = user_phone;
		this.order_status = order_status;
		this.order_pay = order_pay;
		this.user_ip = user_ip;
		this.order_price = order_price;
		this.menuListVO = menuListVO;
	}

	public String getOrder_date() {
		return order_date;
	}

	public String getUser_id() {
		return user_id;
	}

	public String getUser_zipcode() {
		return user_zipcode;
	}

	public String getUser_addr1() {
		return user_addr1;
	}

	public String getUser_addr2() {
		return user_addr2;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public String getOrder_status() {
		return order_status;
	}

	public String getOrder_pay() {
		return order_pay;
	}

	public String getUser_ip() {
		return user_ip;
	}

	public String getorder_price() {
		return order_price;
	}

	public List<OrderMenuListVO> getMenuListVO() {
		return menuListVO;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setUser_zipcode(String user_zipcode) {
		this.user_zipcode = user_zipcode;
	}

	public void setUser_addr1(String user_addr1) {
		this.user_addr1 = user_addr1;
	}

	public void setUser_addr2(String user_addr2) {
		this.user_addr2 = user_addr2;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	public void setOrder_pay(String order_pay) {
		this.order_pay = order_pay;
	}

	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}

	public void setorder_price(String order_price) {
		this.order_price = order_price;
	}

	public void setMenuListVO(List<OrderMenuListVO> menuListVO) {
		this.menuListVO = menuListVO;
	}

	
} // class
