<%@page import="java.sql.SQLException"%>
<%@page import="pizza.dao.MemberDAO"%>
<%@page import="pizza.admin.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="pizza.admin.vo.SelectOrderVO"%>
<%@page import="pizza.admin.vo.SelectMemberVO"%>
<%@page import="pizza.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String id = (String) session.getAttribute("admin_id");
if(id == null) {
	response.sendRedirect("http://localhost/pizza_prj/pizza_admin/admin_login.jsp");
}//end if
/******************************* 캐시를 기록을 막아서 로그아웃이 뒤로가기로 접근 막기 **********************************/
response.setHeader( "Cache-Control", "no-store, no-cache, must-revalidate");  //HTTP 1.1
response.setDateHeader ("Expires", -1); //prevents caching at the proxy server

//현재페이지 번호
String paramPage = request.getParameter("current_page");	//현재 페이지 번호
if(paramPage == null) {
	paramPage = "1";
}//end if

int currentPage = Integer.parseInt(paramPage);

//검색정보
String selectType = request.getParameter("selectType");
String selectData = request.getParameter("selectData");

if(selectType==null) {
	selectType = "";
}//end if
if(selectData==null) {
	selectData = "";
}//end if

//검색데이터 및 현재페이지를 담은 쿼리스트링
StringBuilder selectQuery = new StringBuilder();
selectQuery
.append("selectType=")
.append(selectType)
.append("&selectData=")
.append(selectData);
%>
<%!
public String indexList(int current_page, int total_page, String list_url) {

String indexList=""; //페이지 이동을 위한 폼의 형태를 저장할 변수 ex. [<<]...[1][2]...[>]와 같은 형태 띄우기

int pageNumber=0; //페이지 이동을 위한 폼에 한번에 표시될 번호의 개수
int startPage=0; //페이지 이동을 위한 폼의 표시될 시작 번호
int endPage=0; //페이지 이동을 위한 폼의 표시될 마지막 번호 
int curPage=0; //페이지 폼의 링크를 눌렀을 때의 이동과 폼에 표시될 페이지번호를 저장할 변수

pageNumber = 10; //페이지 이동을 위한 폼에 한번에 10개의 번호를 표시.

startPage = ((current_page - 1) / pageNumber) * pageNumber + 1;
endPage = (((startPage - 1) + pageNumber) / pageNumber) * pageNumber;

if (total_page <= endPage){	//총페이지가 페이지 이동을 위한 폼의 표시될 마지막 번호보다 작다면
	endPage = total_page;	//마지막 번호는 총페이지 번호로 변경
}//end if

if (current_page > pageNumber) {	//현재페이지가 폼에 표시된 번호보다 크다면
	curPage = startPage - 1; 		//[<<]눌렀을 때 이동할 페이지 번호를 변수에 담고
	indexList = indexList + "<a href='"+list_url+"&current_page="+curPage+"'>[<<]</a>";		//[<<]를 a태그에 담아서 페이지이동 폼을 표현할 변수에 저장
	indexList = indexList + " ... ";	//폼 형태를 담은 변수에 ' ... '을 추가
}//end if

curPage = startPage;	//폼의 시작번호를 페이지 이동용 임시 변수에 저장
while (curPage <= endPage){		//페이지 이동용 임시 변수가 폼의 마지막 번호보다 작거나 같다면
	//[번호]를 a태그에 담아서 폼 형태를 담은 변수에 추가
	if(current_page==curPage){
		indexList = indexList +"<a href='"+list_url+"&current_page="+curPage+"' class='pagination_num active'> "+curPage+" </a>";		
	} else {
		indexList = indexList +"<a href='"+list_url+"&current_page="+curPage+"' class='pagination_num'> "+curPage+" </a>";		
	}
	curPage++;	//페이지 이동용 임시 변수를 증가시켜서 페이지이동 폼의 번호가 for문처럼 만들어지게 한다.
}//end while
	

if (total_page > endPage) {	//폼의 마지막 번호가 총페이지보다  작다면
	indexList = indexList + " ... ";	//'[<<]...[번호][][][]'이 저장된 변수에 ' ... '을 추가
	curPage = endPage + 1;		//[>>]눌렀을 때 이동할 페이지 번호를 변수에 담고
	indexList = indexList + "<a href='"+list_url+"&current_page="+curPage+"'>[>>]</a>";		//[>>]를 a태그에 담아서 폼 형태를 담은 변수에 추가
}//end if
	
return indexList;	//페이지 이동폼을 담은 변수를 반환
}//indexList

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

<!-- Google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link rel="stylesheet" href="../common/css/common_header_footer.css">
<link rel="stylesheet" href="../common/css/commom_admin_tables.css">
<link rel="stylesheet" href="css/admin_user_detail_css.css">
 
<script type="text/javascript">

	/************************* 팝업창이 열린 페이지면 뒤로가기로 다시 접근 막기 ****************************/
	<%
	if(request.getParameter("page_flag") != null) {
	%>
		window.history.forward();
		function noBack(){window.history.forward();}
	<%
	}//end if
	%>

	$(function() {
		
	});//ready

	function logout() {
		location.href = "http://localhost/pizza_prj/pizza_admin/admin_logout.jsp";
	}//logout
	
	/******************************* 팝업창 닫기 **********************************/
	function closeDetail() {
		location.href="admin_user_mgr.jsp?<%= selectQuery.toString() 
			%>&current_page=<%= currentPage %>";
	}//closeDetail
	
