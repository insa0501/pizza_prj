<%@page import="pizza.admin.vo.UpdateMenuVO"%>
<%@page import="pizza.admin.vo.MenuDetailVO"%>
<%@page import="pizza.dao.MenuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
<%
String admin_id = (String)session.getAttribute("admin_id") == null ? "admin1":(String)session.getAttribute("admin_id");
String menu_name = request.getParameter("menuName");
String menu_type = request.getParameter("menuType");
int menu_price = Integer.parseInt(request.getParameter("menuPrice"));
String menu_img = "".equals(request.getParameter("menuImg")) ? "logo.png":request.getParameter("menuImg");
String menu_activity = "on".equals(request.getParameter("menuActivity")) ? "N":"Y";

UpdateMenuVO mVO = new UpdateMenuVO();

mVO.setMenu_name(menu_name);
mVO.setAdmin_id(admin_id);
mVO.setMenu_type(menu_type);
mVO.setMenu_price(menu_price);
mVO.setMenu_img(menu_img);
mVO.setMenu_activity(menu_activity);

MenuDAO mDAO = MenuDAO.getInstance();
int result = mDAO.updateMenu(mVO);


%>
alert("'<%= menu_name %>' <%= result %>건 수정되었습니다.");
location.href="admin_menu_mgr.jsp?page_flag=admin_menu_detail&param_menu="+"<%= menu_name %>";
</script>