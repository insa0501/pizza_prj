<%@page import="pizza.admin.vo.UpdateOrderVO"%>
<%@page import="pizza.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://211.238.142.33/jsp_prj/common/css/main.css">
<style type="text/css">
		
</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
<c:catch var="e">
<%
OrderDAO oDAO = OrderDAO.getInstance();
UpdateOrderVO uoVO = new UpdateOrderVO(request.getParameter("order_no"),request.getParameter("orderStatus"));
int updateCnt = oDAO.updateOrder(uoVO);

pageContext.setAttribute("updateCnt", updateCnt);
%>
</c:catch>
<c:if test ="${ updateCnt ne -1 }">
<script type="text/javascript">

	location.href = "http://localhost/pizza_prj/pizza_admin/admin_order_mgr.jsp"; 
	
</script>
</c:if>
<c:if test="${ not empty e }">
	<script type="text/javascript">

	alert("변경중 문제가 발생하였습니다.");
	location.href = "http://localhost/pizza_prj/pizza_admin/admin_order_mgr.jsp"; 
	
	</script>
</c:if>
</head>
<body>
 

</body>
</html>