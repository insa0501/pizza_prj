<%@page import="pizza.user.vo.OrderUserInfoVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="pizza.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html lang="en">
<%
if ("POST".equals(request.getMethod())) {
		request.setCharacterEncoding("UTF-8");
	} // end if
%>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3조</title>
    <link rel="stylesheet" href="css/order_payment_css.css">
    <link rel="stylesheet" href="../common/css/common_header_footer.css">
    
</head>
<%
	// 세션에 있는 유저 아이디 확인
	String user_id = "";
	user_id = (String) session.getAttribute("user_id");
	// 세션이 없거나 세션만료 시 메인화면으로
	if (user_id == null) {
		response.sendRedirect("http://localhost/pizza_prj/pizza_user/main.jsp");
		return;
	} // end if
	
	response.setHeader( "Cache-Control", "no-store, no-cache, must-revalidate");  //HTTP 1.1
	response.setDateHeader ("Expires", -1); //prevents caching at the proxy server
	
	int totalPrice = 0; // 총액을 받을 변수
	OrderUserInfoVO ouiVO = null;
	String user_phone = "";
	StringBuilder user_addr = new StringBuilder();
	String user_zipcode = "";
	String user_addr1 = "";
	String user_addr2 = "";
	try {
		// 파라미터로 총액을 받는다.
		totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
		// 받은 총액을 세션에 넣는다.
		session.setAttribute("total_price", totalPrice);
		
		OrderDAO oDAO = OrderDAO.getInstance();
		ouiVO = oDAO.selectUserInfo(user_id);
		
		// session 에 ouiVO를 넣는다.
		session.setAttribute("ouiVO", ouiVO);
		
		user_phone = ouiVO.getUser_phone();
		user_zipcode = ouiVO.getUser_zipcode();
		user_addr1 = ouiVO.getUser_addr1();
		user_addr2 = ouiVO.getUser_addr2();
		user_addr.append(user_zipcode).append("	")
				.append(user_addr1).append(" ")
				.append(user_addr2);
		
		// 2020-08-17 김홍석 조건 변경 totalPrice == 0 -> menuName length == 0
		if (request.getParameterValues("menuName").length == 0) { // 파라미터로 받은 메뉴 갯수가 0개 일 경우
			response.sendRedirect("http://localhost/pizza_prj/pizza_user/order_menu_cnt.jsp");
			return;
		} // end if
	} catch (SQLException se) {
		se.printStackTrace();
		
	} catch(NumberFormatException nfe) {
		nfe.printStackTrace();
		response.sendRedirect("http://localhost/pizza_prj/pizza_user/order_menu_cnt.jsp");
		return;
	} // end catch
%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	
	$(function() {
		// 결제버튼
		$("#divPay").click(function() {
			if( !$("[name='order_payment']").is(":checked")) {
				alert("결제수단을 선택해주세요");
				return;
			}// end if
			orderPaymentFrm.submit();
		}); //click 
	});
	
	function logout(){
	    alert("로그아웃 하셨습니다.");	
		location.href = "http://localhost/pizza_prj/pizza_user/user_logout.jsp"; 
    }//logout()	
	
</script>
<body>
	<!-- 헤더 -->
	<jsp:include page="../common/jsp/common_header.jsp"/>
	
    <form action="order_payment_process.jsp" name="orderPaymentFrm" method="post">
      <section class="main_section">
         <div class="section_title">1. 고객정보</div>
         <div class="section_details">
            <ul>
               <li>
                  <span class="list_title title1">휴대폰</span>
                  <span><%=user_phone %></span>
               </li>
               <li>
                  <span class="list_title title1">배달주소</span>
                  <span><%=user_addr %></span>
               </li>
            </ul>
         </div>
      </section>

      <section class="main_section">
         <div class="section_title">2. 주문내역</div>
         <div class="section_details">
            <ul>
            <%
            String[] menuName = request.getParameterValues("menuName");
            String[] menuCnt = request.getParameterValues("menuCnt");
            String[] menuPrice = request.getParameterValues("menuPrice");
            
            if (menuName == null) {
				response.sendRedirect("order_menu_cnt.jsp");
				return;
            } // end if
            for (int i=0; i<menuName.length; i++) {
            	
            %>
               <li class="menu_lists">
                  <p>
                     <span class="list_title"><%=menuName[i] %></span>
                     <input type="hidden" name="menuName" id="menuName" value="<%=menuName[i]%>"/>
                     <span class="list_menu_cnt">(수량 <%=menuCnt[i] %>)</span>
                     <input type="hidden" name="menuCnt" id="menuCnt" value="<%=menuCnt[i]%>"/>
                  </p>
                  <span class="list_menu_price"><%=Integer.parseInt(menuCnt[i]) * Integer.parseInt(menuPrice[i]) %>원</span>
                     <input type="hidden" name="menuPrice" id="menuPrice" value="<%=Integer.parseInt(menuCnt[i]) * Integer.parseInt(menuPrice[i])%>"/>
               </li>
            <%
            } // end for
            %>
            </ul>
            <!-- <div class="">
               <span>총 결제금액</span>
               <span>00,000원</span>
            </div> -->
         </div>
      </section>

      <section class="section_wrap">
         <section class="half_section">
            <div class="section_title">3. 결제수단</div>
            <div class="section_details">
               <span class="warning">
                  현재 사회적 거리두기로 인해 현장결제는 불가합니다. <br>
                  결제완료 후 결제수단 변경은 불가합니다.
               </span>

               <span class="pay_radio"><input type="radio" name="order_payment" value="카드결제"> 카드결제</span>
               <span class="pay_radio"><input type="radio" name="order_payment" value="휴대폰 결제"> 휴대폰 결제</span>
               <span class="pay_radio"><input type="radio" name="order_payment" value="카카오 페이"> 카카오 페이</span>
               <span class="pay_radio"><input type="radio" name="order_payment" value="네이버 페이"> 네이버 페이</span>
            </div>
         </section>
         <section class="half_section">
            <div class="section_title">4. 결제하기</div>
            <div class="section_details">
               <ul>
               	<%
               	for (int i=0; i<menuName.length; i++) {
            	%>
                  <li>
                     <span class="list_title"><%=menuName[i] %></span>
                     <span class="list_menu_cnt">(수량 <%=menuCnt[i] %>)</span>
                  </li>
                <%
               	} // end for
                %>
               </ul>
               <div class="total_payment">
                  <span>총 주문 금액</span>
                  <span class="total_payment_price"><%=totalPrice%> 원</span>
                  <input type="hidden" name="order_price" id="order_price" value="<%=totalPrice %>"/>
               </div>
               <div style="cursor:pointer;" id="divPay">
               		<span class="payment_btn">결제하기</span>
               </div>
            </div>
         </section>
      </section>
   </form>
   
	<!-- 푸터 -->
	<jsp:include page="../common/jsp/common_footer.jsp"/>

    <div class="go_to_top">
        <a href="#header_nav">TOP</a>
    </div>

</body>
</html>
