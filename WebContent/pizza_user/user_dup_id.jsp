<%@page import="java.sql.SQLException"%>
<%@page import="pizza.dao.MemberDAO"%>
<%@page import="pizza.user.vo.InsertMemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/user_dup_id_css.css">
<title>아이디 확인</title>

<!-- Google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
   $("#btn").click(function(){
      chkNull();
   });//click
   
   $("[name='user_id']").keydown(function(evt){
      if(evt.which == 13 ){
         chkNull();
      }//end if
   });//keydown
});//ready

   function chkNull(){
      if($("[name='user_id']").val().trim()==""){
         alert("중복검사에 사용할 아이디는 필수 입력입니다.");
         return;
      }//end if
      
      if($("[name='user_id']").val().replace(/[0-9A-Za-zㄱ-힣]/g, "") != ""){
         alert("아이디는 숫자, 소문자, 대문자,한글로만 이루어질 수 있습니다.");
         $("[name='id']").val("");
         return;
      }
      
      $("[name='cFrm']").submit();
      
   }//chkNull

   function useId(id){
      opener.window.document.frm.user_id.value=id;
      self.close();
      return;
   }//useId
   

</script>
</head>
<body>
<div class="top_line"></div>

<div id="idWrap" class="id_wrap">
   <form name="cFrm" action="user_dup_id.jsp" method="get">
	   <div id="idFrm" class="id_form">
	      <label>아이디</label>
	      <input type="text" name="user_id" class="inputBox"/>
	      <input type="text" style="display:none"/>
	      <input type="button" value="사용" id="btn" name="btn" class="useBtn" />
	   </div>
	<%
	   String user_id = request.getParameter("user_id");
	   if( user_id != null ){
	      MemberDAO mDAO = MemberDAO.getInstance();
	      try{
	      if(mDAO.selectDupId(user_id)){//아이디가 존재하는 경우
	         %>
	         <div class="id_warning">해당 아이디가 이미 존재합니다.</div>
	         <%
	      }else{
	         pageContext.setAttribute("id", user_id);
	         %>
	         <div class="id_possible">
	         	<span><c:out value="${pageScope.id }"/> 아이디는 사용 가능합니다.</span>
	         	<a href="#void" id="use" class="use_id" onclick="useId('${pageScope.id}')">사용하기</a>
	         </div>
	         <%
	      }//end else
	      }catch( SQLException se){
	         se.printStackTrace();
	      }// end catch
	   }//end if
	%>
   </form>
   
   
</div>
</body>
</html>