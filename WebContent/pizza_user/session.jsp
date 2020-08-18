<%@page import="pizza.admin.vo.UpdateResignVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="pizza.user.vo.UserInfoVO"%>
<%@page import="pizza.user.vo.LoginVO"%>
<%@page import="pizza.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	session.setAttribute("user_id", "test5");
String user_id = (String)session.getAttribute("user_id");
	response.sendRedirect("user_info_check.jsp");
	
%>
