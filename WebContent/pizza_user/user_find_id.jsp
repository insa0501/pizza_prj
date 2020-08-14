<%@page import="pizza.user.vo.SelectIdVO"%>
<%@page import="pizza.dao.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="아이디 찾기"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find ID</title>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP" crossorigin="anonymous">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link rel="stylesheet" href="css/user_find_id.css">
<link rel="stylesheet" href="../common/css/common_header_footer.css">
   
   
<script type="text/javascript">
	$(function(){

	})//ready
	
	window.onload = function() {
		document.getElementById("user_name").addEventListener("keydown",chkEnter);
		document.getElementById("user_phone").addEventListener("keydown",chkEnter);
		document.getElementById("userFindIdBtn").addEventListener("click",chkNull);
	}
	
	function chkEnter() {
		//enter key = 13
		if(window.event.which == 13){
			chkNull();
			
		}//end if
	}//chkEnter
	
	function chkNull() {
		var obj = document.userFindIdFrm; //아이디 찾기 폼
		
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
                <a href="#pizza_divider">피자</a>
                <a href="#side_divider">사이드</a>
            </div>
            <div>
                <a href="#void">회원가입</a>
                <a href="#void">로그인</a>
            </div>
        </div>
    </section>
 
 
<section id="container" class="section_main">
	<jsp:useBean id="siVO" class="pizza.user.vo.SelectIdVO" scope="page"/>
	<jsp:setProperty property="*" name="siVO"/>
	<%
	    String user_id = "";
	
/* 	    String user_name = request.getParameter("user_name");
	    String user_phone = request.getParameter("user_phone");
	    siVO.setUser_name(user_name);
	    siVO.setUser_phone(user_phone); */
	
	    
	    if(siVO.getUser_name() != null){ //name, phone 체크
	    	
	    	MemberDAO member_dao =  MemberDAO.getInstance();
	        
	        user_id = member_dao.selectId(siVO); //user_id return
	        		
	        
	        if(!"".equals(user_id)){ //name, phone이 일치하면 user_id 반환
	        	session.setAttribute("userfind_id", user_id);
	        }else{
	        	%>
	        	<script type="text/javascript">
	        	  alert("이름, 전화번호를 확인해주세요.");
	        	  location.href = "http://localhost/pizza_prj/pizza_user/user_find_id.jsp";
	        	</script>
	        	<%
	        }//end else
	    }//end if  name, phone 체크
	
	%>
<%--     <c:choose>
      <c:when test="${user_id ne '' && user_id ne null}"> <!-- user_id가 있으면  -->
          <script type="text/javascript">
          alert("아이디는 : ${user_id} 입니다.");
	      location.href = "http://localhost/pizza_prj/pizza_user/main.jsp";
        </script>
      </c:when>
      <c:otherwise>
	<form name="userFindIdFrm" id="userFindIdFrm" action="user_find_id.jsp" method="post">
	<div> 
	   <table>
	      <tr>
	         <td colspan="2">아이디 찾기</td>
	      </tr>
	   
	      <tr><!-- SelectIdVO에 name, phone으로 되어있음 -->
	         <td>이름</td><td><input type="text" id="user_name" name="user_name" ></td>
	      </tr>
	   
	      <tr>
	         <td>전화번호</td><td><input type="text" id="user_phone" name="user_phone"></td>
	      </tr>
	      <tr>
	         <td colspan="2"><input type="button" value="아이디 찾기" name="userFindIdBtn" id="userFindIdBtn"></td>
	      </tr>
	   
	   </table>
	
	 </div>
    </form>
   </c:otherwise>
  </c:choose> --%>
  

      <c:choose>
	      <c:when test="${userfind_id ne '' && userfind_id ne null}"> <!-- user_id가 있으면  -->
	          <script type="text/javascript">
	         	 alert("아이디는 : ${userfind_id} 입니다.");
		     	 location.href = "http://localhost/pizza_prj/pizza_user/user_login.jsp";
	        </script>
	      </c:when>
         <c:otherwise>
            <div class="main_title">Forgot your ID?</div>
            <form name="userFindIdFrm" id="userFindIdFrm" action="user_find_id.jsp" method="post">
               <div class="wrap_name">

                  <div class="input-group mb-3">
                     <div class="input-group-append">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                     </div>
                     <input type="text" id="user_name" name="user_name" class="form-control input_user"
                        placeholder="input your name here">
                  </div>
                  <div class="input-group mb-2">
                     <div class="input-group-append">
                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                     </div>
                     <input type="text" id="user_phone" name="user_phone" class="form-control input_pass"
                        placeholder="input your phone-no here🤙">
                  </div>
                  <div class="d-flex justify-content-center mt-3 login_container">
                     <button type="button" name="userFindIdBtn" id="userFindIdBtn" class="btn submit_btn">아이디 찾기</button>
                  </div>
               </div>
            </form>
         </c:otherwise>
      </c:choose>
   </section>
  
  
  
  
  
  
  
  
  
  
</div>
    
    
        <section class="footer">
        어쩌고저쩌고 카피라이트 @copyright 3조 어쩌고저쩌고 카피라이트 @copyright 3조 어쩌고저쩌고 카피라이트 @copyright 3조 내용수정 내용변경해야함 내용내용내용 채워넣어야함 
    </section>
</body>
</html>