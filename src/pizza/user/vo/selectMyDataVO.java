package pizza.user.vo;

public class selectMyDataVO {

	private String user_id, user_pass;
	// 2020-08-08 ±èÈ«¼® - º¯¼ö¸í¼öÁ¤
	// id -> user_id / pass -> user_pass
	public selectMyDataVO() {
		super();
	}

	public selectMyDataVO(String user_id, String user_pass) {
		super();
		this.user_id = user_id;
		this.user_pass = user_pass;
	}

	public String getUser_id() {
		return user_id;
	}

	public String getUser_pass() {
		return user_pass;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}

} // class