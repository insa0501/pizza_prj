<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@page import="java.util.List"%>
<%@page import="pizza.user.vo.MainMenuVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="pizza.dao.MenuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
    info="메인화면에서 피자 종류를 선택하는 화면" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
  
   
<%
	MenuDAO mDAO = MenuDAO.getInstance();

	List<MainMenuVO> mmList_pizza = mDAO.selectMainMenu("피자");
	pageContext.setAttribute("mmList_pizza", mmList_pizza);

	List<MainMenuVO> mmList_side = mDAO.selectMainMenu("사이드");
	pageContext.setAttribute("mmList_side", mmList_side);
%>    

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>3조</title>
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    
    <link rel="stylesheet" href="css/new_main.css">
    
    <script type="text/javascript">
      var checkedMenus = document.getElementsByName("mainFrm"); //폼 이름
      var chkBox = document.getElementsByName("selectmenu"); //체크박스이름

      $(function () {
          
         $("#submit_btn").click(function(){ //버튼을 눌렀을 때
            var checked = 0; //체크된 체크박스를 세는 변수
             for(var i = 0; i<chkBox.length; i++) {
                if(chkBox[i].checked) {
                   checked++;
                }
             }
            
            if(checked == 0) { //한개도 선택이 안됐을 시 
               alert("메뉴는 한개 이상 선택해주세요!");
               return;
            } 
            $("#mainFrm").submit();//정보 전송
            console.log( checked +"///체크된 체크박스의 갯수"); //확인용
         });

      })//ready 

    
	  function logout(){
	     alert("로그아웃 하셨습니다.");	

	        location.href = "http://localhost/pizza_prj/pizza_user/user_logout.jsp"; 
     	}//logout()
   
    </script>
    
</head>
<body>
  
	<section class="header">
        <div class="header_top"></div>
        <div class="header_nav menu" id="header_nav">
	         <span><img src="http://localhost/pizza_prj/common/images/logo.png"></span>
	         <span>
	            <a href="#pizza_divider">Pizza</a>
	            <a href="#side_divider">Side</a>
	            <c:choose>
					<c:when test="${not empty user_name}">
						<a href="http://localhost/pizza_prj/pizza_user/user_order_list.jsp">
							<strong><c:out value="${user_name}" />님</strong></a>
						<a href="#void" onclick="logout()">Logout</a>
					</c:when>
					<c:otherwise>
						<a href="http://localhost/pizza_prj/pizza_user/user_login.jsp">Sign in</a>
						<a href="http://localhost/pizza_prj/pizza_user/user_join.jsp">Sign up</a>
					</c:otherwise>
				</c:choose>
	         </span>
        </div>
    </section>

       <form name="mainFrm" id="mainFrm" action="order_menu_cnt.jsp" method="post">
        <section class="articles">
            <div class="menu_top_img" style="background-image: url(../common/images/pizza_main_top2.jpg);">
                <!-- <img src="https://akamai.pizzahut.co.kr/banner/pdlist/premium_list_o.jpg"/> -->
                <div></div>
                <div class="menu_top_comment">
                    <div> <span>Best Pizza</span> delivery</div>
                    <div>언제든 주문하세요. <br>존맛탱 피자를 문 앞까지 배달해 드립니다.</div>
                </div>
            </div>
            
            <!-- 피자메뉴 -->
            <div class="menu_divider" id="pizza_divider">
                <span>Pizza</span>
            </div>
            <div class="menu_wrap">
		         <c:forEach var="menu_pizza" items="${mmList_pizza}" varStatus="status">
		                <div class="pizza_menu">
		                    <div class="pizza_img" style="background-image: url('http://localhost/pizza_prj/common/images/${ menu_pizza.menu_img }');"></div>
		                    <div class="pizza_discription">
		                        <span>${menu_pizza.menu_name} </span>
		                        <span>${menu_pizza.menu_price} 원</span>
		                        
		                        <div class="checkbox-group">
		                            <input type="checkbox" name="selectmenu" value="${menu_pizza.menu_name}/${menu_pizza.menu_price}" id="custom-checkbox pizza${status.index}" class="custom-checkbox">
		                            <span class="custom-checkbox-span" tabindex="0"></span>
		                            <label for="custom-checkbox pizza${status.index}" class="custom-checkbox-label"> 선택하기 </label>
		                        </div>
		                        
		                    </div>
		                </div>
		         </c:forEach>
            </div>


            <!-- 사이드메뉴 -->
             <div class="menu_divider" id="side_divider">
                <span>Side</span>
            </div>

            <div class="menu_wrap">
	            <c:forEach var="menu_side" items="${mmList_side}" varStatus="status">
	                <div class="pizza_menu">
	                    <div class="pizza_img" style="background-image: url('http://localhost/pizza_prj/common/images/${ menu_side.menu_img }');"></div>
	                    <div class="pizza_discription">
	                        <span>${menu_side.menu_name}</span>
	                        <span>${menu_side.menu_price} 원</span>
                        <div class="checkbox-group">
                            <input type="checkbox"  name="selectmenu" value="${menu_side.menu_name}/${menu_side.menu_price}" id="custom-checkbox side${status.index}" class="custom-checkbox">
                            <span class="custom-checkbox-span" tabindex="0"></span>
                            <label for="custom-checkbox  side${status.index}" class="custom-checkbox-label"> 선택하기 </label>
                        </div>
	                        
	                    </div>
	                </div>
	         	</c:forEach>
            </div>

        </section>
<% 

%>
        <section class="section_btn">
            <input type="button" value="Order Now" class="submit_btn" id="submit_btn">
        </section>
    </form>

   
    <section class="footer">
        어쩌고저쩌고 카피라이트 @copyright 3조 어쩌고저쩌고 카피라이트 @copyright 3조 어쩌고저쩌고 카피라이트 @copyright 3조
    </section>

    <div class="go_to_top">
        <a href="#header_nav">TOP</a>
    </div>

</body>
</html>   
