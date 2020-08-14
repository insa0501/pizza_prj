package pizza.admin.vo;

public class MenuDetailVO {
	private String menu_name, menu_type, menu_img, menu_activity, menu_input_date;
	private int menu_price;
	
	public MenuDetailVO() {
	}

	public MenuDetailVO(String menu_name, String menu_type, String menu_img, String menu_activity,
			String menu_input_date, int menu_price) {
		super();
		this.menu_name = menu_name;
		this.menu_type = menu_type;
		this.menu_img = menu_img;
		this.menu_activity = menu_activity;
		this.menu_input_date = menu_input_date;
		this.menu_price = menu_price;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public String getMenu_type() {
		return menu_type;
	}

	public String getMenu_img() {
		return menu_img;
	}

	public String getMenu_activity() {
		return menu_activity;
	}

	public String getMenu_input_date() {
		return menu_input_date;
	}

	public int getMenu_price() {
		return menu_price;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public void setMenu_type(String menu_type) {
		this.menu_type = menu_type;
	}

	public void setMenu_img(String menu_img) {
		this.menu_img = menu_img;
	}

	public void setMenu_activity(String menu_activity) {
		this.menu_activity = menu_activity;
	}

	public void setMenu_input_date(String menu_input_date) {
		this.menu_input_date = menu_input_date;
	}

	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}
	
} // class