<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"
    info="결제처리 (DB insert) 를 하는 페이지"%>
<%
// 결제시 추가 되어야 할 항목
// order_list
// order_no - 시퀀스 (기본키), order_date - sysdate, user_id, user_zipcode, user_addr1, user_addr2
// user_phone, order_price, order_status, order_pay, user_ip - getHostName()?
		

		
		
// order_menu
// menu_name - (menu table)(기본키), order_no -(order_list table)(기본키)
// order_menu_price - cnt * price, order_menu_cnt - cnt 
%>   