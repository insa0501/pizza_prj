<%@page import="java.sql.SQLException"%>
<%@page import="pizza.dao.MemberDAO"%>
<%@page import="pizza.admin.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="pizza.admin.vo.SelectOrderVO"%>
<%@page import="pizza.admin.vo.SelectMemberVO"%>
<%@page import="pizza.dao.OrderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            float: left;
            text-align: center;
        }
        #search{
            left:50%;

            /* 디자인 적용되면 꼬일듯 */
            width: 330px;
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
	#popupWrap{ width: 700px; min-height: 400px; border: 1px solid #BFBFBF; background-color: #FFFFFF}
	#popupHeader{ height: 30px; background-color: #C10A28; margin-top: 20px}
	#popupBody{ min-height: 368px; margin-top: 25px; margin-left: 40px }
	#buttonGrop{ margin-top: 35px; margin-left: 245px; margin-bottom: 20px; clear: both}
	.userData{ margin-top: 25px}
	.userDetailTab{ width: 620px; border: 1px solid #CFCFCF; border-spacing: 0px; }
	.colTh{width: 100px; height: 35px; text-align: center;}
	.colTd{width: 210px; height: 35px;}
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
    <div id="container" style="clear: both">
        <div id="page_title">회원관리</div>
        <form action="admin_user_mgr.jsp">
        <div id="search">
            <div id="search_item">
                <select name="selectType">
                
                    <option value="user_id"${ param.selectType=="user_id"?" selected='selected'":"" }>아이디</option>
                    <option value="user_name"${ param.selectType=="user_name"?" selected='selected'":"" }>회원명</option>
                    <option value="user_addr1"${ param.selectType=="user_addr1"?" selected='selected'":"" }>주소</option>
                    <option value="user_phone"${ param.selectType=="user_phone"?" selected='selected'":"" }>연락처</option>
                    <option value="user_status"${ param.selectType=="user_status"?" selected='selected'":"" }>상태</option>
                </select>
            </div>
            <div id="search_input"><input type="text" value="${ param.selectData }" name="selectData"/></div>
            <div id="search_btn"><input type="submit"id="search_btn" value="검색"/></div>
        </div>
        </form>
    
        <div id="result">
            <table id="user_tab">
                <tr>
                    <th style="width: 200px;">아이디</th>
                    <th style="width: 100px;">회원명</th>
                    <th style="width: 200px;">주소</th>
                    <th style="width: 150px;">연락처</th>
                    <th style="width: 80px;">상태</th>
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
                    	%>&param_user_status=<%= mVO.getUser_status() %>"><%= mVO.getUser_id() %></a>
                    </td>
                    <td><%= mVO.getUser_name()==null?"":mVO.getUser_name() %></td>
                    <td><%= mVO.getUser_addr1()==null?"":mVO.getUser_addr1() %></td>
                    <td><%= mVO.getUser_phone()==null?"":mVO.getUser_phone() %></td>
                    <td><%= mVO.getUser_status() %></td>
                </tr>
            <%}//end for%>
            </table>
        </div>
        <div id="result_paging" style="height: 20px; text-align: center;">
        <%= indexList(currentPage, totalPage, "admin_user_mgr.jsp?"+selectQuery.toString()) %>
        </div>
            <%
            } catch(SQLException se) {
            	se.printStackTrace();
            }//end catch
            %>
    </div>
</body>
</html>