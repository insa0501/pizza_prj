<%@page import="pizza.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="비번찾기"%>
 <% request.setCharacterEncoding("UTF-8"); %>
 
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find PW</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP" crossorigin="anonymous">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link rel="stylesheet" href="css/user_find_pw.css">
<link rel="stylesheet" href="../common/css/common_header_footer.css">
   
   
<script type="text/javascript">
	$(function(){

	})//ready
	
	window.onload = function() {
		document.getElementById("user_id").addEventListener("keydown",chkEnter);
		document.getElementById("user_name").addEventListener("keydown",chkEnter);
		document.getElementById("user_phone").addEventListener("keydown",chkEnter);
		document.getElementById("userFindPassBtn").addEventListener("click",chkNull);
	}
	
	function chkEnter() {
		//enter key = 13
		if(window.event.which == 13){
			chkNull();
			
		}//end if
	}//chkEnter
	
	function chkNull() {
		var obj = document.userFindPwFrm; //비밀번호 찾기 폼
		
		if(obj.user_id.value == ""){
			alert("아이디 필수 입력");
			obj.user_id.focus();
			return;
		}//end if
		
		if(obj.user_name.value == ""){
			alert("이름 필수 입력");
			obj.user_name.focus();
			return;
		}//end if
		
		if(obj.user_phone.value == ""){
			alert("전화번호 필수 입력");
			obj.user_phone.focus();
			return;
		}//end if
		
		obj.submit(); //정보 전송
 
	}//chkNull
	
</script>
</head>

<body>
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
						<a href="http://localhost/pizza_prj/pizza_user/user_order_list.jsp"><strong><c:out
									value="${user_name}" />님</strong></a>
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
 
	<section id="container" class="section_main">
	<jsp:useBean id="spVO" class="pizza.user.vo.SelectPassVO" scope="session"/><!--request: forward로 이동한 jsp에서도 사용가능 -->
	<jsp:setProperty property="*" name="spVO"/> <!-- scope session으로 변경 -->
	 
	 <%
	 	boolean selectPassFlag = false;  
	 
	    if(spVO.getUser_id() != null){ //id,name,phone이 일치하면
	    	MemberDAO member_dao = MemberDAO.getInstance();
	        selectPassFlag = member_dao.selectPass(spVO); // id,name,phone이 일치해 pass가 rs에 있으면 T/
	        if(selectPassFlag){
	        	session.setAttribute("user_id", spVO.getUser_id()); //아이디를 forward로 넘겨줌
	        } else {
      %>
	      	    <script type="text/javascript">
	      	      alert("아이디,이름,전화번호를 확인해주세요.");
	      	   /*     return; */
	      	     /*  location.href="http://localhost/pizza_prj/pizza_user/user_find_pw.jsp"; */
	      	    </script>
   	  <%
	        }//end else
	    }//end if
	 %>
	<%--  
	<c:choose>
	   <c:when test="${ user_id ne '' && user_id ne null}">
	     <script type="text/javascript">
	          alert("비밀번호 변경 페이지로 이동합니다.");
	          //질문 : 여기 비효율적 방법,,,
	      	  // 1. 변경 location.href="http://localhost/pizza_prj/pizza_user/user_change_pw.jsp?user_id=${param.user_id}";
	      	  location.href="http://localhost/pizza_prj/pizza_user/user_change_pw.jsp?user_id";
	     </script>
	   </c:when>
	  <c:otherwise>
	  <form name="userFindPwFrm" id="userFindPwFrm" action="user_find_pw.jsp" method="post">
	    <div >
	      <table>
	         <tr>
	        	 <td colspan="2">비밀번호 찾기 </td>
	         </tr> 
	         <tr>
	             <td>아이디 </td><td>  <input type="text" name="user_id" id="user_id"> </td>
	         </tr> 
	         <tr>   
	         	 <td>이름 </td><td>  <input type="text" name="user_name" id="user_name" > </td>
	         </tr>	 
	         <tr>
	         	 <td>전화번호 </td><td>  <input type="text" name="user_phone" id="user_phone"> </td>
	         </tr>
	         <tr>	 
	         	 <td colspan="2"> <input type="button" value="비밀번호 찾기" name="userFindPassBtn" id="userFindPassBtn"> </td> 
	         </tr>
	      
	       </table>
	  	</div>
	   </form>	
	  </c:otherwise>
	 </c:choose> 
	 --%>

			<c:choose>
				<c:when test="${ user_id ne '' && user_id ne null}">
					<script type="text/javascript">
		         		 alert("비밀번호 변경 페이지로 이동합니다.");
		        		  //질문 : 여기 비효율적 방법,,,
		      			  // 1. 변경 location.href="http://localhost/pizza_prj/pizza_user/user_change_pw.jsp?user_id=${param.user_id}";
		      			 location.href="http://localhost/pizza_prj/pizza_user/user_change_pw.jsp?user_id";
		     		</script>
				</c:when>
				<c:otherwise>
					<div class="main_title">Forgot your PW?</div>
					<form name="userFindPwFrm" id="userFindPwFrm" action="user_find_pw.jsp" method="post">
						<div class="wrap_name">

							<div class="input-group mb-3">
								<div class="input-group-append">
									<span class="input-group-text"><i class="fas fa-user-check"></i></span>
								</div>
								<input type="text" class="form-control input_user" name="user_id" id="user_id" placeholder="input your ID here">
							</div>
							
							<div class="input-group mb-2">
								<div class="input-group-append">
									<span class="input-group-text"><i class="fas fa-user"></i></span>
								</div>
								<input type="text" class="form-control input_user" name="user_name" id="user_name" placeholder="input your NAME here">
							</div>
							
							<div class="input-group mb-2">
								<div class="input-group-append">
									<span class="input-group-text"><i class="fas fa-phone"></i></span>
								</div>
								<input type="text" class="form-control input_user" name="user_phone" id="user_phone" placeholder="input your phone-no here">
							</div>
							
							<div class="d-flex justify-content-center mt-3 login_container">
								 <input type="button" value="비밀번호 찾기" name="userFindPassBtn" id="userFindPassBtn" class="submit_btn">
							</div>
						</div>
					</form>
				</c:otherwise>
			</c:choose>
		</section>



	<section class="footer">어쩌고저쩌고 카피라이트 @copyright 3조 어쩌고저쩌고
		카피라이트 @copyright 3조 어쩌고저쩌고 카피라이트 @copyright 3조 내용수정 내용변경해야함 내용내용내용 채워넣어야함
	</section>
</body>
</html>