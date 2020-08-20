<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="java.sql.SQLException"%>
<%@page import="pizza.dao.MemberDAO"%>
<%@page import="pizza.user.vo.InsertMemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">

<!-- 다음 api 우편번호 검색 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<!-- Google CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- 부트스트랩 -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>

<link rel="stylesheet" href="../common/css/common_header_footer.css">
<link rel="stylesheet" href="css/user_join.css">

<script type="text/javascript">


$(function(){
<%-- ID 팝업창 --%>
	$("#searchId").click(function(){
		idDup();
	});
<%-- ID 팝업창 --%>
<%-- @@@@@@@@@@@@@@@@@@@@@@@@우편번호 검색@@@@@@@@@@@@@@@@@@@@@@@@ --%>
	$("#searchZip").click(function(){
		searchZipcode();
	})//
<%-- @@@@@@@@@@@@@@@@@@@@@@@@우편번호 검색@@@@@@@@@@@@@@@@@@@@@@@@ --%>
	
<%-- 비밀번호, 비밀번호 확인 --%>
	$("#pass2").focusout(function() {
		if($("#pass").val()!=$("#pass2").val()){
			alert("비밀번호를 확인해 주세요.")
			$("#pass").val("");
			$("#pass2").val("");
		}//end if
	});//focusout

<%-- 전체 동의 버튼을 클릭하였을 때 --%>
	$("#agreeAll").click(function(){
		if( $("#agreeAll").is(":checked") ){
			//전체 동의가 체크된 경우.
			$("[name='chk']").prop("checked", true);
			return;
		}//end if
		
		$("[name='chk']").prop("checked", false);
	});//click
	
<%-- 가입 버튼을 클릭했을 때 --%>
	$("#joinBtn").click(function(){
		if($("#id").val().trim() == ""){
			alert("아이디는 필수 입력 사항 입니다.");
			return;
		}//end if
		
		if($("#pass").val().trim() == ""){
			alert("비밀번호는 필수 입력 사항 입니다.");
			return;
		}//end if
		
		if($("#pass2").val().trim() == ""){
			alert("비밀번호는 필수 입력 사항 입니다.");
			return;
		}//end if
		
		if($("#name").val().trim() == ""){
			alert("이름은 필수 입력 사항 입니다.");
			return;
		}//end if
		
		if($("#phone").val().trim() == ""){
			alert("핸드폰 번호는 필수 입력 사항 입니다.");
			return;
		}//end if
		
		if($("#zipcode").val().trim() == ""){
			alert("우편번호는 필수 입력 사항 입니다.");
			return;
		}//end if
		
		if($("#addr1").val().trim() == ""){
			alert("주소는 필수 입력 사항 입니다.");
			return;
		}//end if
		
		if($("#addr2").val().trim() == ""){
			alert("상세 주소는 필수 입력 사항 입니다.");
			return;
		}//end if
		

		
		for(var i=0; i< $("[name='chk']").length; i++){
 			if( $("[name='chk']").eq(i).is(":checked") == false ){
				alert("약관에 동의해주셔야합니다.");
				return;
			}//end if 
		}//end for
		
		
		$("#frm").submit();
		
	});//click

	
	
});//ready

<%-- ID 팝업창 --%>
function idDup(){
	var top=window.screenY+80;
	var left=window.screenX+200;
	window.open("user_dup_id.jsp","id","width=480,height=284,top="+top+",left="+left);	
}
<%-- ID 팝업창 --%>
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
String user_id = request.getParameter("user_id");
String user_pass = request.getParameter("user_pass");
String user_name = request.getParameter("user_name");
String user_phone = request.getParameter("user_phone");
String user_zipcode = request.getParameter("user_zipcode");
String user_addr1 = request.getParameter("user_addr1");
String user_addr2 = request.getParameter("user_addr2");
String user_ip = request.getRemoteAddr();

if( user_id != null ){
InsertMemberVO imVO = new InsertMemberVO(user_id, user_pass, user_name, user_phone,
		user_zipcode, user_addr1, user_addr2, user_ip);
MemberDAO mDAO = MemberDAO.getInstance();
try{
	mDAO.insertMember(imVO);
	%>
		alert("회원가입에 성공하셨습니다.");
		location.href="http://localhost/pizza_prj/pizza_user/main.jsp"
	<%
	//response.sendRedirect("http://localhost/pizza_prj/pizza_user/main.jsp");
} catch ( SQLException se) {
	%>
	alert("죄송합니다. 예기치 못한 오류로 인해 회원가입에 실패하셨습니다.");
	<%
	se.printStackTrace();
}//end catch
}//end if

%>

