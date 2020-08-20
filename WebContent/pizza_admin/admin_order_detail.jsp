<%@page import="pizza.admin.vo.OrderMenuListVO"%>
<%@page import="pizza.user.vo.OrderVO"%>
<%@page import="java.util.List"%>
<%@page import="pizza.admin.vo.OrderDetailVO"%>
<%@page import="pizza.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<div id="popupWrap">
	<div id="popupHeader"></div> <!--******* 헤더 빨간줄 ***********  -->
	<div id="popupBody">
	<%
	String order_no = request.getParameter("param_order_no");
	
	pageContext.setAttribute("order_no", order_no);
	
	OrderDAO oDAO = OrderDAO.getInstance();
	OrderDetailVO odVO = oDAO.selectOrderDetail(order_no);
	List<OrderMenuListVO> menuList = odVO.getMenuListVO();
	
	pageContext.setAttribute("odVO", odVO);
	%>
		<div><h2>주문상세정보</h2></div>
<!--******************************* 주문정보 테이블 **********************************  -->
		<div class="orderData"><h4>주문 정보</h4>
			<table class="orderDetailTab">
				<tr>
					<th class="colTh">주문번호</th>
					<td class="colTd">${ order_no }</td>
					<th class="colTh">주문일자</th>
					<td class="colTd"><%= odVO.getOrder_date() %></td>
				</tr>
				<tr>
					<th class="colTh">우편번호</th>
					<td class="colTd"><%= odVO.getUser_zipcode() %></td>
					<th class="colTh">연락처</th>
					<td class="colTd"><%= odVO.getUser_phone() %></td>
				</tr>
				<tr>
					<th class="colTh">배달주소</th>
					<td colspan="3"><%= odVO.getUser_addr1()+" "+odVO.getUser_addr2() %></td>
				</tr>
				<tr>
					<th class="colTh">주문자 ID</th>
					<td class="colTd"><%= odVO.getUser_id() %></td>
					<th class="colTh">주문자 ip</th>
					<td class="colTd"><%= odVO.getUser_ip() %></td>
				</tr>
				<tr>
					<th class="colTh">배달현황</th>
					<td class="colTd">
					<form id="orderFrm" action="admin_order_update.jsp">
						<select id="orderStatus" name="orderStatus">
							<option value="접수완료"${ odVO.order_status eq "접수완료"?" selected='selected'":"" }>접수완료</option>
							<option value="배달중"${ odVO.order_status eq "배달중"?" selected='selected'":"" }>배달중</option>
							<option value="배달완료"${ odVO.order_status eq "배달완료"?" selected='selected'":"" }>배달완료</option>
						</select>
						<input type="hidden" name="order_no" value="${ order_no }"/>
					</form>
					</td>
					<th class="colTh">결제</th>
					<td class="colTd"><%= odVO.getOrder_pay() %></td>
				</tr>
			</table>
		</div>
<!--******************************* 주문정보 테이블 **********************************  -->
<!--******************************* 결제정보 테이블 **********************************  -->
		<div class="orderData"><h4>결제 정보</h4>
			<table class="orderDetailTab">
				<tr>
					<th class="colTh">주문금액</th>
					<td class="colTd"><%= odVO.getorder_price() %></td>
					<th class="colTh">배송비</th>
					<td class="colTd">0원</td>
				</tr>
			</table>
		</div>
<!--******************************* 결제정보 테이블 **********************************  -->
<!--******************************* 메뉴정보 테이블 **********************************  -->
		<div class="orderData"><h4>메뉴 정보</h4>
			<table class="orderDetailTab">
				<tr>
					<th class="rowTh" style="width: 330px">메뉴명</th>
					<th class="rowTh" style="width: 150px">판매가</th>
					<th class="rowTh" style="width: 120px">수량</th>
				</tr>
				<%
				for(int i=0; i<menuList.size(); i++) {
				%>
				<tr>
					<td><%= menuList.get(i).getMenu_name() %></td>
					<td><%= menuList.get(i).getOrder_menu_price() %></td>
					<td><%= menuList.get(i).getOrder_menu_cnt() %></td>
				</tr>
				<%}//end for%>
			</table>
		</div>
<!--******************************* 메뉴정보 테이블 **********************************  -->
<!--******************************* 버튼 그룹 **********************************  -->
		<div id="buttonGrop">
			<input type="button" value="수정" class="btn btn-dark" id="updateBtn"/>
			<input type="button" value="닫기" class="btn btn-dark" id="closeDetailBtn"/>
		</div>
<!--******************************* 버튼 그룹 **********************************  -->
	</div>
</div>