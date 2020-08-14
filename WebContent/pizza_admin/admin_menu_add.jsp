<%@page import="pizza.dao.MenuDAO"%>
<%@page import="pizza.admin.vo.AddMenuVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
    request.setCharacterEncoding("UTF-8");
 %>
 <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
 <script type="text/javascript">
 
 /******************메뉴 추가 버튼****************/
	
	$(function(){
		
		 function readURL(input) {
             if (input.files && input.files[0]) {
                 var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
                 reader.onload = function (e) { 
                 //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
                     $('#preview').attr('src', e.target.result);
                     //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
                     //(아래 코드에서 읽어들인 dataURL형식)
                 }                    
                 reader.readAsDataURL(input.files[0]);
                 //File내용을 읽어 dataURL형식의 문자열로 저장
             }
         }//readURL()--
 
         //file 양식으로 이미지를 선택(값이 변경) 되었을때 처리하는 코드
         $("#upfile").change(function(){
             readURL(this);
         });
		
     		
		$("#addMenuBtn").click(function() {
			
			if($("#upfile").val() == ""){
			
				alert("업로드 파일을 선택해주세요.");
				return;
			}//end if
			
			
			if($("#menu_name").val() == ""){
				alert("메뉴명을 입력하세요.");
				return;
			}
			
			if($("#menu_type").val() == ""){
				alert("메뉴타입을 입력하세요.");
				return;
			}
			
			if($("#menu_price").val() == ""){
				alert("메뉴가격을 입력하세요.");
				return;
			}
			
		$("#AdminMenuAddFrm").submit();
			
		});
	})//ready

	
 </script>
</head>
<body> 
<div id="popupWrap">
	<div id="popupHeader"></div> <!--******* 헤더 빨간줄 ***********  -->
	<div id="popupBody">
	<form action="admin_menu_add_data.jsp" method="post" name="AdminMenuAddFrm" id="AdminMenuAddFrm">
		<div><h2>메뉴추가</h2></div>
<!--******************************* 이미지+이미지선택 버튼 **********************************  -->
		  	<div class="menuImgGrop">
				<div class="menuImg">
					<img src="../images/logo.png" id="preview"style="width: 110px"/><br/>
				</div>
				<input type="file" id="upfile" name="upfile"  value="이미지 선택" class="btn btn-dark"/>
			</div> 
<!--******************************* 이미지+이미지선택 버튼 **********************************  -->
<!--******************************* 메뉴 정보 테이블 **********************************  -->
			<div class="menuData">
				<h4>메뉴 정보</h4>
				<table class="menuDetailTab">
					<tr>
						<th class="colTh">메뉴명</th>
						<td colspan="3">
							<input type="text"   name="menu_name" id="menu_name" style="width: 390px; height: 35px"/>
						</td>
					</tr>
					<tr>
						<th class="colTh">메뉴분류</th>
						<td class="colTd">
							<input type="text"  name="menu_type" id="menu_type" class="colTd1" />
						</td>
						<th class="colTh">판매가</th>
						<td class="colTd">
							<input type="text" name="menu_price" id="menu_price" class="colTd2" />
						</td>
					</tr>
				</table>
				<div style="text-align: right;"><input type="checkbox" name="menu_activity" id="menu_activity"/> 비활성화 여부</div>
			</div>
<!--******************************* 메뉴 정보 테이블 **********************************  -->
<!--******************************* 버튼 그룹 **********************************  -->
		<div id="buttonGrop">
			<input type="button" value="추가"  class="btn btn-dark" id="addMenuBtn"/>
			<input type="button" value="닫기" class="btn btn-dark" id="closeFrm"/>
		</div>
	
<!--******************************* 버튼 그룹 **********************************  -->
	  </form>
	  
	</div>
	 
</div>
</body>
</html>
