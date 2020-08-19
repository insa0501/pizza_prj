<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3조</title>
    <link rel="stylesheet" href="css/order_stage_css.css">
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
<%
	// 세션에 있는 총액 확인
	//int sessionTotalPrice = 0;
	//sessionTotalPrice = (Integer) session.getAttribute("total_price");
	// 세션에 있는 유저 아이디 확인
	// 2020-08-19 김홍석 - 로그인이 되지 않았을 경우 메인화면으로 돌아오도록 변경
	String user_id = "";
	user_id = (String) session.getAttribute("user_id");
	if (user_id == null) {
%>
		alert("로그인이 필요합니다.");
		location.replace("http://localhost/pizza_prj/pizza_user/main.jsp");
<%		
	} // end if
%>

	$(function(){
		var priceArr = new Array();
		var cntArr = new Array();
		var totalArr = new Array();
		var totalPrice = document.getElementById("total_price");
		var total = 0;
		var size = 0;
		var menu_price = null;
		var menu_price_id = null;
		
		$.each($("input[name='menuPrice']"), function(i, price) {
			priceArr[i] = $(price).val();
			size = priceArr.length;
		}); // end each
		
		$(".menuCnt").change(function() {
			<% int tempIndex = 0; %>
			total = 0;
			$.each($("input[name='menuCnt']"), function(i, menu) {
				cntArr[i] = $(menu).val();
				totalArr[i] = priceArr[i]*cntArr[i];
			}); // end each
			$.each($("input[name='menuPrice']"), function(i, menu) {
				$("input[name='menuPrice]").innerHTML = totalArr[i];
				total += totalArr[i];
			}); // end each
			
			for (var i=0; i<size; i++) {
				menu_price = "menu_price"+i;
				menu_price_id = document.getElementById(menu_price);
				console.log($(menu_price_id).text());
				menu_price_id.innerHTML = totalArr[i] + "원";
			} // end for
			
			totalPrice.innerHTML = total + "원";
			$("#totalPrice").val(total);
		}); // change
		
		$("#order_payment").click(function() {
			if (menu_price_id != null) {
			}
			orderMenuCntFrm.submit();
		}); // click
	});
	
	function logout(){
	    alert("로그아웃 하셨습니다.");	
		location.href = "http://localhost/pizza_prj/pizza_user/user_logout.jsp"; 
    }//logout()
	
</script>
<body>
	
    <section class="header">
        <div class="header_top"></div>
        <div class="header_nav" id="header_nav">
            <div>
                <span> <a href="main.html/#pizza_divider">피자</a> / <a href="main.html/#side_divider">사이드</a> </span>
                <span>신제품 / 이벤트</span>
            </div>
            <div>
            <c:if test="${ not empty user_id }">
                <span><a href="http://localhost/pizza_prj/pizza_user/user_order_list.jsp"><c:out value="${ user_name }"/></a>님</span>
                <span><a href="#void" onclick="logout()"><c:out value="로그아웃"/></a></span>
            </c:if>
            </div>
        </div>
    </section>
    <form action="order_payment.jsp" name="orderMenuCntFrm">
        <section class="menu_section pizza">
            <div class="menu_title">피자</div>
            <div class="menu_detail">
                <ul>
                    <%
                    	String[] selectmenu = request.getParameterValues("selectmenu"); 
                    	String[] selectside = request.getParameterValues("selectside");
                    	int totalPrice = 0;
                    	int index = 0;
                    	if ( selectmenu == null ) {
                    		response.sendRedirect("main.jsp");
                    		return;
                    	} // end if
                    	
                    %>
                    <%
                    	String[] menuInfo = new String[2];
                    	for (int i=0; i<selectmenu.length; i++) {
                    		menuInfo = selectmenu[i].split("/");
                    		totalPrice += Integer.parseInt(menuInfo[1]);
                    %> 
                    <li class="menu_line">
                        <div>
                            <span class="menu_name"><%=menuInfo[0] %></span>
                            <input type="hidden" name="menuName" id="menuName" value="<%=menuInfo[0]%>"/>
                            <input type="number" min="1" max="10" value="1" name="menuCnt" id="menuCnt" class="menuCnt" required/>
                        </div>
                        <div>
                            <%-- <span class="menu_price" id="menu_price"><%=menuInfo[1] %>원</span> --%>
                            <span class="menu_price" id="menu_price<%=index++%>"><%=menuInfo[1] %>원</span>
                            <input type="hidden" name="menuPrice" id="menuPrice" value="<%=menuInfo[1]%>"/>
                        </div>
                    </li>
                    <%} // end for %>
                </ul>
            </div>
        </section>
        <section class="menu_section side">
            <div class="menu_title">사이드</div>
            <div class="menu_detail">
                <ul>
                    <%
                    	int sideLength = 0;
                    	if (selectside != null) {
							sideLength = selectside.length;							
                    	} // end if
                    	String[] sideInfo = new String[2];
                      	for (int i=0; i<sideLength; i++) {
                      		sideInfo = selectside[i].split("/");
                    		totalPrice += Integer.parseInt(sideInfo[1]);
                    %>
                    <li class="menu_line">
                        <div>
                            <span class="menu_name"><%=sideInfo[0] %></span>
                            <input type="hidden" name="menuName" id="menuName" value="<%=sideInfo[0] %>"/>
                            <input type="number" min="1" max="10" value="1" name="menuCnt" id="menuCnt" class="menuCnt" required/>
                        </div>
                        <div>
                            <span class="menu_price" id="menu_price<%=index++%>"><%=sideInfo[1] %>원</span>
                            <input type="hidden" name="menuPrice" id="menuPrice" value="<%=sideInfo[1] %>"/>
                        </div>
                    </li>
                   	<%
                      	}// end for
                   	%>
                </ul>
            </div>
        </section>
        <section class="menu_section">
            <div class="price_calc">
                <div>
                    <span>총 주문 금액</span>
                    <span id="total_price"><%=totalPrice %>원</span>
                    <input type="hidden" name="totalPrice" id="totalPrice" value="<%=totalPrice%>"/>
                </div>
                <div>
                    <a href="#void" id="order_payment">결제 창으로 이동하기</a>
                </div>
            </div>
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