</script>


</head>
<body>
		<jsp:include page="../common/jsp/common_header.jsp"/>
		<style type="text/css">
			body,html{
				background-color: white;
			}
		</style>  
<%--     <section class="header">
      <div class="header_top"></div>
	  <div class="header_logoImg">
		<img src="../common/images/logo.png">
	  </div>
      <div class="header_nav" id="header_nav">
          <div>
              <a href="main.jsp#pizza_divider">피자</a>
              <a href="main.jsp#side_divider">사이드</a>
          </div>
          <div>
			<c:choose>
				<c:when test="${not empty user_name}">
					<a href="http://localhost/pizza_prj/pizza_user/user_order_list.jsp">
						<strong><c:out value="${user_name}" />님</strong></a>
					<a href="#void" onclick="logout()">로그아웃</a>
				</c:when>
				<c:otherwise>
					<a href="user_join.jsp">회원가입</a>
					<a href="http://localhost/pizza_prj/pizza_user/user_login.jsp">로그인</a>
				</c:otherwise>
			</c:choose>
          </div>
      </div>
  </section> --%>
	
	<div id="container" class="form_container">
	   <!-- <div class="main_title">회원가입</div> -->
	
		<form name="frm" class="join_form" id="frm" method="post" action="user_join.jsp">
			<ul>
				<li>
					<label>아이디</label>
					<span>
						<input type="text" class="user_text" readonly="readonly"  id="id" name="user_id"
						placeholder="중복확인 버튼 클릭"/>
						<input type="button" value="중복확인" class="searchBtn" id="searchId"/>
					</span>
				</li>
				<li>
					<label>비밀번호</label>
					<span>
						<input type="password" id="pass" class="user_text" name="user_pass"/>
					</span>
				</li>
				<li>
					<label>비밀번호 확인</label>
					<span>
						<input type="password" id="pass2" class="user_text"/>
					</span>
				</li>
				<li>
					<label>이름</label>
					<span>
						<input type="text" id="name" class="user_text" name="user_name"/>
					</span>
				</li>
				<li>
					<label>전화번호</label>
					<span>
						<input type="text" id="phone" class="user_text" name="user_phone"/>
					</span>
				</li>
				<li>
					<label>우편번호</label>
					<span>
						<input type="text" class="user_text"readonly="readonly" id="zipcode" name="user_zipcode" 
						placeholder="검색 버튼 클릭"/>
						<input type="button" value="검색" class="searchBtn" id="searchZip"/>
					</span>
				</li>
				<li>
					<label>주소</label>
					<span>
						<input type="text" class="user_text" readonly="readonly" id="addr1" name="user_addr1"/>
					</span>
				</li>
				<li>
					<label>상세주소</label>
					<span>
						<input type="text" class="user_text" id="addr2" name="user_addr2"/>
					</span>
				</li>
			</ul>
		</form>
		
		<div id="agreement">
		<h3>약관</h3><span style="float:right;"><input type="checkbox" class="chkBox" id="agreeAll"/>전체 동의</span>
		
			<div class="content" style="clear: both;">
				<h5>수집하는 개인정보</h5>
				<p>수집하는 개인정보의 항목<p>
				<p>수집하는 목적/방법에 따라 수집하는 개인정보 항목은 다음과 같습니다.<br/>
				-기본 개인정보 정보<br/>
				-로그인 ID, 비밀번호<br/>
				-전화번호, 자택주소</p>
			</div>
			<div class="agree_array"><input type="checkbox" class="chkBox" id="chk1" name="chk"/>동의</div>
			
			<div class="content">
				<h5>약관</h5>
				<p>개인정보 수집 및 이용 목적</p>
				<p>이 사이트는 수집한 개인정보를 다음의 목적을 위해 활용합니다.<br/>
				- 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산 목적<br/>
				-학습진행, 컨텐츠 제공, 구매 및 요금 결제, 물품배송 또는 청구지 등 발송<br/>
				- 회원 관리
				 회원제 서비스 이용에 따른 본인 확인, 개인 식별, 불량 회원의 부정 이용 방지와
				 비인가사용 방지, 가입 의사 확인, 연령 확인, 불만 처리 등 민원 처리, 고지사항 전달
			</div>
			<div class="agree_array"><input type="checkbox" class="chkBox" id="chk2" name="chk"/>동의</div>
		</div><!-- agreement -->
		<div style="text-align: center;">
			<a href="#void"><input type="button"  value="회원가입" id="joinBtn" class="join_btn"></a>
		</div>
	</div><!-- container -->
	
	<c:import url="../common/jsp/common_footer.jsp"></c:import>
</body>
</html>