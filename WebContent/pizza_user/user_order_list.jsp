<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="pizza.dao.MemberDAO"%>
<%@page import="pizza.user.vo.SelectOrderListVO"%>
<%@page import="pizza.user.vo.UserOrderVO"%>
<%@page import="java.util.List"%>
<%@page import="pizza.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="마이페이지-주문내역"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	MemberDAO mDAO = MemberDAO.getInstance();
	String user_id = (String)session.getAttribute("user_id");
	
	if(user_id == null){
		response.sendRedirect("http://localhost/pizza_prj/pizza_user/user_login.jsp");
		return;
	}
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>🙋‍♀️my pa‍ge</title>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    
	<link rel="stylesheet" type="text/css" href="../common/css/my_page_menu.css">
    <link rel="stylesheet" href="../common/css/common_header_footer.css">
	
<script type="text/javascript">
	$(function(){
		
		
	})//ready
	
	<%
		Calendar cal=null;
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String strDate = null;
		String endDate = null;
	%>

</script>


</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../common/jsp/common_header.jsp"/>
	<div class="container">
		<div class="my_page_menu">
			<div class="my_page_title">마이페이지</div>
			<div class="menu_content">
				<div class="menu_item"><a href="user_order_list.jsp">주문내역</a></div>
				<div class="menu_item"><a href="user_info_check.jsp">회원정보 수정</a></div>
			</div>
		</div>
		
		<div id="main_content" class="main_content">
			<div class="page_title">주문 내역</div>   
			<div class="select_day">
<!-- 		   		<a href="user_order_list.jsp?tempDate=today" id="today" class="btn_day" onclick="today()">오늘</a>    
		   		<a href="user_order_list.jsp?tempDate=a_month" id="a_month" class="btn_day" onclick="a_month()">1개월</a>
		   		<a href="user_order_list.jsp?tempDate=three_month" id="three_month" class="btn_day" onclick="three_month()">3개월</a>
		   		<a href="user_order_list.jsp?tempDate=all" id="all" class="btn_day">전체</a>  -->
		   		<a href="user_order_list.jsp?tempDate=today" id="today" class="btn_day ${ param.tempDate=='today'?' active':''}" >오늘</a>    
		   		<a href="user_order_list.jsp?tempDate=a_month" id="a_month" class="btn_day ${ param.tempDate=='a_month'?' active':''}">1개월</a>
		   		<a href="user_order_list.jsp?tempDate=three_month" id="three_month" class="btn_day ${ param.tempDate=='three_month'?' active':''}">3개월</a>
		   		<a href="user_order_list.jsp?tempDate=all" id="all" class="btn_day ${ param.tempDate=='all'?' active':''}">전체</a> 
		    </div>
	
			<div>
				<% 
				
				String tempDate = request.getParameter("tempDate");
				
				//System.out.println("tempDate "+tempDate);
				
				if(tempDate == null){
					%>
					<div class="order_box">조회를 원하시는 기간을 선택해주세요</div>
					<%
				}else{
				
					if("today".equals(tempDate)){
						cal = Calendar.getInstance();
						cal.setTime(new Date());
						strDate = format.format(cal.getTime());
						//System.out.println("시작 시간"+strDate);
						cal.add(Calendar.DATE,1);
						endDate = format.format(cal.getTime());
						//System.out.println("끝 시간"+endDate);
						
					}//end if
					
					if("a_month".equals(tempDate)){
						cal = Calendar.getInstance();
					
						cal.setTime(new Date());
						cal.add(Calendar.DATE, 1);//오늘까지로 하면 오늘 00시 00분까지여서 당일의 결과를 얻을 수 없음
						endDate = format.format(cal.getTime());
						
						cal.setTime(new Date());
						cal.add(Calendar.MONTH,-1);
						strDate = format.format(cal.getTime());
					}//end if
					
					if("three_month".equals(tempDate)){
						cal = Calendar.getInstance();
						cal.setTime(new Date());
						cal.add(Calendar.DATE, 1);//오늘까지로 하면 오늘 00시 00분까지여서 당일의 결과를 얻을 수 없음
						
						endDate = format.format(cal.getTime());
						
						cal.setTime(new Date());
						cal.add(Calendar.MONTH,-3);
						strDate = format.format(cal.getTime());
					}//end if
					/* 
					pageContext.setAttribute("strDate", strDate);
					pageContext.setAttribute("endDate", endDate); */	
						
					SelectOrderListVO solVO = new SelectOrderListVO(user_id, strDate, endDate);
					List<UserOrderVO> list = mDAO.selectOrderList(solVO);
/* 					System.out.println("strDate "+strDate);
					System.out.println("endDate "+endDate); */
					pageContext.setAttribute("orderList", list);
				%>
				<c:forEach var="order" items="${orderList}">
					<div class="order_box"> 
						<c:set var="i" value="${0}"/>
							<c:forEach var="order_menu" items="${order.menuListVO}">
								<c:set var="i" value="${i+1}"/>
											   
								<c:if test="${i eq 1 }">
									<div class="order no">NO.<c:out value="${order_menu.order_no}"/> (<c:out value="${order.order_status}"/>)</div>
									<div class="order date"><c:out value="${order.order_date.substring(0,(order.order_date.length())-5)}"/></div><%--value="${해당 vo.input_date}" --%> 
									<!-- <div class="order status"></div> --><%--status value="${해당 vo.status}"--%>
									<div class="order price"><c:out value="${order.menu_order_price}"/>원</div><%-- price value="${해당 vo.price}" --%>
								</c:if> 
								<div class="order menu"><c:out value="${order_menu.menu_name}"/> * <c:out value="${order_menu.order_menu_cnt }"/></div><%--value="{해당 vo.menu}" 메뉴는 리스트에 들어있음 --%> 
							</c:forEach>
					</div>
				</c:forEach>
			  <%
				}//end else
			  %>
	  	</div>
	</div>
</div>
	<!-- 푸터 -->
	<jsp:include page="../common/jsp/common_footer.jsp"/>
    
</body>
</html>