package pizza.admin.vo;

/**
 * 주문한 메뉴 정보를 받는 VO 
 * @author owner
 *
 */
public class OrderMenuVO {

	private String order_no, menu_name;
	private int order_menu_price, order_menu_cnt;
	// 2020-08-08 김홍석 - 변수명수정
	// menu_price -> order_menu_price / cnt -> order_menu_cnt
	
	public OrderMenuVO() {
	}
	public OrderMenuVO(String order_no, String menu_name, int order_menu_price, int order_menu_cnt) {
		super();
		this.order_no = order_no;
		this.menu_name = menu_name;
		this.order_menu_price = order_menu_price;
		this.order_menu_cnt = order_menu_cnt;
	}
	public String getOrder_no() {
		return order_no;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public int getOrder_menu_price() {
		return order_menu_price;
	}
	public int getOrder_menu_cnt() {
		return order_menu_cnt;
	}
	public void setOrder_no(String order_no) {
		this.order_no = order_no;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public void setOrder_menu_price(int order_menu_price) {
		this.order_menu_price = order_menu_price;
	}
	public void setOrder_menu_cnt(int order_menu_cnt) {
		this.order_menu_cnt = order_menu_cnt;
	}
	
	
} // class
