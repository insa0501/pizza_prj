package pizza.admin.vo;

public class UpdateOrderVO {
	private String order_no, order_status;
	// 2020-08-08 ±èÈ«¼® - º¯¼ö¸í¼öÁ¤
	// orderNo -> order_no / status -> order_status
	
	public UpdateOrderVO() {
		// TODO Auto-generated constructor stub
	}

	public UpdateOrderVO(String order_no, String order_status) {
		super();
		this.order_no = order_no;
		this.order_status = order_status;
	}

	public String getOrder_no() {
		return order_no;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	
} // class