</script>
</head>
<body>
    <section class="header">
        <div class="header_top"></div>
        <div class="header_logoImg">
			<img src="http://localhost/pizza_prj/common/images/logo.png">
		</div>
    <!--******************************* 팝업창 열기 **********************************  -->
		<c:if test="${ not empty param.page_flag }">
		<div style="position:absolute; z-index:9999; left: 400px; top: 100px">
		<c:import url="${ param.page_flag }.jsp"></c:import>
		</div>
		</c:if>
	<!--******************************* 팝업창 열기 **********************************  -->
        <div class="header_nav" id="header_nav">
            <div>
                <a href="admin_order_mgr.jsp">주문관리</a>
                <a href="admin_menu_mgr.jsp">메뉴관리</a>
                <a href="admin_user_mgr.jsp">유저관리</a>
            </div>
            <div><a href="#void" onclick="logout()">로그아웃</a></div>
        </div>
    </section>
    <section class="main_container">
        <div class="page_title">회원관리</div>
        
        <form action="admin_user_mgr.jsp">
        <div id="search">
       		<div class="section_search">
	            <div id="search_item" class="selectbox">
	                <select name="selectType" id="item_select" class="item_select">
	                    <option value="user_id"${ param.selectType=="user_id"?" selected='selected'":"" }>아이디</option>
	                    <option value="user_name"${ param.selectType=="user_name"?" selected='selected'":"" }>회원명</option>
	                    <option value="user_addr1"${ param.selectType=="user_addr1"?" selected='selected'":"" }>주소</option>
	                    <option value="user_phone"${ param.selectType=="user_phone"?" selected='selected'":"" }>연락처</option>
	                    <option value="user_status"${ param.selectType=="user_status"?" selected='selected'":"" }>상태</option>
	                </select>
	            </div>
	            <div id="search_input"><input type="text" id="selectData" class="input_selectData" name="selectData" placeholder="검색어를 입력하세요"/></div>
                <div id="search_btn"><input type="submit"value="검색" class="btn_submit"/></div>
	            <c:if test="${not empty param.selectData }">
		            <div id="searched_text" class="searched_text"> [ ${ param.selectData } ] 로 검색한 결과입니다.</div>
	            </c:if>
        	</div>
        </div>
        </form>
    
        <div id="result">
            <table id="user_tab" class="table">
                <tr class="table-danger">
                    <th style="text-align: center">아이디</th>
                    <th style="text-align: center">회원명</th>
                    <th style="text-align: center">주소</th>
                    <th style="text-align: center">연락처</th>
                    <th style="text-align: center">상태</th>
                </tr>
            <%
            try{
            MemberDAO mDao = MemberDAO.getInstance();
            
            SelectMemberVO smVO = new SelectMemberVO(selectType,selectData);
            List<MemberVO> memberList = mDao.selectMemberList(smVO);

    		//1. 한 화면에 보여줄 게시물의 수
    		int pageScale = 10;
    		
    		//2. 총 페이지 수
    		int totalPage = (int) Math.ceil((double)(memberList.size())/pageScale);
            pageContext.setAttribute("totalPage", totalPage);
    		
            //페이지가 처음 켜졌을 때 게시물의 시작번호
            int start_num = (currentPage-1)*(pageScale-1) + currentPage;
            
            //페이지가 처음 켜졌을 때 게시물의 끝번호
            int end_num = currentPage*pageScale;
            
            //게시물의 끝번호가 게시물의 총 개수보다 많다면 게시물의 끝번호를 게시물의 개수와 동일하게 변경.
            if(end_num > memberList.size()) {
            	end_num = memberList.size();
            }//end if
            
            MemberVO mVO = null;
          	//게시물 테이블
            for(int i=start_num-1; i<end_num; i++) {
            	mVO = memberList.get(i);
            %>
                <tr>
                    <td>
                    	<a href="admin_user_mgr.jsp?<%= selectQuery.toString() %>&current_page=<%= currentPage 
                    	%>&page_flag=admin_user_detail&param_user_id=<%= mVO.getUser_id()
                    	%>&param_user_status=<%= mVO.getUser_status() %>" class="table_a"><%= mVO.getUser_id() %></a>
                    </td>
                    <td><%= mVO.getUser_name()==null?"":mVO.getUser_name() %></td>
                    <td><%= mVO.getUser_addr1()==null?"":mVO.getUser_addr1() %></td>
                    <td><%= mVO.getUser_phone()==null?"":mVO.getUser_phone() %></td>
                    <td><%= mVO.getUser_status() %></td>
                </tr>
            <%}//end for%>
            </table>
        </div>
        <div id="result_paging" class="section_pagination">
        <%= indexList(currentPage, totalPage, "admin_user_mgr.jsp?"+selectQuery.toString()) %>
        </div>
            <%
            } catch(SQLException se) {
            	se.printStackTrace();
            }//end catch
            %>
    </section>
</body>
</html>