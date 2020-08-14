package pizza.admin.vo;

public class ResignMemberVO {
	private String user_resdata, user_resign_date;
	// 2020-08-08 김홍석 - 변수명수정
	// member_status -> user_status / resign_data -> user_resdata
	// 2020-08-11 임성은 변수추가 및 제거
	// user_resign_date 추가
	// user_id, user_status 제거
	
	public ResignMemberVO() {
	}
	
	public ResignMemberVO(String user_resdata, String user_resign_date) {
		this.user_resdata = user_resdata;
		this.user_resign_date = user_resign_date;
	}

	public String getUser_resdata() {
		return user_resdata;
	}

	public void setUser_resdata(String user_resdata) {
		this.user_resdata = user_resdata;
	}

	public String getUser_resign_date() {
		return user_resign_date;
	}

	public void setUser_resign_date(String user_resign_date) {
		this.user_resign_date = user_resign_date;
	}
	
} // class