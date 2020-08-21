<%@page import="pizza.user.vo.LoginVO"%>
<%@page import="pizza.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
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

<title>회원정보메인</title>
<!-- Google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    
 <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
 <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
 <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    
<link rel="stylesheet" type="text/css" href="../common/css/common_header_footer.css">
<link rel="stylesheet" type="text/css" href="../common/css/my_page_menu.css">

<script type="text/javascript">
$(function(){
	$("#chk").click(function(){
		
		$("#frm").submit();
	});//click
});//ready

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
		<div class="main_content">
			<div class="page_title">회원정보 수정</div>
			<div id="input_area">
				<form action="user_info_change.jsp" method="post" name="frm" id="frm" class="input_pw_form" >
					<table>
						<tr>
							<th class="table_th" colspan="2" style="padding: 10px 0;">비밀번호를 입력해주세요.</th>
						</tr>
						<tr class="user_input">
							<td><input type="password" class="user_text" name="user_pass"/></td>
							<td><input type="button" value="확인" class="searchBtn" id="chk"/></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	
	</div>
	<div class="footer">
		<c:import url="../common/jsp/common_footer.jsp"></c:import>
	</div>

</body>
</html>