<%@page import="pizza.admin.vo.AdminVO"%>
<%@page import="pizza.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%
//연습ㅁㄴㅇㅁㄴㅇㅁㄴㅇㅇㄴ
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3조</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP" crossorigin="anonymous">
    <link rel="stylesheet" href="css/user_login_css.css">

   <jsp:useBean id="lVO" class="pizza.admin.vo.AdminVO" scope="session"/> 
   <jsp:setProperty property="*" name="lVO"/> 

    <script type="text/javascript">
      $(function() {
   
      })//ready
   
      window.onload = function() {
         document.getElementById("admin_id").addEventListener("keydown", chkEnter);
         document.getElementById("admin_pass").addEventListener("keydown", chkEnter);
         document.getElementById("adminLoginBtn").addEventListener("click", chkNull);
      }
   
      function chkEnter() {
         //enter key = 13
         if (window.event.which == 13) {
            chkNull();
         }//end if
      }//chkEnter
   
      function chkNull() {
         var obj = document.adminLoginFrm; //로그인 폼 
   
         if (obj.admin_id.value == "") {//아이디 입력 x
            alert("아이디 필수 입력");
            obj.admin_id.focus();
            return;
         }//end if
   
         if (obj.admin_pass.value == "") {//비번 입력 x
            alert("비밀번호 필수 입력");
            obj.admin_pass.focus();
            return;
         }//end if
         
         obj.submit();//정보 전송

      }//chkNull
      
      
   </script>
 </head>
<body>
   <section class="header">
      <div class="header_top"></div>
      <div class="header_nav" id="header_nav">
          <div>
              <a href="http://localhost/pizza_prj/pizza_user/main.jsp">메인</a>
          </div>
      </div>
  </section>

   <%
      if(lVO.getAdmin_id() != null) {
         AdminDAO adDAO = AdminDAO.getInstance();
   
         boolean flag = adDAO.selectAdminId(lVO);
         
         if(flag) { //로그인이 성공하면
            %>
            <script>
               alert("관리자 로그인 됨")
            <%
                session.setAttribute("admin_id", lVO.getAdmin_id()); //로그인 된 관리자 아이디를 session에 등록함
            %>
                location.href = "admin_order_mgr.jsp";
            </script>
            <% 
         } else {
            %>
            <script>
               alert("관리자 아이디 또는 비번을 확인해주세용")
            </script>
            <%
         }
      }
   %> 
       <c:if test="${ admin_id ne '' && admin_id ne null}">
        <script type="text/javascript">
            location.href="admin_order_mgr.jsp";
            //return안해도 괜찮음.
        </script>
       </c:if>
  <section class="section_main">
     <div class="main_title">관리자 로그인</div>
         <form name="adminLoginFrm" id="adminLoginFrm" action="admin_login.jsp" method="post">
           <div class="input-group mb-3">
              <div class="input-group-append">
                 <span class="input-group-text"><i class="fas fa-user"></i></span>
               </div>
               <input type="text" name="admin_id" class="form-control input_user" id="admin_id" value="" placeholder="input admin id here">
            </div>
            <div class="input-group mb-2">
               <div class="input-group-append">
                  <span class="input-group-text"><i class="fas fa-key"></i></span>
               </div>
               <input type="password" name="admin_pass" class="form-control input_pass"  id="admin_pass" value="" placeholder="input admin password here">
            </div>
            <div class="d-flex justify-content-center mt-3 login_container">
               <button type="button" name="button" class="btn login_btn" id="adminLoginBtn">관리자 로그인</button>
            </div>
      </form>
   </section>
   
</body>
</html>