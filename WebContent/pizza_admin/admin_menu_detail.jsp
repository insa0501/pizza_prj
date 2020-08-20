<%@page import="pizza.admin.vo.MenuDetailVO"%>
<%@page import="pizza.dao.MenuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	/**********************수정시 이미지 프리뷰*****************************/
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
	        reader.onload = function (e) { 
	        //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
	            $('#displayImg').attr('src', e.target.result);
	            //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
	            //(아래 코드에서 읽어들인 dataURL형식)
	        }                    
	        reader.readAsDataURL(input.files[0]);
	        //File내용을 읽어 dataURL형식의 문자열로 저장
	    }
	}//readURL()--
	
	window.onload=function(){
		
		//file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
		$("#menuImg").change(function(){
		    readURL(this);
		});
		
	}
	
	/****************************************************************************/

</script>


<%
MenuDAO mDAO = MenuDAO.getInstance();
String menu_name = request.getParameter("param_menu");
MenuDetailVO mdVO = mDAO.selectMenuDetail(menu_name);

pageContext.setAttribute("mdVO", mdVO);
%>

<div id="popupWrap">
	<div id="popupHeader"></div> <!--******* 헤더 빨간줄 ***********  -->
	<div id="popupBody">
	<form action="admin_menu_update.jsp" id="detailFrm">
		<div><h2>메뉴상세정보</h2></div>
<!--******************************* 이미지+이미지선택 버튼 **********************************  -->
			<div class="menuImgGrop">
				<div class="menuImg">
					<img src="../common/images/${mdVO.menu_img}" id="displayImg" style="width: 110px"/><br/>
				</div>
				<input type="file" value="이미지 선택" id="menuImg" name="menuImg" class="btn btn-dark"/>
			</div>
<!--******************************* 이미지+이미지선택 버튼 **********************************  -->
<!--******************************* 메뉴 정보 테이블 **********************************  -->
			<div class="menuData">
				<h4>메뉴 정보</h4>
				<table class="menuDetailTab">
					<tr>
						<th class="colTh">메뉴명</th>
						<td class="colTd1">
							<input type="hidden" id="menuName" name="menuName" value="${mdVO.menu_name}"/>
							${mdVO.menu_name}
						</td>
						<th class="colTh">메뉴 등록일</th>
						<td class="colTd2">${mdVO.menu_input_date}</td>
					</tr>
					<tr>
						<th class="colTh">메뉴분류</th>
						<td class="colTd">
						<select id="menuType" name="menuType" class="colTd1">
							<option value="피자"${"피자".equals(mdVO.menu_type)?" selected='selected'":""}>피자</option>
							<option value="사이드"${"사이드".equals(mdVO.menu_type)?" selected='selected'":""}>사이드</option>
						</select>
							<%-- <input type="text" id="menuType" name="menuType" value="${mdVO.menu_type}" class="colTd1" /> --%>
						</td>
						<th class="colTh">판매가</th>
						<td class="colTd">
							<input type="text" id="menuPrice" name="menuPrice" value="${mdVO.menu_price}" class="colTd2" />원
							
						</td>
					</tr>
				</table>
				<div style="text-align: right;">
					<%-- 활성화/비활성화 테스트 
					<c:out value="<%= mdVO.getMenu_activity() %>"/> --%>
					<input type="checkbox" id="menuActivity" name="menuActivity" ${"N".equals(mdVO.menu_activity)?" checked = 'checked' ":"" }/> 비활성화 여부</div>
			</div>
<!--******************************* 메뉴 정보 테이블 **********************************  -->
<!--******************************* 버튼 그룹 **********************************  -->
		<div id="buttonGrop">
			<input type="button" value="수정" class="btn btn-dark" id="updateMenu"/>
			<input type="button" value="닫기" class="btn btn-dark" id="closeFrm"/>
		</div>
<!--******************************* 버튼 그룹 **********************************  -->
	</form>
	</div>
</div>