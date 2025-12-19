<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>냠냠코치 - 회원가입</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
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
        input, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
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
            margin-top: 10px;
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
        .section-title {
            font-size: 18px;
            font-weight: bold;
            color: #444;
            margin: 25px 0 15px;
            padding-bottom: 5px;
            border-bottom: 2px solid #f0f0f0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🥗 냠냠코치 회원가입</h1>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/member/register" method="post">
            <div class="section-title">기본 정보</div>

            <div class="form-group">
                <label for="name">이름 *</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="form-group">
                <label for="email">이메일 *</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="password">비밀번호 *</label>
                <input type="password" id="password" name="password" required>
            </div>

            <div class="section-title">신체 정보</div>

            <div class="form-row">
                <div class="form-group">
                    <label for="height">키 (cm)</label>
                    <input type="number" id="height" name="height" step="0.1" min="100" max="250">
                </div>

                <div class="form-group">
                    <label for="weight">체중 (kg)</label>
                    <input type="number" id="weight" name="weight" step="0.1" min="30" max="200">
                </div>
            </div>

            <div class="section-title">건강 정보</div>

            <div class="form-group">
                <label for="healthCondition">건강 상태</label>
                <select id="healthCondition" name="healthCondition">
                    <option value="">선택하세요</option>
                    <option value="정상">정상</option>
                    <option value="당뇨">당뇨</option>
                    <option value="당뇨 전단계">당뇨 전단계</option>
                    <option value="고혈압">고혈압</option>
                    <option value="비만">비만</option>
                    <option value="저체중">저체중</option>
                </select>
            </div>

            <div class="form-group">
                <label for="goal">목표</label>
                <select id="goal" name="goal">
                    <option value="">선택하세요</option>
                    <option value="다이어트">다이어트</option>
                    <option value="근육증가">근육증가</option>
                    <option value="건강유지">건강유지</option>
                    <option value="체중증가">체중증가</option>
                </select>
            </div>

            <button type="submit">회원가입</button>
        </form>

        <div class="link-group">
            <p>이미 회원이신가요? <a href="${pageContext.request.contextPath}/member/login.jsp">로그인</a></p>
        </div>
    </div>
</body>
</html>