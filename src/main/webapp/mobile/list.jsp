<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>목록 조회 페이지</title>
<style type="text/css">
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}
</style>
</head>
<body>
<%@ include file="/header.jsp" %>
	<h1>목록 조회 페이지</h1>

	<a href="#">메인 화면으로</a>
	<a href="#">등록하기</a>
	<table>
		<thead>
			<tr>
				<th>등록 코드</th>
				<th>타이틀</th>
				<th>아티스트</th>
			</tr>
		</thead>
		 <tbody>
         <tr>
            <td><a href="">더미코드</a></td>
            <td>더미제품명</td>
            <td>더미제품 가격</td>
         </tr>
      </tbody>
	</table>
</body>
</html>