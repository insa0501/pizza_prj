<%@page import="java.io.IOException"%>
<%@page import="pizza.dao.MenuDAO"%>
<%@page import="pizza.admin.vo.AddMenuVO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
 <%
    request.setCharacterEncoding("UTF-8");
 
 
 %>
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
 
</head>
<body> 
<div id="popupWrap">
	<div id="popupHeader"></div> <!--******* 헤더 빨간줄 ***********  -->
	<div id="popupBody">
	
	
	<jsp:useBean id="amVO" class="pizza.admin.vo.AddMenuVO"/>
	<jsp:setProperty property="*" name="amVO"/>
	 <!-- 메뉴 추가  -->
<%

  String menu_img =  request.getParameter("upfile");
  String admin_id = (String)session.getAttribute("admin_id");
 
%>	
 

   <%
     amVO.setAdmin_id(admin_id); //아이디 세션값 받아오는 걸로 나중에 변경
     amVO.setMenu_img(menu_img); //아이디 세션값 받아오는 걸로 나중에 변경
 
   %>
<%--    <%= amVO.getMenu_name() + " -- "+amVO.getMenu_price()+" -- "+amVO.getMenu_type() 
       + "----비활성화여부>"+amVO.getMenu_activity() +"------"+ amVO.getAdmin_id()  +"------"+amVO.getMenu_img() %> --%>
       
   <%
      MenuDAO menu_dao = MenuDAO.getInstance();
    
      menu_dao.insertMenu(amVO);
      
   /*    location.href=""; */
    %>    
    <script type="text/javascript">
    
      alert("메뉴가 추가되었습니다!");
      location.href="http://localhost/pizza_prj/pizza_admin/admin_menu_mgr.jsp";
    </script>
     
	  
	</div>
	 
</div>
</body>
</html>
