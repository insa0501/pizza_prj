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
    
    <link rel="stylesheet" href="http://localhost/pizza_prj/pizza_user/css/main_css1.css">

	<script type="text/javascript">
		var checkedMenus = document.getElementsByName("mainFrm"); //폼 이름
		var chkBox = document.getElementsByName("selectmenu"); //체크박스이름
	
		$(function() {
	
			$("#submit_btn").click(function() { //버튼을 눌렀을 때
				var checked = 0; //체크된 체크박스를 세는 변수
				for (var i = 0; i < chkBox.length; i++) {
					if (chkBox[i].checked) {
						checked++;
					}
				}
	
				if (checked == 0) { //한개도 선택이 안됐을 시 
					alert("메뉴는 한개 이상 선택해주세요!");
					return;
				}
				$("#mainFrm").submit();//정보 전송
				console.log(checked + "///체크된 체크박스의 갯수"); //확인용
			});
	
		})//ready 
	
		function logout() {
			alert("로그아웃 하셨습니다.");
			location.href = "http://localhost/pizza_prj/pizza_user/user_logout.jsp";
		}//logout()
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
						<a
							href="http://localhost/pizza_prj/pizza_user/user_order_list.jsp"><strong><c:out
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

	<form name="mainFrm" id="mainFrm" action="order_menu_cnt.jsp">
        <section class="articles">
            <div class="menu_top_img">
                <!-- <img src="https://akamai.pizzahut.co.kr/banner/pdlist/premium_list_o.jpg"/> -->
            </div>
            <!-- 피자메뉴 -->
            <div class="menu_divider" id="pizza_divider">
                <span>피자</span>
            </div>
            <div class="menu_wrap">
	         <c:forEach var="menu_pizza" items="${mmList_pizza}" varStatus="status">
	                <div class="pizza_menu">
	                    <div class="pizza_img" style="background: #ffffff url(http://localhost/pizza_prj/common/images/${ menu_pizza.menu_img })"> </div>
	                    <div class="pizza_discription">
	                        <span>${menu_pizza.menu_name} </span>
	                        <span>${menu_pizza.menu_price} 원</span>
	<%--                         <span>
	                            <input type="checkbox"  name="selectmenu"  value="${menu_side.menu_name}"> 선택하기
	                        </span> --%>
	                         <div class="[ form-group ]"> 
	                            <input type="checkbox" name="selectmenu" value="${menu_pizza.menu_name}" id="fancy-checkbox-danger-custom-icons pizza${status.index}"/>
	                            <div class="[ btn-group ]">
	                                <label for="fancy-checkbox-danger-custom-icons pizza${status.index}" class="[ btn btn-danger ]">
	                                    <span class="[ glyphicon glyphicon-minus ] icon"></span>
	                                    <span class="[ glyphicon glyphicon-plus ] icon"></span>
	                                </label>
	                                <label for="fancy-checkbox-danger-custom-icons pizza${status.index}" class="[ btn btn-default active ]">
	                                    <span class="chk select">선택됨</span>
	                                    <span class="chk unselect">선택하기</span>
	                                </label>
	                            </div>
	                        </div>
	                        
	                    </div>
	                </div>
	         </c:forEach>
            </div>

            <!-- 사이드메뉴 -->
            <div class="menu_divider" id="side_divider">
                <span>사이드</span>
            </div>

            <div class="menu_wrap">
            
            <c:forEach var="menu_side" items="${mmList_side}" varStatus="status">
                <div class="pizza_menu">
                    <div class="pizza_img" style="background: #ffffff url(http://localhost/pizza_prj/common/images/${ menu_side.menu_img })"> </div>
                    <div class="pizza_discription">
                        <span>${menu_side.menu_name}</span>
                        <span>${menu_side.menu_price} 원</span>
<%--                         <span>
                            <input type="checkbox"  name="selectmenu"  value="${menu_side.menu_name}"> 선택하기
                        </span> --%>
                        
                         <div class="[ form-group ]"> 
                            <input type="checkbox" name="selectmenu" value="${menu_pizza.menu_name}" id="fancy-checkbox-danger-custom-icons side${status.index}"/>
                            <div class="[ btn-group ]">
                                <label for="fancy-checkbox-danger-custom-icons side${status.index}" class="[ btn btn-danger ]">
                                    <span class="[ glyphicon glyphicon-minus ] icon"></span>
                                    <span class="[ glyphicon glyphicon-plus ] icon"></span>
                                </label>
                                <label for="fancy-checkbox-danger-custom-icons side${status.index}" class="[ btn btn-default active ]">
                                    <span class="chk select">선택됨</span>
                                    <span class="chk unselect">선택하기</span>
                                </label>
                            </div>
                        </div> 
                        
                    </div>
                </div>
         </c:forEach>
               
            </div>
        </section>
<% 

%>
        <section class="section_btn">
            <input type="button" value="주문하러 가기" class="submit_btn" id="submit_btn">
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