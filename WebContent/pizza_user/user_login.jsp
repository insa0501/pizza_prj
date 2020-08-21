<%@page import="pizza.dao.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Log in </title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP" crossorigin="anonymous">
    <link rel="stylesheet" href="css/user_login_css.css">
    <link rel="stylesheet" href="../common/css/common_header_footer.css">
    <script type="text/javascript">
    $(function () {
		
	})//ready
    
	window.onload = function() {
		document.getElementById("user_id").addEventListener("keydown",chkEnter);
		document.getElementById("user_pass").addEventListener("keydown",chkEnter);
		document.getElementById("loginBtn").addEventListener("click",chkNull);
	}
       
        function chkEnter() { 
		//enter key = 13
		  if(window.event.which == 13){
			  chkNull();  
	         }//end if
		}//chkEnter
		
		function chkNull() {
			var obj = document.userLoginFrm; //로그인 폼 
			
			if(obj.user_id.value == ""){//아이디 입력 x
				alert("아이디 필수 입력");
			    obj.user_id.focus(); 
			    return;
			}//end if
			
			if(obj.user_pass.value == ""){//아이디 입력 x
				alert("비밀번호 필수 입력");
			    obj.user_pass.focus(); 
			    return;
			}//end if
 
		  obj.submit();//정보 전송
			
		}//chkNull
		
    </script>

</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../common/jsp/common_header.jsp"/>

<!--     <section class="header">
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
    </section> -->

  <section class="section_main">
   <div class="main_title">Welcome!</div>

    <jsp:useBean id="lVO" class="pizza.user.vo.LoginVO" scope="page"/><!-- 값을 저장하는 객체 생성 -->
    <jsp:setProperty property="*" name="lVO"/>
    <%
       String user_name ="";
    
      /*  String user_id = request.getParameter("user_id");
       String user_pass = request.getParameter("user_pass");
       lVO.setId(user_id);
       lVO.setPass(user_pass);
     */
       if(lVO.getUser_id() != null){ //id,pw null 체크
    	   
    	   LoginDAO login_dao = LoginDAO.getInstance(); 
       
           user_name = login_dao.selectLoginId(lVO); 
           //이름은 selectLoginId 이지만 user_name 나옴
           
          if(!"".equals(user_name)){ //로그인 성공시 user_name
        	 //scope 객체에 값 설정
             session.setAttribute("user_id", lVO.getUser_id());
             session.setAttribute("user_name", user_name);
          }else{
        	  %>
        	    <script type="text/javascript">
        	      alert("아이디, 비밀번호를 확인해주세요.");
        	      location.href="http://localhost/pizza_prj/pizza_user/user_login.jsp";
        	    </script>
         	  <%
          }//end else
       }//end if  id,pw null 체크
       
    %>

   <div id="loginBox">
    <c:choose>
       <c:when test="${ user_name ne '' && user_name ne null}">
       
        <script type="text/javascript">
            location.href="http://localhost/pizza_prj/pizza_user/main.jsp";
            //return안해도 괜찮음.
        </script>
       
       </c:when>
      <c:otherwise>
      
     <form name="userLoginFrm" action="user_login.jsp" method="post">
        <div class="input-group mb-3">
           <div class="input-group-append">
              <span class="input-group-text"><i class="fas fa-user"></i></span>
            </div>
            <input type="text" name="user_id" id="user_id" class="form-control input_user"  placeholder="input your ID!😊">
         </div> <!--LoginVo에서 user_id, user_pass가 아니라 id,pass -->
         <div class="input-group mb-2">
            <div class="input-group-append">
               <span class="input-group-text"><i class="fas fa-key"></i></span>
            </div>
            <input type="password" name="user_pass" id="user_pass"  class="form-control input_pass"   placeholder="input your PW!😎 ">
         </div>
         <div class="d-flex justify-content-center mt-3 login_container">
            <button type="button" name="loginBtn" id="loginBtn" class="btn login_btn">LogIn</button>
         </div>
      </form>
      </c:otherwise>
    </c:choose>
      <div class="wrap_finds">
         <a href="http://localhost/pizza_prj/pizza_user/user_find_id.jsp"> 아이디 찾기 </a><br/>
         <span class="finds_divider"> | </span>
         <a href="http://localhost/pizza_prj/pizza_user/user_find_pw.jsp"> 비밀번호 찾기 </a><br/>
      </div>
    </div>  
         
   </section>
   
</body>
</html>