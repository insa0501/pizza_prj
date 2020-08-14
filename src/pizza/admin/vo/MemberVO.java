package pizza.admin.vo;

public class MemberVO {

	private String user_id, user_name, user_phone, user_addr1, user_status;
	// 2020-08-08 김홍석 - 변수명수정
	// name -> user_name / phone -> user_phone / zipcode -> user_zipcode 
	// addr1 -> user_addr1 / addr2 -> user_addr2 / member_status -> user_status
	// 2020-08-10 임성은 - 변수제거
	// user_zipcode, user_addr2 제거
	
	
	public MemberVO() {

	}

	public MemberVO(String user_id, String user_name, String user_addr1, String user_phone,
			String user_status) {
		super();
		this.user_id = user_id;
		this.user_name = user_name;
		this.user_addr1 = user_addr1;
		this.user_phone = user_phone;
		this.user_status = user_status;
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

	public String getUser_addr1() {
		return user_addr1;
	}

	public String getUser_status() {
		return user_status;
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

	public void setUser_addr1(String user_addr1) {
		this.user_addr1 = user_addr1;
	}

	public void setUser_status(String user_status) {
		this.user_status = user_status;
	}

} // class