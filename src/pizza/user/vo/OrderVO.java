package pizza.user.vo;

public class OrderVO {
	private String user_id, order_status, user_ip;
	private int order_price;
	private OrderUserInfoVO oulVO;
	// 2020-08-08 ±èÈ«¼® - º¯¼ö¸í¼öÁ¤
	// order_ip -> user_ip / orderPrice -> order_price
	
	public OrderVO() {
		// TODO Auto-generated constructor stub
	}

	public OrderVO(String user_id, String order_status, String user_ip, int order_price, OrderUserInfoVO oulVO) {
		super();
		this.user_id = user_id;
		this.order_status = order_status;
		this.user_ip = user_ip;
		this.order_price = order_price;
		this.oulVO = oulVO;
	}

	public String getUser_id() {
		return user_id;
	}

	public String getOrder_status() {
		return order_status;
	}

	public String getUser_ip() {
		return user_ip;
	}

	public int getOrder_price() {
		return order_price;
	}

	public OrderUserInfoVO getOulVO() {
		return oulVO;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}

	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}

	public void setOulVO(OrderUserInfoVO oulVO) {
		this.oulVO = oulVO;
	}


	
} // class