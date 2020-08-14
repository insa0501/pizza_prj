<%@page import="pizza.admin.vo.MenuListVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="pizza.admin.vo.SelectMenuVO"%>
<%@page import="pizza.dao.MenuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String id = (String) session.getAttribute("admin_id");
if(id == null) {
	response.sendRedirect("http://localhost/pizza_prj/pizza_admin/admin_login.jsp");
	return;
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

//검색조건이 상태일 경우, 활성이 입력되면 검색값을 Y로 비활이 입력되면 N으로 변경
if("menu_activity".equals(selectType) && selectData.contains("활성")) {
	selectData = "Y";
} else if("menu_activity".equals(selectType) && selectData.contains("비활")) {
	selectData = "N";
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
	indexList = indexList +"<a href='"+list_url+"&current_page="+curPage+"'>["+curPage+"]</a>";		//[번호]를 a태그에 담아서 폼 형태를 담은 변수에 추가
		
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
    <style type="text/css">
        #container{
            width: 100vw;
            border: 1px solid;
            position: absolute;
        }
        #page_title{
            font-size: x-large;
        }
        table{
            clear: both;
            margin:0 auto;
            border-collapse: collapse;
        }
        tr,td,th{
            border-collapse: collapse;
            border:1px solid;
        }
        th{
            background-color: bisque;
        }
        #search > div{
            text-align: center;
        }
        #search{

            /* 디자인 적용되면 꼬일듯 */
            margin-left: -165px;
            /*  */

            position: relative;
            text-align: center;
        }
        #result{
            height: 400px;
        }
        #result_paging{
            margin:0 auto;
        }

        ul{
            list-style: none;
            margin:0;
            padding:0;
            text-align: center;
        }
        li{
            margin: 0 auto;
            padding: 0 0 0 0;
            border:0;
            display: inline;
        }
        * {
    box-sizing: border-box;
}

html, body {
    margin: 0px;
    padding: 0px;
}

