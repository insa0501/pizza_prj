package pizza.admin.vo;

public class UpdateResignVO {
	private String user_id, user_resdata, user_resign_date;
	// 2020-08-08 ±èÈ«¼® - º¯¼ö¸í¼öÁ¤
	// resign_data -> user_resdata
	public UpdateResignVO() {
		// TODO Auto-generated constructor stub
	}

	public UpdateResignVO(String user_id, String user_resdata, String user_resign_date) {
		super();
		this.user_id = user_id;
		this.user_resdata = user_resdata;
		this.user_resign_date = user_resign_date;
	}

	public String getUser_id() {
		return user_id;
	}

	public String getUser_resdata() {
		return user_resdata;
	}

	public String getUser_resign_date() {
		return user_resign_date;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setUser_resdata(String user_resdata) {
		this.user_resdata = user_resdata;
	}

	public void setUser_resign_date(String user_resign_date) {
		this.user_resign_date = user_resign_date;
	}

} // class