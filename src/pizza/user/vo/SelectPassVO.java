package pizza.user.vo;

public class SelectPassVO {
	private String user_id, user_name, user_phone;
	// 2020-08-08 ±èÈ«¼® - º¯¼ö¸í¼öÁ¤
	// id -> user_id / name -> user_name / phone -> user_phone
	public SelectPassVO() {
	}

	public SelectPassVO(String user_id, String user_name, String user_phone) {
		super();
		this.user_id = user_id;
		this.user_name = user_name;
		this.user_phone = user_phone;
	}

	public String getUser_id() {
		return user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	
	
} // class