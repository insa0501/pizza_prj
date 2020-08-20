package pizza.admin.vo;

public class MenuListVO {
	private String menu_name, menu_type, menu_activity, menu_price;
	
	public MenuListVO() {
		// TODO Auto-generated constructor stub
	}

	public MenuListVO(String menu_name, String menu_type, String menu_activity, String menu_price) {
		super();
		this.menu_name = menu_name;
		this.menu_type = menu_type;
		this.menu_activity = menu_activity;
		this.menu_price = menu_price;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public String getMenu_type() {
		return menu_type;
	}

	public String getMenu_activity() {
		return menu_activity;
	}

	public String getMenu_price() {
		return menu_price;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public void setMenu_type(String menu_type) {
		this.menu_type = menu_type;
	}

	public void setMenu_activity(String menu_activity) {
		this.menu_activity = menu_activity;
	}

	public void setMenu_price(String menu_price) {
		this.menu_price = menu_price;
	}
	
	
} // class