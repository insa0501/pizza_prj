package pizza.user.vo;

public class OrderVO {
	private String user_id, user_ip, order_pay;
	private int order_price;
	private OrderUserInfoVO ouiVO;
	// 2020-08-08 ±èÈ«¼® - º¯¼ö¸í¼öÁ¤
	// order_ip -> user_ip / orderPrice -> order_price
	
	public OrderVO() {
		// TODO Auto-generated constructor stub
	}
	public OrderVO(String user_id, String user_ip, String order_pay, int order_price, OrderUserInfoVO ouiVO) {
		super();
		this.user_id = user_id;
		this.user_ip = user_ip;
		this.order_pay = order_pay;
		this.order_price = order_price;
		this.ouiVO = ouiVO;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_ip() {
		return user_ip;
	}
	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}
	public String getOrder_pay() {
		return order_pay;
	}
	public void setOrder_pay(String order_pay) {
		this.order_pay = order_pay;
	}
	public int getOrder_price() {
		return order_price;
	}
	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}
	public OrderUserInfoVO getOuiVO() {
		return ouiVO;
	}
	public void setOuiVO(OrderUserInfoVO ouiVO) {
		this.ouiVO = ouiVO;
	}



	
} // class