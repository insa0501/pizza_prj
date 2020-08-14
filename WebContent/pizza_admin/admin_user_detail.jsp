<%@page import="pizza.admin.vo.ResignMemberVO"%>
<%@page import="pizza.admin.vo.MemberDetailVO"%>
<%@page import="pizza.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="popupWrap">
	<div id="popupHeader"></div> <!--************* 헤더 빨간줄 **************  -->
	<div id="popupBody">
	<%
	String user_id = request.getParameter("param_user_id");
	String status = request.getParameter("param_user_status");
	
	pageContext.setAttribute("user_id", user_id);
	pageContext.setAttribute("status", status);
	
	//회원 정보
	MemberDAO mDAO = MemberDAO.getInstance();
	MemberDetailVO mdVO = mDAO.selectMemberDetail(user_id);
	
	//탈퇴 정보
	ResignMemberVO rmVO = mDAO.selectResignMember(user_id);
	%>
<!--******************************* 상태가 회원이면 회원정보, 탈퇴면 탈퇴정보 **********************************  -->
	<c:choose>
		<c:when test="${ '회원' eq status }">
<!--******************************* 회원정보 테이블 **********************************  -->
		<div><h2>회원상세정보</h2></div>
		<div class="userData"><h4>회원 정보</h4></div>
			<table class="userDetailTab">
				<tr>  
					<th class="colTh">아이디</th>
					<td class="colTd">${ user_id }</td>
					<th class="colTh">상태</th>
					<td class="colTd">${ status }</td>
				</tr>
				<tr>
					<th class="colTh">이름</th>
					<td class="colTd"><%= mdVO.getUser_name() %></td>
					<th class="colTh">연락처</th>
					<td class="colTd"><%= mdVO.getUser_phone() %></td>
				</tr>
				<tr>
					<th class="colTh">우편번호</th>
					<td class="colTd"><%= mdVO.getUser_zipcode() %></td>
					<th class="colTh">주소</th>
					<td class="colTd"><%= mdVO.getUser_addr1()+" "+mdVO.getUser_addr2()%></td>
				</tr>
				<tr>
					<th class="colTh">회원 등록일</th>
					<td class="colTd"><%= mdVO.getUser_hiredate() %></td>
					<th class="colTh">ip</th>
					<td class="colTd"><%= mdVO.getUser_ip() %></td>
				</tr>
			</table>
<!--******************************* 회원정보 테이블 **********************************  -->
		</c:when>
		<c:when test="${ '탈퇴' eq status }">
<!--******************************* 탈퇴정보 테이블 **********************************  -->
		<div><h2>탈퇴회원정보</h2></div>
		<div class="userData"><h4>탈퇴 정보</h4></div>
			<table class="userDetailTab">
				<tr>
					<th class="colTh">아이디</th>
					<td class="colTd">${ user_id }</td>
					<th class="colTh">상태</th>
					<td class="colTd">${ status }</td>
				</tr>
				<tr>
					<th class="colTh">탈퇴일</th>
					<td class="colTd"><%= rmVO.getUser_resign_date() %></td>
					<th class="colTh"></th>
					<td class="colTd"></td>
				</tr>
				<tr>
					<th colspan="4" class="colTh">탈퇴사유</th>
				</tr>
				<tr>
					<td colspan="4" class="colTd"><%= rmVO.getUser_resdata() %></td>
				</tr>
			</table>
		</c:when>
	</c:choose>
<!--******************************* 탈퇴정보 테이블 **********************************  -->
<!--******************************* 버튼 그룹 **********************************  -->
		<div id="buttonGrop">
			<input type="button" value="확인" class="btn btn-dark" onclick="closeDetail()"/>
			<input type="button" value="닫기" class="btn btn-dark" onclick="closeDetail()"/>
		</div>
<!--******************************* 버튼 그룹 **********************************  -->
	</div>
</div>