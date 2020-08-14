package pizza.user.vo;

public class UserInfoVO {
	private String user_phone, user_zipcode, user_addr1, user_addr2;
	// 2020-08-08 ±èÈ«¼® - º¯¼ö¸í¼öÁ¤
	// phone -> user_phone / zipcode -> user_zipcode
	// addr1 -> user_addr1 / addr2 -> user_addr2
	public UserInfoVO() {
	}

	public UserInfoVO(String user_phone, String user_zipcode, String user_addr1, String user_addr2) {
		super();
		this.user_phone = user_phone;
		this.user_zipcode = user_zipcode;
		this.user_addr1 = user_addr1;
		this.user_addr2 = user_addr2;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public String getUser_zipcode() {
		return user_zipcode;
	}

	public String getUser_addr1() {
		return user_addr1;
	}

	public String getUser_addr2() {
		return user_addr2;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

	public void setUser_zipcode(String user_zipcode) {
		this.user_zipcode = user_zipcode;
	}

	public void setUser_addr1(String user_addr1) {
		this.user_addr1 = user_addr1;
	}

	public void setUser_addr2(String user_addr2) {
		this.user_addr2 = user_addr2;
	}

} // class