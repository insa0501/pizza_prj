package pizza.user.vo;

public class SelectIdVO {
	private String user_name, user_phone;
	// 2020-08-08 ±èÈ«¼® - º¯¼ö¸í¼öÁ¤
	// name -> user_name / phone -> user_phone
	public SelectIdVO() {
	}

	public SelectIdVO(String user_name, String user_phone) {
		super();
		this.user_name = user_name;
		this.user_phone = user_phone;
	}

	public String getUser_name() {
		return user_name;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	
	
} // class
