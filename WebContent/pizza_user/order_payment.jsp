<%@page import="pizza.user.vo.OrderUserInfoVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="pizza.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3조</title>
    <link rel="stylesheet" href="css\order_payment_css.css">
    
</head>
<%
	
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
		ouiVO = oDAO.selectUserInfo("test1");
		user_phone = ouiVO.getUser_phone();
		user_zipcode = ouiVO.getUser_zipcode();
		user_addr1 = ouiVO.getUser_addr1();
		user_addr2 = ouiVO.getUser_addr2();
		user_addr.append(user_zipcode).append("	")
				.append(user_addr1).append(" ")
				.append(user_addr2);
		if (totalPrice == 0) {
			response.sendRedirect("order_menu_cnt.jsp");
			return;
		} // end if
	} catch (SQLException se) {
		se.printStackTrace();
		
	} catch(NumberFormatException nfe) {
		nfe.printStackTrace();
		response.sendRedirect("order_menu_cnt.jsp");
		return;
	} // end catch
%>
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
	
    <form action="order_payment_process.jsp">
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
                     <span class="list_menu_cnt">(수량 <%=menuCnt[i] %>)</span>
                  </p>
                  <span class="list_menu_price"><%=Integer.parseInt(menuCnt[i]) * Integer.parseInt(menuPrice[i]) %>원</span>
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

               <span class="pay_radio"><input type="radio" name="order_payment"> 카드결제</span>
               <span class="pay_radio"><input type="radio" name="order_payment"> 카드결제</span>
               <span class="pay_radio"><input type="radio" name="order_payment"> 카드결제</span>
               <span class="pay_radio"><input type="radio" name="order_payment"> 카드결제</span>
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
               </div>
               <div class="payment_btn">결제하기</div>
            </div>
         </section>
      </section>
   </form>
   
    <section class="footer">
        어쩌고저쩌고 카피라이트 @copyright 3조 어쩌고저쩌고 카피라이트 @copyright 3조<br>
        어쩌고저쩌고 카피라이트 @copyright 3조 어쩌고저쩌고 카피라이트 @copyright 3조
    </section>

    <div class="go_to_top">
        <a href="#header_nav">TOP</a>
    </div>

</body>
</html>