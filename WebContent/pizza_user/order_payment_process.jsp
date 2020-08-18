<%@page import="pizza.admin.vo.OrderMenuVO"%>
<%@page import="pizza.dao.OrderDAO"%>
<%@page import="pizza.user.vo.OrderUserInfoVO"%>
<%@page import="pizza.user.vo.OrderVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    info="결제처리 (DB insert) 를 하는 페이지"%>
<%
	// 2020-08-17 김홍석 코드 추가
	
	// 세션이 없거나 세션만료 시 메인화면으로
	String user_id = (String) session.getAttribute("user_id");
	System.out.println(user_id);
	//if (user_id == null) {
	//	response.sendRedirect("main.jsp");
	//	return;
	//} // end if
	
// 결제시 추가 되어야 할 항목
// order_list
// order_no - 시퀀스 (기본키), order_date - sysdate, user_id, user_zipcode, user_addr1, user_addr2
// user_phone, order_price, order_status, order_pay, user_ip - getHostName()?
	
	String orderNo = "22"; // 주문번호를 저장할 변수
	
	// 세션에 넣은 유저 정보를 받는다.
	OrderUserInfoVO ouiVO = (OrderUserInfoVO) session.getAttribute("ouiVO");
	out.println(ouiVO + "<br/>");
	// 유저의 주문 IP
	String user_ip = request.getRemoteAddr();
	out.println("user_ip : " + user_ip + "<br/>");
	// 주문 총액
	int order_price = Integer.parseInt(request.getParameter("order_price"));
	out.println("order_price : " + order_price + "<br/>");
	// 주문 방법
	String order_pay = request.getParameter("order_payment");
	out.println("order_pay : " + order_pay + "<br/>");
	// 메뉴 갯수 - 배열의 크기로 반복문을 사용하기 위함
	int menuLeng = request.getParameterValues("menuName").length;
	out.println("menuLeng : " + menuLeng + "<br/>");
	
	/* if (menuCnt == 0) { // 파라미터로 받은 메뉴가 없다면
		response.sendRedirect("main.jsp");
		return;
	} */ // end if
	
	// 파라미터로 받은 메뉴이름과 수량, 가격을 배열에 저장
	String[] menuName = request.getParameterValues("menuName");
	String[] menuCnt = request.getParameterValues("menuCnt");
	String[] menuPrice = request.getParameterValues("menuPrice");
	
	OrderMenuVO omVO = null;
	
	//OrderDAO oDAO = OrderDAO.getInstance();
	
	// insertOrder 를 통해 orderNo를 반환받는다.
	//orderNo = oDAO.insertOrder(new OrderVO("test1", user_ip, order_pay, order_price, ouiVO));
	
	if (!"".equals(orderNo)) { // orderNo가 존재할 때 실행 
		for (int i=0; i < menuLeng; i++) {
			// order_menu 테이블에 추가
			omVO = new OrderMenuVO(orderNo, menuName[i], Integer.parseInt(menuPrice[i]), Integer.parseInt(menuCnt[i]));
			out.println(orderNo + "(" + menuName[i] + ") => " + omVO + "<br/>");
			// oDAO.insertOrderMenu(omVO);
		} // end for
	} // end if
	
// order_menu
// menu_name - (menu table)(기본키), order_no -(order_list table)(기본키)
// order_menu_price - cnt * price, order_menu_cnt - cnt 
%>   
