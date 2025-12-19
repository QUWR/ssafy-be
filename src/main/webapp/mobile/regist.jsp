<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정보 등록 페이지</title>
</head>
<body>
	<%@ include file="/header.jsp"%>
	<h1>등록 페이지</h1>

	<form action="#" method="">
		<input type="hidden" name="action" value="regist"> <br>
		<fieldset>
			<label> 등록 코드 <input type="text" name="code" maxlength="15"></label>
			<br> <label> 타이틀 <input type="text" name="title"></label>
			<br> <label> 아티스트 <input type="text" name="artist"></label>
			<br> <label> 발매년도 <input type="number"
				name="releaseYear"></label> <br> <label> 장르 <select
				name="genre">
					<option value="발라드">발라드</option>
					<option value="케이팝">케이팝</option>
					<option value="힙합">힙합</option>
			</select> <input type="submit" value="등록"> <br>
			</label> <br> <a href="#">목록으로</a>
		</fieldset>
	</form>
</body>
</html>