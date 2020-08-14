package pizza.user.vo;

public class MainMenuVO {
	private String menu_img, menu_name;
	private int menu_price;
	
	public MainMenuVO() {
		// TODO Auto-generated constructor stub
	}

	public MainMenuVO(String menu_img, String menu_name, int menu_price) {
		super();
		this.menu_img = menu_img;
		this.menu_name = menu_name;
		this.menu_price = menu_price;
	}

	public String getMenu_img() {
		return menu_img;
	}

	public String getMenu_name() {
		return menu_name;
	}

	public int getMenu_price() {
		return menu_price;
	}

	public void setMenu_img(String menu_img) {
		this.menu_img = menu_img;
	}

	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}

	public void setMenu_price(int menu_price) {
		this.menu_price = menu_price;
	}
	
	
} // class