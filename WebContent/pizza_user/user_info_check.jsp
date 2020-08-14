<%@page import="pizza.user.vo.LoginVO"%>
<%@page import="pizza.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String user_id = (String)session.getAttribute("user_id");
if(user_id == null){//세션에서 꺼내온 아이디가 없다.
	response.sendRedirect("http://localhost/pizza_prj/pizza_user/main.jsp");
	return;
}//end if 
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="http://localhost/pizza_prj/common/css/main.css">
<link rel="stylesheet" type="text/css" href="http://localhost/pizza_prj/common/css/common_header.css">
<link rel="stylesheet" type="text/css" href="http://localhost/pizza_prj/common/css/common_footer.css">

<title>회원정보메인</title>
<style type="text/css">
#container{ height:600px; width:80vw; 
		margin:25px auto;}

#input_area{  margin-top:150px;}
table{ margin:0px auto;}
.searchBtn{background-color: #C50000; color:#FFFFFF; font-weight: bold; border-radius: 5px; 
			border: none; padding:3px 10px 3px 10px;
			 width:60px;}
</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

<!-- Google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>


<script type="text/javascript">
$(function(){
	$("#chk").click(function(){
		
		$("#frm").submit();
	});//click
});//ready




</script>
</head>
<body>
<div id="wrap">
	<c:import url="../common/jsp/common_header.jsp"></c:import>
	
	<div id="container">
	<h3>회원정보수정</h3>
	<div>
	<div id="input_area">
	<form action="user_info_change.jsp" method="post" name="frm" id="frm"  >
	<table>
		<tr>
			<th colspan="2" style="
			font-size:16px;">비밀번호를 입력해주세요.</th>
		</tr>
		<tr>
			<td style="width: 160px;"><input type="password" class="user_text" name="user_pass"/></td>
			<td><input type="button" value="확인" class="searchBtn" id="chk"/></td>
		</tr>
	</table>
	</form>
	</div>
	</div>
	</div>
	
	<c:import url="../common/jsp/common_footer.jsp"></c:import>
</div>

</body>
</html>