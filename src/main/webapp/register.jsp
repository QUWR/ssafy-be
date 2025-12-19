<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); response.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - 냠냠코치</title>
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
            padding: 40px 20px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        /* 헤더 */
        .header {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo-link {
            display: inline-flex;
            align-items: center;
            gap: 15px;
            text-decoration: none;
            color: white;
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .logo-link:hover {
            opacity: 0.9;
        }

        .header-subtitle {
            color: rgba(255, 255, 255, 0.9);
            font-size: 16px;
        }

        /* 폼 컨테이너 */
        .form-container {
            background: white;
            border-radius: 30px;
            padding: 50px;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.2);
        }

        .form-header {
            text-align: center;
            margin-bottom: 40px;
        }

        .form-title {
            font-size: 32px;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 10px;
        }

        .form-subtitle {
            color: #718096;
            font-size: 16px;
        }

        /* 진행 표시 */
        .progress-bar {
            display: flex;
            justify-content: space-between;
            margin-bottom: 40px;
            position: relative;
        }

        .progress-bar::before {
            content: '';
            position: absolute;
            top: 15px;
            left: 0;
            right: 0;
            height: 2px;
            background: #e2e8f0;
            z-index: 0;
        }

        .progress-step {
            position: relative;
            z-index: 1;
            text-align: center;
            flex: 1;
        }

        .step-circle {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background: white;
            border: 2px solid #e2e8f0;
            margin: 0 auto 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: bold;
            color: #a0aec0;
            transition: all 0.3s;
        }

        .progress-step.active .step-circle {
            background: linear-gradient(135deg, #006994, #0099cc);
            border-color: #0077be;
            color: white;
        }

        .step-label {
            font-size: 12px;
            color: #718096;
        }

        /* 알림 메시지 */
        .alert {
            padding: 15px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
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

        .alert-error {
            background: linear-gradient(135deg, rgba(245, 101, 101, 0.1), rgba(229, 62, 62, 0.1));
            color: #e53e3e;
            border: 1px solid rgba(229, 62, 62, 0.3);
        }

        /* 섹션 타이틀 */
        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #2d3748;
            margin: 30px 0 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-icon {
            width: 28px;
            height: 28px;
            background: linear-gradient(135deg, rgba(0, 105, 148, 0.1), rgba(0, 153, 204, 0.1));
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
        }

        /* 폼 그룹 */
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

        .required {
            color: #f56565;
        }

        .form-input, .form-select {
            width: 100%;
            padding: 14px 18px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s;
            background: #f7fafc;
        }

        .form-input:focus, .form-select:focus {
            outline: none;
            border-color: #0077be;
            background: white;
            box-shadow: 0 0 0 3px rgba(0, 119, 190, 0.1);
        }

        .form-input::placeholder {
            color: #a0aec0;
        }

        /* 2열 레이아웃 */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        /* 도움말 텍스트 */
        .help-text {
            font-size: 13px;
            color: #718096;
            margin-top: 5px;
        }

        /* 버튼 */
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 40px;
        }

        .btn {
            flex: 1;
            padding: 16px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            text-align: center;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #006994, #0099cc);
            color: white;
            position: relative;
            overflow: hidden;
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(0, 119, 190, 0.3);
        }

        .btn-secondary {
            background: white;
            color: #0077be;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #f7fafc;
            border-color: #0077be;
        }

        /* 체크박스 스타일 */
        .checkbox-group {
            display: flex;
            align-items: start;
            gap: 10px;
            margin: 30px 0;
            padding: 20px;
            background: #f7fafc;
            border-radius: 12px;
        }

        .checkbox-group input[type="checkbox"] {
            width: 20px;
            height: 20px;
            margin-top: 2px;
            cursor: pointer;
        }

        .checkbox-label {
            flex: 1;
            color: #4a5568;
            font-size: 14px;
            line-height: 1.5;
        }

        /* 로그인 링크 */
        .login-link {
            text-align: center;
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid #e2e8f0;
            color: #718096;
            font-size: 15px;
        }

        .login-link a {
            color: #0077be;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .form-container {
                padding: 30px 20px;
            }

            .form-row {
                grid-template-columns: 1fr;
            }

            .button-group {
                flex-direction: column;
            }

            .progress-bar {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 헤더 -->
        <header class="header">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo-link">
                <span>🥗</span>
                <span>냠냠코치</span>
            </a>
            <p class="header-subtitle">건강한 식단 관리의 첫걸음을 시작하세요</p>
        </header>

        <!-- 폼 컨테이너 -->
        <div class="form-container">
            <div class="form-header">
                <h1 class="form-title">회원가입</h1>
                <p class="form-subtitle">간단한 정보 입력으로 맞춤형 영양 관리를 시작해보세요</p>
            </div>

            <!-- 진행 표시 -->
            <div class="progress-bar">
                <div class="progress-step active">
                    <div class="step-circle">1</div>
                    <div class="step-label">기본 정보</div>
                </div>
                <div class="progress-step active">
                    <div class="step-circle">2</div>
                    <div class="step-label">신체 정보</div>
                </div>
                <div class="progress-step active">
                    <div class="step-circle">3</div>
                    <div class="step-label">건강 목표</div>
                </div>
            </div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    ⚠️ <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/member/register" method="post">
                <!-- 기본 정보 섹션 -->
                <div class="section-title">
                    <div class="section-icon">👤</div>
                    <span>기본 정보</span>
                </div>

                <div class="form-group">
                    <label class="form-label" for="name">
                        이름 <span class="required">*</span>
                    </label>
                    <input type="text" id="name" name="name" class="form-input"
                           placeholder="홍길동" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="email">
                        이메일 <span class="required">*</span>
                    </label>
                    <input type="email" id="email" name="email" class="form-input"
                           placeholder="example@email.com" required>
                    <p class="help-text">로그인 시 사용할 이메일 주소를 입력해주세요</p>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">
                        비밀번호 <span class="required">*</span>
                    </label>
                    <input type="password" id="password" name="password" class="form-input"
                           placeholder="8자 이상의 비밀번호" required>
                    <p class="help-text">영문, 숫자, 특수문자를 포함한 8자 이상</p>
                </div>

                <!-- 신체 정보 섹션 -->
                <div class="section-title">
                    <div class="section-icon">📊</div>
                    <span>신체 정보</span>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="height">키 (cm)</label>
                        <input type="number" id="height" name="height" class="form-input"
                               placeholder="170" step="0.1" min="100" max="250">
                        <p class="help-text">선택사항</p>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="weight">체중 (kg)</label>
                        <input type="number" id="weight" name="weight" class="form-input"
                               placeholder="65" step="0.1" min="30" max="200">
                        <p class="help-text">선택사항</p>
                    </div>
                </div>

                <!-- 건강 목표 섹션 -->
                <div class="section-title">
                    <div class="section-icon">🎯</div>
                    <span>건강 목표</span>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="healthCondition">건강 상태</label>
                        <select id="healthCondition" name="healthCondition" class="form-select">
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
                        <label class="form-label" for="goal">목표</label>
                        <select id="goal" name="goal" class="form-select">
                            <option value="">선택하세요</option>
                            <option value="다이어트">다이어트</option>
                            <option value="근육증가">근육증가</option>
                            <option value="건강유지">건강유지</option>
                            <option value="체중증가">체중증가</option>
                        </select>
                    </div>
                </div>

                <!-- 약관 동의 -->
                <div class="checkbox-group">
                    <input type="checkbox" id="terms" required>
                    <label for="terms" class="checkbox-label">
                        서비스 이용약관 및 개인정보처리방침에 동의합니다.
                        개인 건강 정보는 안전하게 보호되며, 맞춤형 영양 추천 서비스 제공을 위해서만 사용됩니다.
                    </label>
                </div>

                <!-- 버튼 -->
                <div class="button-group">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-secondary">이전으로</a>
                    <button type="submit" class="btn btn-primary">가입 완료</button>
                </div>
            </form>

            <!-- 로그인 링크 -->
            <div class="login-link">
                이미 회원이신가요? <a href="${pageContext.request.contextPath}/login.jsp">로그인하기</a>
            </div>
        </div>
    </div>
</body>
</html>