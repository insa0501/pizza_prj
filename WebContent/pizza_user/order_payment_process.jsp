<%@page import="pizza.user.vo.OrderMenuVO"%>
<%@page import="pizza.dao.OrderDAO"%>
<%@page import="pizza.user.vo.OrderUserInfoVO"%>
<%@page import="pizza.user.vo.OrderVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" trimDirectiveWhitespaces="true"
    info=""%>
<%

	if ("POST".equals(request.getMethod())) {
		request.setCharacterEncoding("UTF-8");
	} // end if

	String user_id = (String) session.getAttribute("user_id");
	if (user_id == null) {
		response.sendRedirect("main.jsp");
		return;
	} // end if
	
	
	String orderNo = ""; 
	

	OrderUserInfoVO ouiVO = (OrderUserInfoVO) session.getAttribute("ouiVO");
	//out.println(ouiVO + "<br/>");

	String user_ip = request.getRemoteAddr();
	//out.println("user_ip : " + user_ip + "<br/>");
	int order_price = 0;
	int menuLeng = 0;
	
	try {

		order_price = Integer.parseInt(request.getParameter("order_price"));
		//out.println("order_price : " + order_price + "<br/>");
	} catch (NumberFormatException nfe) {
		nfe.printStackTrace();
	} // end catch
	
	try {

		menuLeng = request.getParameterValues("menuName").length;
		//out.println("menuLeng : " + menuLeng + "<br/>");
	} catch (NullPointerException npe) {
		npe.printStackTrace();

		response.sendRedirect("main.jsp");
		return;
	}// end catch

	String order_pay = request.getParameter("order_payment");
	//out.println("order_pay : " + order_pay + "<br/>");
	

	String[] menuName = request.getParameterValues("menuName");
	String[] menuCnt = request.getParameterValues("menuCnt");
	String[] menuPrice = request.getParameterValues("menuPrice");
	
	OrderMenuVO omVO = null;
	
	OrderDAO oDAO = OrderDAO.getInstance();
	

	orderNo = oDAO.insertOrder(new OrderVO(user_id, user_ip, order_pay, order_price, ouiVO));
	
	if (!"".equals(orderNo)) { 
		for (int i=0; i < menuLeng; i++) {
			omVO = new OrderMenuVO(orderNo, menuName[i], Integer.parseInt(menuPrice[i]), Integer.parseInt(menuCnt[i]));
			//out.println(orderNo + "(" + menuName[i] + ") => " + omVO + "<br/>");
			oDAO.insertOrderMenu(omVO);
		} // end for
	} // end if
	
%>   
<script type="text/javascript">
	
	alert("결제완료");
	location.replace("http://localhost/pizza_prj/pizza_user/main.jsp");
</script>
