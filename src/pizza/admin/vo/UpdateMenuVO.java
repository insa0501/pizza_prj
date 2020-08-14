package pizza.admin.vo;

public class UpdateMenuVO {
	private String menu_name, menu_type, menu_img, menu_activity, admin_id;
	private int menu_price;
	
	public UpdateMenuVO() {
	
	}

	public UpdateMenuVO(String menu_name, String menu_type, String menu_img, String menu_activity, String admin_id,
			int menu_price) {
		super();
		this.menu_name = menu_name;
		this.menu_type = menu_type;
		this.menu_img = menu_img;
		this.menu_activity = menu_activity;
		this.admin_id = admin_id;
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

	public String getAdmin_id() {
		return admin_id;
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

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}

} // class