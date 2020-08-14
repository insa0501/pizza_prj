
<%@page import="pizza.user.vo.UpdateUserInfoVO"%>
<%@page import="pizza.admin.vo.UpdateResignVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="pizza.user.vo.UserInfoVO"%>
<%@page import="pizza.user.vo.LoginVO"%>
<%@page import="pizza.dao.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
String user_id = (String)session.getAttribute("user_id");
if(user_id == null || request.getParameter("user_pass")==null ){//세션에서 꺼내온 아이디가 없다.
	System.out.println("적용");
	response.sendRedirect("http://localhost/pizza_prj/pizza_user/main.jsp");
	return;
}//end if
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="http://localhost/pizza_prj/common/css/main.css">
<link rel="stylesheet" type="text/css" href="http://localhost/pizza_prj/common/css/common_header.css">
<link rel="stylesheet" type="text/css" href="http://localhost/pizza_prj/common/css/common_footer.css">

<title>회원정보수정</title>
<style type="text/css">
#container{ min-height:600px; width:80vw; margin:25px auto; }
<%-- 회원정보수정 부분 --%>
#user_info { margin-left: 30px; width:470px; }
label { width: 140px; height: 30px; font-weight: bold;}
.searchBtn{background-color: #3597DE; color:#FFFFFF; font-weight: bold; border-radius: 5px; border: none; padding:3px 10px 3px 10px;}
.resignBtn{background-color: #E84C3D; color:#FFFFFF; width:80px;
			font-weight: bold; border-radius: 5px; 
			border: none; padding:3px 10px 3px 10px; margin-right:15px;}
			
<%-- 회원탈퇴사유부분 --%>	
#user_resign { margin-left: 30px; width:550px; }
.chkBox{ margin-bottom: 6px; margin-right:5px;}

</style>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<!-- 다음 api 우편번호 검색 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- Google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>


<script type="text/javascript">
$(function(){
	
	//탈퇴 버튼이 클릭 된 경우
	$(".resignBtn").click(function(){
		$("#page_flag").val("resign");
		
		$("#frm").submit();
	});//click
	//변경 버튼이 클릭된 경우
	$("#searchBtn").click(function(){
		$("#page_flag").val("update");
		
		$("#frm").submit();
	});//click
	
<%-- @@@@@@@@@@@@@@@@@@@@@@@@우편번호 검색@@@@@@@@@@@@@@@@@@@@@@@@ --%>
	$("#searchZip").click(function(){
		searchZipcode();
	})//
<%-- @@@@@@@@@@@@@@@@@@@@@@@@우편번호 검색@@@@@@@@@@@@@@@@@@@@@@@@ --%>
});//ready



<%-- @@@@@@@@@@@@@@@@@@@@@@@@우편번호 검색@@@@@@@@@@@@@@@@@@@@@@@@ --%>
function searchZipcode(){//다음 API를 사용한 우편번호 찾기
	
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('zipcode').value = data.zonecode;
            document.getElementById("addr1").value = roadAddr;
          //  document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
            
        }
    }).open();
	
}//searchZipcode
<%-- @@@@@@@@@@@@@@@@@@@@@@@@우편번호 검색@@@@@@@@@@@@@@@@@@@@@@@@ --%>
<%
	MemberDAO mDAO = MemberDAO.getInstance();
	//버튼을 누르고 화면에 들어왔을 경우
	if( request.getParameter("page_flag") != null){
	if( request.getParameter("page_flag").equals("resign") ){
		String[] user_resdata = request.getParameterValues("resign_data");
		StringBuilder sb = new StringBuilder();
		if( user_resdata != null ){
			for( String temp : user_resdata ){
				sb.append(temp).append("");
			}///end for
		} else {
			//선택을 안한 경우
			sb.append("개인적인 사유");
		}//end else
		UpdateResignVO urVO = new UpdateResignVO();
		urVO.setUser_id(user_id);
		urVO.setUser_resdata(sb.toString());
		String msg = "회원정보를 삭제하지 못하였습니다.";
		try{
			int cnt = mDAO.updateResign(urVO);
			if( cnt == 1 ){
				msg = "회원정보가 삭제되었습니다.";
				session.setAttribute("user_id", "");
				session.removeAttribute("user_name");
				session.invalidate();
			}//end if
		} catch (SQLException se){
			msg="처리중 문제가 발생하였습니다. 잠시 후 다시 시도해주세요.";
			se.printStackTrace();
		}//end catch
		%>
		alert("<%= msg%>");
		location.href="http://localhost/pizza_prj/pizza_user/main.jsp";
		<%
	}//탈퇴 버튼을 누르고 화면에 들어왔을 경우
	if( request.getParameter("page_flag").equals("update") ){
		String msg= "변경이 실패하였습니다.";
		UpdateUserInfoVO uuiVO = new UpdateUserInfoVO(request.getParameter("user_pass"),
				request.getParameter("user_phone"), request.getParameter("user_zipcode"),
				request.getParameter("user_addr1"), request.getParameter("user_addr2")
				, user_id);
		try{
		mDAO.updateUserInfo(uuiVO);
		msg = "변경이 완료되었습니다.";
		} catch (SQLException se){
			se.printStackTrace();
		}//end catch
		%>
		alert("<%= msg%>");
		location.href="http://localhost/pizza_prj/pizza_user/main.jsp";
		<%
	}//변경버튼이 눌려지고 들어온 경우
	}//버튼이 눌려지고 들어온 경우
	
	
	String user_pass = request.getParameter("user_pass");
	LoginVO lVO = new LoginVO();
	lVO.setUser_id(user_id);
	lVO.setUser_pass(user_pass);
	
	UserInfoVO uiVO = null;
	
	try{
		uiVO =  mDAO.selectMyData(lVO);
		%>
	<%
	} catch( SQLException se ){
		se.printStackTrace();
		response.sendRedirect("user_info_check.jsp");
		return;
	}
	
	if( uiVO == null ){//비밀번호가 틀려서 조회결과가 없을 경우
		response.sendRedirect("user_info_check.jsp");
		return;
	}
	
	pageContext.setAttribute("user_pass", request.getParameter("user_pass"));
	pageContext.setAttribute("user_phone", uiVO.getUser_phone());
	pageContext.setAttribute("user_zipcode", uiVO.getUser_zipcode());
	pageContext.setAttribute("user_addr1", uiVO.getUser_addr1());
	pageContext.setAttribute("user_addr2", uiVO.getUser_addr2());
	
