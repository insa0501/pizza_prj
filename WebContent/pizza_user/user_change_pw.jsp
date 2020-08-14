<%@page import="pizza.user.vo.UpdatePassVO"%>
<%@page import="pizza.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="비번변경"
    %>
<%
  //로그인 한 사용자만 볼 수 있게 session 체크
  String id = (String)session.getAttribute("user_id");
  if(id == null){
     response.sendRedirect("http://211.238.142.32/index.html");
  }
%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="http://localhost/pizza_prj/common/css/common_header.css">
<link rel="stylesheet" type="text/css" href="http://localhost/pizza_prj/common/css/common_footer.css">


<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function(){

	})//ready
	
	window.onload = function() {
		document.getElementById("user_pass").addEventListener("keydown",chkEnter);
		document.getElementById("user_pass_chk").addEventListener("keydown",chkEnter);
		document.getElementById("userChangePw").addEventListener("click",chkNull);
	}
	
	function chkEnter() {
		//enter key = 13
		if(window.event.which == 13){
			chkNull();
		}//end if
	}//chkEnter
	
	function chkNull() {
		var obj = document.userChangePwFrm; //아이디 찾기 폼
		
		if(obj.user_pass.value == ""){
			alert("새 비밀번호 필수 입력");
			obj.user_pass.focus();
			return;
		}//end if
		
		if(obj.user_pass_chk.value == ""){
			alert("비밀번호 확인 필수 입력");
			obj.user_pass_chk.focus();
			return;
		}//end if
		
		if(obj.user_pass.value != obj.user_pass_chk.value){
			
			alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			
			obj.user_pass.value="";
			obj.user_pass_chk.value="";
			obj.user_pass.focus();
		    return; 
		}
		obj.submit(); //정보 전송
	}//chkNull
	
</script>
</head>
<body>
    <section class="header">
        <div class="header_top"></div>
        <div class="header_nav" id="header_nav">
            <div>
                <a href="#pizza_divider">피자</a>
                <a href="#side_divider">사이드</a>
            </div>
            <div>
                <span>회원가입</span>
                <span>로그인</span>
            </div>
        </div>
    </section>

 
<div id="container" style="width:80vw; margin: 0px auto; min-height: 500px;background-color:#C6C6C6; "  >
<jsp:useBean id="upVO" class="pizza.user.vo.UpdatePassVO" scope="page"/>
<jsp:setProperty property="*" name="upVO"/>
 
	<%
	   String user_id = session.getAttribute("user_id").toString(); //세션에서 user_id가져와서 
	
	   upVO.setUser_id(user_id); //upVP에 값 넣기
	   
	   int updatePassFlag = 0;
	
	   if(upVO.getUser_pass() != null){
		   
		   MemberDAO member_dao =  MemberDAO.getInstance();
		   
		   updatePassFlag = member_dao.updatePass(upVO);
		   
		   System.out.print(updatePassFlag);
		   
		   if(updatePassFlag == 1){
			   session.setAttribute("user_pass", upVO.getUser_pass());
			   
			   session.setAttribute("user_id", user_id);
			   
		   //    System.out.print(updatePassFlag);
			   
		   }else{
			   %>
	      	    <script type="text/javascript">
	      	      alert("비밀번호 변경을 실패했습니다.");
	      	      location.href="http://localhost/pizza_prj/pizza_user/user_find_pw.jsp";
	      	    </script>

	       	  <%
			   
		   }//end else
		   
	   }//end if
 
	%>

<c:choose>
   <c:when test="${ user_pass ne '' && user_pass ne null}">
     <script type="text/javascript">
          alert("비밀번호가 변경되었습니다.");
          location.href="http://localhost/pizza_prj/pizza_user/main.jsp";
     </script>
   </c:when>
   
  <c:otherwise>
  <form  name="userChangePwFrm" id="userChangePwFrm" action="user_change_pw.jsp" method="post">
	<div>
	<table>
	   <tr>
	  		 <td>비밀번호 변경</td> 
	   </tr>
	   <tr>
	   		<td>새 비밀번호</td><td><input type="text" id="user_pass" name="user_pass" placeholder="새 비밀번호 입력">
<%-- 	   		<input type="hidden" name="user_id" id="user_id" value="${user_id}"> --%>
	   		</td>
	   </tr>
	   
	   <tr>
	  		 <td>비밀번호 확인</td><td> <input type="text" id="user_pass_chk" name="user_pass_chk" placeholder="비밀번호 확인"></td>
	   </tr>
	   <tr>
	   		<td colspan="2"> <input type="button" value="비밀번호 변경" name="userChangePw" id="userChangePw"></td>
	   </tr>
	   
	</table>
	<br/><br/><br/>
	<br/>
	 <br/>
    
  </div>
 </form>
   </c:otherwise>
 </c:choose> 
   	
</div>
    
    
        <section class="footer">
        어쩌고저쩌고 카피라이트 @copyright 3조 어쩌고저쩌고 카피라이트 @copyright 3조 어쩌고저쩌고 카피라이트 @copyright 3조 내용수정 내용변경해야함 내용내용내용 채워넣어야함 
    </section>
</body>
</html>