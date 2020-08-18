<%@page import="pizza.admin.vo.OrderMenuVO"%>
<%@page import="pizza.dao.OrderDAO"%>
<%@page import="pizza.user.vo.OrderUserInfoVO"%>
<%@page import="pizza.user.vo.OrderVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    info="결제처리 (DB insert) 를 하는 페이지"%>
<%
	// test 주석
	String user_id = (String) session.getAttribute("user_id");
	//System.out.println("user_id : " + user_id);
	// 세션이 없거나 세션만료 시 메인화면으로
	//if (user_id == null) {
	//	response.sendRedirect("main.jsp");
	//	return;
	//} // end if
	
	
	String orderNo = ""; // 주문번호를 저장할 변수
	
	// 세션에 넣은 유저 정보를 받는다.
	OrderUserInfoVO ouiVO = (OrderUserInfoVO) session.getAttribute("ouiVO");
	//out.println(ouiVO + "<br/>");
	// 유저의 주문 IP
	String user_ip = request.getRemoteAddr();
	//out.println("user_ip : " + user_ip + "<br/>");
	int order_price = 0;
	int menuLeng = 0;
	
	try {
		// 주문 총액
		order_price = Integer.parseInt(request.getParameter("order_price"));
		//out.println("order_price : " + order_price + "<br/>");
	} catch (NumberFormatException nfe) {
		nfe.printStackTrace();
	} // end catch
	
	try {
		// 메뉴 갯수 - 배열의 크기로 반복문을 사용하기 위함
		menuLeng = request.getParameterValues("menuName").length;
		//out.println("menuLeng : " + menuLeng + "<br/>");
	} catch (NullPointerException npe) {
		npe.printStackTrace();
		//out.println("선택된 메뉴가 없습니다.");
		response.sendRedirect("main.jsp");
		return;
	}// end catch
	// 주문 방법
	String order_pay = request.getParameter("order_payment");
	//out.println("order_pay : " + order_pay + "<br/>");
	
	// 파라미터로 받은 메뉴이름과 수량, 가격을 배열에 저장
	String[] menuName = request.getParameterValues("menuName");
	String[] menuCnt = request.getParameterValues("menuCnt");
	String[] menuPrice = request.getParameterValues("menuPrice");
	
	OrderMenuVO omVO = null;
	
	OrderDAO oDAO = OrderDAO.getInstance();
	
	// insertOrder 를 통해 orderNo를 반환받는다.
	orderNo = oDAO.insertOrder(new OrderVO(user_id, user_ip, order_pay, order_price, ouiVO));
	
	if (!"".equals(orderNo)) { // orderNo가 존재할 때 실행 
		for (int i=0; i < menuLeng; i++) {
			// order_menu 테이블에 추가
			omVO = new OrderMenuVO(orderNo, menuName[i], Integer.parseInt(menuPrice[i]), Integer.parseInt(menuCnt[i]));
			//out.println(orderNo + "(" + menuName[i] + ") => " + omVO + "<br/>");
			oDAO.insertOrderMenu(omVO);
		} // end for
	} // end if
	
%>   
<script type="text/javascript">
	
	alert("결제가 완료 되었습니다.");
	location.replace("http://localhost/pizza_prj/pizza_user/main.jsp");
</script>