/* header nav */
.header > a:link, a:visited {
}
.header_top {
    width: 100vw;
    height: 40px;
    background-color: white;
    position: relative;
}
.header_nav {
    width: 100vw;
    height: 70px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    background-color: rgb(197, 0, 0);
    color: white;
    font-size: 1em;
}
.header_nav > div {
    width: 200px;
    display: flex;
    justify-content: space-between;
}
.header_nav > div:first-child {
    margin-left: 15vw;
}
.header_nav > div:last-child {
    margin-right: 15vw;
}
.header_nav > span {
    padding: 0 10px;
}
/******************************* 팝업창 관련 CSS **********************************/
	#popupWrap{width: 700px; min-height: 400px; border: 1px solid #BFBFBF; background-color: #FFFFFF}
	#popupHeader{height: 30px; background-color: #C10A28; margin-top: 20px}
	#popupBody{min-height: 325px; margin-top: 25px; margin-left: 30px; margin-right: 30px}
	#buttonGrop{margin-top: 20px; margin-left: 245px; margin-bottom: 20px; clear: both}
	.menuImgGrop{width: 110px; height: 250px; margin-top: 25px; float: left; text-align: center;}
	.menuImg{margin-bottom: 20px; border: 1px solid #CFCFCF}
	.menuData{height: 250px; margin-top: 25px; float: right;}
	.menuDetailTab{border: 1px solid #CFCFCF; border-spacing: 0px;}
	.colTh{width: 90px; height: 35px; text-align: center;}
	.colTd1{width: 180px; height: 35px;}
	.colTd2{width: 120px; height: 35px;}
	th{vertical-align: middle; border: 1px solid #CFCFCF; background-color: #EAEAEA}
	td{text-align: center; vertical-align: middle; border: 1px solid #CFCFCF}
/******************************* 팝업창 관련 CSS **********************************/

    </style>
<!-- Google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

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

		/******************************* 팝업창 닫기 **********************************/
		$("#closeFrm").click(function() {
			location.href="admin_menu_mgr.jsp?<%= selectQuery.toString() 
				%>&current_page=<%= currentPage %>";
		});//click
		
		/************************** 2020-08-13 팝업창에서 수정버튼 클릭 *******************************/
		$("#updateMenu").click(function(){
 			var menuImg = $("#menuImg").val();
			var menuImgName = menuImg.substring(menuImg.lastIndexOf("\\")+1,menuImg.length); 
			
			menuImgName = menuImgName == ""?"logo.png":menuImgName;
			console.log(menuImgName);
			
			if($("#menuType").val() == ""){
				alert("메뉴분류는 필수입력입니다.");
				return;
			}//end if
			
			if($("#menuPrice").val() == ""){
				alert("판매가는 필수입력입니다.");
				return;
			}//end if
			
			console.log($("#menuName").val());
			console.log($("#menuType").val());
			console.log($("#menuActivity").is(":checked")?"Y":"N");
			
			if($("#menuType").val() != '사이드' && $("#menuType").val() != '피자'){
				alert("'"+$("#menuType").val()+"'는 설정되지 않은 메뉴분류입니다.");
				return;
			}//end if
			
			if($("#menuPrice").val()>99999) {
				alert("'"+$("#menuPrice").val()+"'의 최대값은 99999입니다.");
				return;
			}//end if
			
			var menu_act = $("#menuActivity").is(":checked")?"비활성":"활성";
			var msg = "메뉴명 : "+$("#menuName").val() + 
						"\n판매가 : "+$("#menuPrice").val()+"원"+
						"\n메뉴분류 : "+$("#menuType").val()+
						"\n이미지 : "+menuImgName+
						"\n활성화 여부 : "+menu_act+
						"\n수정하시겠습니까?";
			
			if(!confirm(msg)){
				alert("변경취소");
				return;
			};
			
			$("#detailFrm").submit();
		})//click
		/**********************************************************************/
		
		/****************************경로에 파일이 있을 때 프리뷰************************/
/* 		$("#menuImg").change(function(){
			console.log("../images/"+$("#menuImg").val())
			var menuImg = $("#menuImg").val();
			var menuImgName = menuImg.substring(menuImg.lastIndexOf("\\")+1,menuImg.length); 
			$("#displayImg").attr("src","../images/"+menuImgName);
		}) */
		/**********************************************************************/
	});//ready
	
	function logout() {
		location.href = "http://localhost/pizza_prj/pizza_admin/admin_logout.jsp";
	}//logout
	
</script>

</head>
<body>
    <section class="header">
        <div class="header_top"></div>
    <!--******************************* 팝업창 열기 **********************************  -->
			<c:if test="${ not empty param.page_flag }">
			<div style="position:absolute; z-index:9999; left: 650px; top: 70px">
			<c:import url="${ param.page_flag }.jsp"></c:import>
			</div>
			</c:if>
	<!--******************************* 팝업창 열기 **********************************  -->
        <div class="header_nav" id="header_nav">
            <div style="float: left">
                <a href="admin_order_mgr.jsp">주문관리</a>
                <a href="admin_menu_mgr.jsp">메뉴관리</a>
                <a href="admin_user_mgr.jsp">유저관리</a>
            </div>
            <div style="float: right"><a href="#void" onclick="logout()">로그아웃</a></div>
        </div>
    </section>
    <div id="container">
        <div id="page_title">메뉴관리</div>
        <form action="admin_menu_mgr.jsp">
        <div id="search">
                <select name="selectType">
                    <option value="menu_name"${ param.selectType=="menu_name"?" selected='selected'":"" }>메뉴명</option>
                    <option value="menu_price"${ param.selectType=="menu_price"?" selected='selected'":"" }>판매가</option>
                    <option value="menu_type"${ param.selectType=="menu_type"?" selected='selected'":"" }>메뉴분류</option>
                    <option value="menu_activity"${ param.selectType=="menu_activity"?" selected='selected'":"" }>상태</option>
                </select>
            <input type="text" name="selectData" value="${ param.selectData }"/>
            <input type="submit" id="search_btn" value="검색"/>
            <a href="admin_menu_mgr.jsp?page_flag=admin_menu_add"><input type="button" value="메뉴추가"/></a>
        </div>
        </form>
    
        <div id="result">
            <table id="menu_tab">
                <tr>
                    <th style="width: 250px;">메뉴명</th>
                    <th style="width: 120px;">판매가</th>
                    <th style="width: 100px;">메뉴분류</th>
                    <th style="width: 100px;">상태</th>
                </tr>
            <%
            try{
		
            MenuDAO mDao = MenuDAO.getInstance();
            SelectMenuVO smVO = new SelectMenuVO(selectType, selectData);
            List<MenuListVO> menuList = mDao.selectMenu(smVO);

    		//1. 한 화면에 보여줄 게시물의 수
    		int pageScale = 10;
    		
    		//2. 총 페이지 수
    		int totalPage = (int) Math.ceil((double)(menuList.size())/pageScale);
            pageContext.setAttribute("totalPage", totalPage);
            
            //페이지가 처음 켜졌을 때 게시물의 시작번호
            int start_num = (currentPage-1)*(pageScale-1) + currentPage;
            
            //페이지가 처음 켜졌을 때 게시물의 끝번호
            int end_num = currentPage*pageScale;
            
            //게시물의 끝번호가 게시물의 총 개수보다 많다면 게시물의 끝번호를 게시물의 개수와 동일하게 변경.
            if(end_num > menuList.size()) {
            	end_num = menuList.size();
            }//end if
            
            MenuListVO mVO = null;
            //게시물 테이블
            for(int i=start_num-1; i<end_num; i++) {
            	mVO = menuList.get(i);
            %>
                <tr>
                    <td>
                    	<a href="admin_menu_mgr.jsp?<%= selectQuery.toString() %>&current_page=<%= currentPage
                    	%>&page_flag=admin_menu_detail&param_menu=<%= mVO.getMenu_name() %>"><%= mVO.getMenu_name() %></a>
                    </td>
                    <td><%= mVO.getMenu_price() %></td>
                    <td><%= mVO.getMenu_type() %></td>
                    <td><%= "Y".equals(mVO.getMenu_activity())?"활성화":"비활성화" %></td>
                </tr>
            <%}//end for%>
            </table>
        </div>
        <div id="result_paging" style="height: 20px; text-align: center;">
        <%= indexList(currentPage, totalPage, "admin_menu_mgr.jsp?"+selectQuery.toString()) %>
        </div>
            <%
            } catch(SQLException se) {
            	se.printStackTrace();
            }//end catch
            %>
    </div>

</body>
</html>