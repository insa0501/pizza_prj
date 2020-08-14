package pizza.user.vo;

public class InsertMemberVO {
	private String user_id, user_pass, user_name, user_phone, user_zipcode, user_addr1, user_addr2, user_ip;
	// 2020-08-08 ±èÈ«¼® - º¯¼ö¸í¼öÁ¤
	// id -> user_id / pass -> user_pass / name -> user_name 
	// phone -> user_phone / zipcode -> user_zipcode / addr1 -> user_addr1
	// addr2 -> user_addr2 
	
	public InsertMemberVO() {

	}

	public InsertMemberVO(String user_id, String user_pass, String user_name, String user_phone, String user_zipcode,
			String user_addr1, String user_addr2, String user_ip) {
		super();
		this.user_id = user_id;
		this.user_pass = user_pass;
		this.user_name = user_name;
		this.user_phone = user_phone;
		this.user_zipcode = user_zipcode;
		this.user_addr1 = user_addr1;
		this.user_addr2 = user_addr2;
		this.user_ip = user_ip;
	}

	public String getUser_id() {
		return user_id;
	}

	public String getUser_pass() {
		return user_pass;
	}

	public String getUser_name() {
		return user_name;
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

	public String getUser_ip() {
		return user_ip;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
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

	public void setUser_ip(String user_ip) {
		this.user_ip = user_ip;
	}

} // class