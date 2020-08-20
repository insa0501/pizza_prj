package pizza.admin.vo;

public class AdminOrderVO {

	private String order_no, user_id, menu_name, order_status, order_date, order_price;
	// 2020-08-08 김홍석 - 변수명수정 및 그에따른 생성자와 getter setter 메소드명 변경
	// orderNo -> order_no / status -> order_status
	private int orderCnt;
	// 2020-08-10 임성은 - 콤비네이션 피자 외 3개와 같이 주문번호별 메뉴 수량 조회를 위한 cnt변수 추가
	
	public AdminOrderVO() {
		super();
	}

	public AdminOrderVO(String order_no, String user_id, String menu_name, String order_status, String order_date,
			String order_price, int orderCnt) {
		super();
		this.order_no = order_no;
		this.user_id = user_id;
		this.menu_name = menu_name;
		this.order_status = order_status;
		this.order_date = order_date;
		this.order_price = order_price;
		this.orderCnt = orderCnt;
	}

	public String getOrder_no() {
		return order_no;
	}

	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public String getOrder_status() {
		return order_status;
	}

	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}

	public String getOrder_date() {
		return order_date;
	}

	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}

	public String getOrder_price() {
		return order_price;
	}

	public void setOrder_price(String order_price) {
		this.order_price = order_price;
	}

	public int getorderCnt() {
		return orderCnt;
	}

	public void setorderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}

} // class
