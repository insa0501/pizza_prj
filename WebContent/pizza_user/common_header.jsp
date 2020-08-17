<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="헤더부분 입니다"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
			<c:choose>
				<c:when test="${not empty user_name}">
					<a href="http://localhost/pizza_prj/pizza_user/user_order_list.jsp">
						<strong><c:out value="${user_name}" />님</strong></a>
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