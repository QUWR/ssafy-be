<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); response.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - 냠냠코치</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(135deg, #0077be 0%, #00a8cc 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            display: flex;
            max-width: 1000px;
            width: 100%;
            background: white;
            border-radius: 30px;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.2);
        }

        /* 왼쪽 영역 */
        .left-panel {
            flex: 1;
            background: linear-gradient(135deg, #006994, #0099cc);
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .left-panel::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
        }

        @keyframes rotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .brand {
            position: relative;
            z-index: 1;
        }

        .brand-logo {
            font-size: 60px;
            margin-bottom: 20px;
        }

        .brand-title {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .brand-subtitle {
            font-size: 18px;
            opacity: 0.9;
            line-height: 1.6;
        }

        .features {
            margin-top: 40px;
            position: relative;
            z-index: 1;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .feature-icon {
            width: 24px;
            height: 24px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 15px;
        }

        /* 오른쪽 로그인 폼 영역 */
        .right-panel {
            flex: 1;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-header {
            margin-bottom: 40px;
        }

        .login-title {
            font-size: 32px;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .login-subtitle {
            color: #718096;
            font-size: 16px;
        }

        /* 알림 메시지 */
        .alert {
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            font-size: 14px;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background: linear-gradient(135deg, #006994, #0099cc);
            color: white;
        }

        .alert-error {
            background: linear-gradient(135deg, #0077be, #00a8cc);
            color: white;
        }

        /* 폼 요소 */
        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            color: #4a5568;
            font-weight: 500;
            font-size: 14px;
        }

        .form-input {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s;
            background: #f7fafc;
        }

        .form-input:focus {
            outline: none;
            border-color: #0077be;
            background: white;
            box-shadow: 0 0 0 3px rgba(0, 119, 190, 0.1);
        }

        .form-input::placeholder {
            color: #a0aec0;
        }

        /* 로그인 버튼 */
        .btn-login {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #006994, #0099cc);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
            position: relative;
            overflow: hidden;
        }

        .btn-login::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-login:hover::before {
            left: 100%;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0, 119, 190, 0.3);
        }

        /* 구분선 */
        .divider {
            display: flex;
            align-items: center;
            margin: 30px 0;
        }

        .divider-line {
            flex: 1;
            height: 1px;
            background: #e2e8f0;
        }

        .divider-text {
            padding: 0 20px;
            color: #a0aec0;
            font-size: 14px;
        }

        /* 링크 */
        .form-links {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
        }

        .form-link {
            color: #0077be;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.3s;
        }

        .form-link:hover {
            color: #00a8cc;
            text-decoration: underline;
        }

        /* 회원가입 버튼 */
        .btn-register {
            width: 100%;
            padding: 16px;
            background: white;
            color: #0077be;
            border: 2px solid #0077be;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-register:hover {
            background: rgba(0, 119, 190, 0.1);
            transform: translateY(-2px);
        }

        /* 홈 링크 */
        .home-link {
            position: absolute;
            top: 30px;
            left: 30px;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            opacity: 0.9;
            transition: opacity 0.3s;
            z-index: 2;
        }

        .home-link:hover {
            opacity: 1;
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }

            .left-panel {
                padding: 40px 30px;
            }

            .right-panel {
                padding: 40px 30px;
            }

            .brand-title {
                font-size: 28px;
            }

            .features {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <!-- 왼쪽 패널 -->
        <div class="left-panel">
            <a href="${pageContext.request.contextPath}/index.jsp" class="home-link">
                ← 홈으로 돌아가기
            </a>
            <div class="brand">
                <div class="brand-logo">🥗</div>
                <h1 class="brand-title">냠냠코치</h1>
                <p class="brand-subtitle">
                    14,000개 이상의 음식 데이터베이스와<br>
                    개인 맞춤 영양 관리 서비스
                </p>
            </div>
            <div class="features">
                <div class="feature-item">
                    <div class="feature-icon">✓</div>
                    <span>실시간 영양소 분석</span>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">✓</div>
                    <span>맞춤형 식단 추천</span>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">✓</div>
                    <span>건강 목표 관리</span>
                </div>
            </div>
        </div>

        <!-- 오른쪽 로그인 패널 -->
        <div class="right-panel">
            <div class="login-header">
                <h2 class="login-title">다시 오신 것을 환영합니다</h2>
                <p class="login-subtitle">로그인하여 영양 관리를 시작하세요</p>
            </div>

            <% if (request.getParameter("registered") != null) { %>
                <div class="alert alert-success">
                    🎉 회원가입이 완료되었습니다! 로그인해주세요.
                </div>
            <% } %>

            <% if (request.getParameter("deleted") != null) { %>
                <div class="alert alert-success">
                    계정이 안전하게 삭제되었습니다.
                </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    ⚠️ <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/member/login" method="post">
                <div class="form-group">
                    <label class="form-label" for="email">이메일</label>
                    <input type="email" id="email" name="email" class="form-input"
                           placeholder="example@email.com" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">비밀번호</label>
                    <input type="password" id="password" name="password" class="form-input"
                           placeholder="비밀번호를 입력하세요" required>
                </div>

                <div class="form-links">
                    <label style="display: flex; align-items: center; gap: 8px; cursor: pointer;">
                        <input type="checkbox" name="remember" style="width: 16px; height: 16px;">
                        <span style="color: #718096; font-size: 14px;">로그인 상태 유지</span>
                    </label>
                    <a href="#" class="form-link">비밀번호 찾기</a>
                </div>

                <button type="submit" class="btn-login">로그인</button>
            </form>

            <div class="divider">
                <div class="divider-line"></div>
                <span class="divider-text">또는</span>
                <div class="divider-line"></div>
            </div>

            <a href="${pageContext.request.contextPath}/register.jsp" class="btn-register">
                무료 회원가입
            </a>
        </div>
    </div>
</body>
</html>