%>


</script>
</head>
<body>
<div id="wrap">
	<c:import url="../common/jsp/common_header.jsp"></c:import>
	
	<div id="container">
	<form action="user_info_change.jsp" name="frm" id="frm" method="post"><!-- form 태그  -->
	<input type="hidden" id="page_flag" name="page_flag" />
	<h3>회원정보수정</h3><br/>
	<ul id="user_info">
		<li>
			<label>아이디</label>
			<label><%=user_id %></label>
		</li>
		<li>
			<label>비밀번호</label>
			<input type="password" name="user_pass" class="user_text" value="${pageScope.user_pass }"/>
		</li>
		<li>
			<label>비밀번호 확인</label>
			<input type="password"  class="user_text" value="${pageScope.user_pass }"/>
		</li>
		<li>
			<label>전화번호</label>
			<input type="text" name="user_phone" class="user_text" value="${pageScope.user_phone }"/>
		</li>
		<li>
			<label>우편번호</label>
			<input type="text" name="user_zipcode" class="user_text"readonly="readonly" id="zipcode" value="${pageScope.user_zipcode }"/>
			<input type="button" value="검색" class="searchBtn" id="searchZip"/>
		</li>
		<li>
			<label>주소</label>
			<input type="text" name="user_addr1" class="user_text" readonly="readonly" id="addr1" value="${pageScope.user_addr1 }"/>
		</li>
		<li>
			<label>상세주소</label>
			<input type="text" name="user_addr2" class="user_text" value="${pageScope.user_addr2 }"/>
		</li>
	</ul>
	<div style="text-align: right; margin-right:50px;">
		<input type="button" value="탈퇴" class="resignBtn"/>
		<input type="button" value="변경" id="searchBtn" class="searchBtn" style="width:80px;"/>
	</div>
	
	<div id="resign_section">
	<h3>회원탈퇴</h3>
	<ul id="user_resign">
		<li>
			회원 탈퇴 시 사이트 내의 모든 정보가 삭제되며, 이후 복구가 불가능합니다.
		</li>
		<li>
			추후 서비스 향상을 위해 탈퇴 이유를 선택해주세요
		</li>
		<li>
			<input type="checkbox" name="resign_data" class="chkBox" value="원하는 메뉴가 없어서"/>원하는 메뉴가 없어서
		</li>
		<li>
			<input type="checkbox" name="resign_data" class="chkBox" value="가격이 비싸서"/>가격이 비싸서
		</li>
		<li>
			<input type="checkbox" name="resign_data" class="chkBox" value="홈페이지 이용이 어려워서"/>홈페이지 이용이 어려워서
		</li>
		<li>
			<input type="checkbox" name="resign_data" class="chkBox" value="사이트를 이용하지 않아서"/>사이트를 이용하지 않아서
		</li>
	</ul>
	</div>
	
	</form><!-- form 태그 -->
	
	<div style="text-align: center; ">
		<input type="button" value="탈퇴" class="resignBtn"/>
	</div>
	</div>
	
	<c:import url="../common/jsp/common_footer.jsp"></c:import>
</div>

</body>
</html>