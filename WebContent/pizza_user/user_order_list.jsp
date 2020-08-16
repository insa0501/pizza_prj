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
<title>Insert title here</title>



   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    
<link rel="stylesheet" type="text/css" href="http://localhost/pizza_prj/common/css/common_footer.css">
<link rel="stylesheet" type="text/css" href="http://localhost/pizza_prj/pizza_user/css/main_css1.css">
<link rel="stylesheet" type="text/css" href="http://localhost/pizza_prj/common/css/my_page_menu.css">
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
<div class="header">
	<section class="header">
		<div class="header_top"></div>
		<div class="header_logoImg">
			<img src="http://localhost/pizza_prj/common/images/logo.png">
		</div>
		<div class="header_nav" id="header_nav">
			<div>
				<a href="#pizza_divider">피자</a> <a href="#side_divider">사이드</a>
			</div>
			<div>
				<c:choose>
					<c:when test="${not empty user_name}">
						<a href="http://localhost/pizza_prj/pizza_user/user_order_list.jsp"><strong><c:out value="${user_name}"/>님</strong></a>
						<a href="#void" onclick="logout()">로그아웃</a>
					</c:when>
					<c:otherwise>
						<a href="#void">회원가입</a>
						<a href="http://localhost/pizza_prj/pizza_user/user_login.jsp">로그인</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</section>
</div>	
<div class="container">
		<div class="my_page_menu">
			<div class="my_page_title">마이페이지</div>
			<div class="menu_content">
				<div class="menu_item"><a href="user_order_list.jsp">주문내역</a></div>
				<div class="menu_item"><a href="user_info_check.jsp">회원정보변경</a></div>
			</div>
		</div>
		<div id="main_content" class="main_content">
			<div class="page_title">
			     주문 내역
			</div>   
			 
			<div >
		   		<a href="user_order_list.jsp?tempDate=today" id="today" class="btn_day" onclick="today()">오늘</a>    
		   		<a href="user_order_list.jsp?tempDate=a_month" id="a_month" class="btn_day" onclick="a_month()">1개월</a>
		   		<a href="user_order_list.jsp?tempDate=three_month" id="three_month" class="btn_day" onclick="three_month()">3개월</a>
		   		<a href="user_order_list.jsp?tempDate=all" id="all" class="btn_day">전체</a> 
		    </div>
	
	
	<% 
	
	String tempDate = request.getParameter("tempDate");
	
	//System.out.println("tempDate "+tempDate);
	
	if(tempDate == null){
		%>
		<div>조회를 원하시는 기간을 선택해주세요</div>
		<%
	}else{
	
		if("today".equals(tempDate)){
			cal = Calendar.getInstance();
			cal.setTime(new Date());
			strDate = format.format(cal.getTime());
			
			cal.add(Calendar.DATE,1);
			endDate = format.format(cal.getTime());
			
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
			
		SelectOrderListVO solVO = new SelectOrderListVO("test1", strDate, endDate);
		List<UserOrderVO> list = mDAO.selectOrderList(solVO);
		System.out.println("strDate "+strDate);
		System.out.println("endDate "+endDate);
		pageContext.setAttribute("orderList", list);
	%>
		
	   <div>
	   
	   
	   <c:forEach var="order" items="${orderList}">
			<div>
			<c:set var="i" value="${0}"/>
		   <c:forEach var="order_menu" items="${order.menuListVO}">
			   <c:set var="i" value="${i+1}"/>
			   
				   <c:if test="${i eq 1 }">
					 		<div id="order_no"><c:out value="${order_menu.order_no}"/></div>
					 		<div id="order_date"><c:out value="${order.order_date}"/></div><%--value="${해당 vo.input_date}" --%> 
							<div><c:out value="${order.order_status}"/></div><%--status value="${해당 vo.status}"--%>
					   		<div><c:out value="${order.menu_order_price}"/></div><%-- price value="${해당 vo.price}" --%>
			 		</c:if> 
					        <div><c:out value="${order_menu.menu_name}"/> * <c:out value="${order_menu.order_menu_cnt }"/></div><%--value="{해당 vo.menu}" 메뉴는 리스트에 들어있음 --%> 
		   </c:forEach>
			    </div>    
	   </c:forEach>
	  </div>
	  <%
	}//end else
	  %>
  	</div>
</div>
<div class="footer">
    <section class="footer">
    	 어쩌고저쩌고 카피라이트 @copyright 3조 어쩌고저쩌고 카피라이트 @copyright 3조 어쩌고저쩌고 카피라이트 @copyright 3조 내용수정 내용변경해야함 내용내용내용 채워넣어야함 
    </section>
</div> 
    
</body>
</html>