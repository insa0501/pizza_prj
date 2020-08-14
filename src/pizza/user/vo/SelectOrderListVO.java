package pizza.user.vo;

public class SelectOrderListVO {
	private String user_id, strDate, endDate;
	
	public SelectOrderListVO() {
	}

	public SelectOrderListVO(String user_id, String strDate, String endDate) {
		super();
		this.user_id = user_id;
		this.strDate = strDate;
		this.endDate = endDate;
	}

	public String getUser_id() {
		return user_id;
	}

	public String getStrDate() {
		return strDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public void setStrDate(String strDate) {
		this.strDate = strDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	
} // class