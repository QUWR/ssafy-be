<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>냠냠코치 - 로그인</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 400px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
            font-weight: 500;
        }
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
        }
        button:hover {
            background: #5a67d8;
        }
        .link-group {
            text-align: center;
            margin-top: 20px;
        }
        .link-group a {
            color: #667eea;
            text-decoration: none;
        }
        .error {
            color: #e53e3e;
            margin-bottom: 15px;
            padding: 10px;
            background: #fed7d7;
            border-radius: 5px;
            text-align: center;
        }
        .success {
            color: #2f855a;
            margin-bottom: 15px;
            padding: 10px;
            background: #c6f6d5;
            border-radius: 5px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🥗 냠냠코치 로그인</h1>

        <% if (request.getParameter("registered") != null) { %>
            <div class="success">회원가입이 완료되었습니다. 로그인해주세요.</div>
        <% } %>

        <% if (request.getParameter("deleted") != null) { %>
            <div class="success">계정이 삭제되었습니다.</div>
        <% } %>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/member/login" method="post">
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit">로그인</button>
        </form>

        <div class="link-group">
            <p>아직 회원이 아니신가요? <a href="${pageContext.request.contextPath}/member/register.jsp">회원가입</a></p>
        </div>
    </div>
</body>
</html>