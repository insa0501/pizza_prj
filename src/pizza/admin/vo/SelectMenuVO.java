package pizza.admin.vo;

public class SelectMenuVO {
	private String selectType, selectData;
	
	public SelectMenuVO() {
		// TODO Auto-generated constructor stub
	}

	public SelectMenuVO(String selectType, String selectData) {
		super();
		this.selectType = selectType;
		this.selectData = selectData;
	}

	public String getSelectType() {
		return selectType;
	}

	public String getSelectData() {
		return selectData;
	}

	public void setSelectType(String selectType) {
		this.selectType = selectType;
	}

	public void setSelectData(String selectData) {
		this.selectData = selectData;
	}
	
} // class