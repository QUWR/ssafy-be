<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); response.setCharacterEncoding("UTF-8"); %>
<%@ page import="com.ssafy.exam.model.dto.Member"%>
<%
    Member loginMember = (Member) session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>냠냠코치 - 맞춤형 영양 관리 서비스</title>
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
    }

    /* 헤더 */
    .header {
        background: rgba(255, 255, 255, 0.98);
        backdrop-filter: blur(10px);
        box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        position: sticky;
        top: 0;
        z-index: 100;
    }

    .nav-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .logo {
        display: flex;
        align-items: center;
        gap: 12px;
        font-size: 28px;
        font-weight: bold;
        background: linear-gradient(135deg, #006994, #0099cc);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    .nav-links {
        display: flex;
        align-items: center;
        gap: 25px;
    }

    .nav-links a {
        color: #4a5568;
        text-decoration: none;
        font-weight: 500;
        padding: 8px 16px;
        border-radius: 8px;
        transition: all 0.3s;
    }

    .nav-links a:hover {
        background: rgba(0, 119, 190, 0.1);
        color: #0077be;
    }

    .btn-login {
        background: linear-gradient(135deg, #006994, #0099cc);
        color: white !important;
        padding: 10px 24px !important;
        border-radius: 25px !important;
    }

    .btn-login:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0, 119, 190, 0.3);
    }

    .user-name {
        color: #2d3748;
        font-weight: 600;
    }

    /* 히어로 섹션 */
    .hero {
        max-width: 1200px;
        margin: 60px auto;
        padding: 0 20px;
        text-align: center;
    }

    .hero-content {
        background: white;
        padding: 80px 40px;
        border-radius: 30px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
        position: relative;
        overflow: hidden;
    }

    .hero-content::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 200%;
        height: 200%;
        background: radial-gradient(circle, rgba(0, 119, 190, 0.05) 0%, transparent 70%);
        animation: rotate 30s linear infinite;
    }

    @keyframes rotate {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }

    .hero h1 {
        font-size: 48px;
        font-weight: 800;
        background: linear-gradient(135deg, #006994, #0099cc);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 20px;
        position: relative;
    }

    .hero-subtitle {
        font-size: 24px;
        color: #4a5568;
        margin-bottom: 15px;
        font-weight: 500;
    }

    .hero-desc {
        font-size: 18px;
        color: #718096;
        margin-bottom: 40px;
        line-height: 1.6;
    }

    .cta-buttons {
        display: flex;
        gap: 20px;
        justify-content: center;
        position: relative;
    }

    .btn-primary {
        background: linear-gradient(135deg, #006994, #0099cc);
        color: white;
        padding: 16px 40px;
        font-size: 18px;
        font-weight: 600;
        border: none;
        border-radius: 30px;
        text-decoration: none;
        display: inline-block;
        transition: all 0.3s;
        box-shadow: 0 4px 15px rgba(0, 119, 190, 0.3);
    }

    .btn-primary:hover {
        transform: translateY(-3px);
        box-shadow: 0 8px 25px rgba(0, 119, 190, 0.4);
    }

    .btn-secondary {
        background: white;
        color: #0077be;
        padding: 16px 40px;
        font-size: 18px;
        font-weight: 600;
        border: 2px solid #0077be;
        border-radius: 30px;
        text-decoration: none;
        display: inline-block;
        transition: all 0.3s;
    }

    .btn-secondary:hover {
        background: rgba(0, 119, 190, 0.1);
        transform: translateY(-3px);
    }

    /* 통계 섹션 */
    .stats {
        max-width: 1200px;
        margin: 60px auto;
        padding: 0 20px;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 25px;
    }

    .stat-card {
        background: white;
        padding: 30px;
        border-radius: 20px;
        text-align: center;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s;
    }

    .stat-card:hover {
        transform: translateY(-5px);
    }

    .stat-number {
        font-size: 42px;
        font-weight: bold;
        background: linear-gradient(135deg, #006994, #0099cc);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 10px;
    }

    .stat-label {
        color: #718096;
        font-size: 16px;
        font-weight: 500;
    }

    /* 기능 카드 */
    .features {
        max-width: 1200px;
        margin: 60px auto;
        padding: 0 20px;
    }

    .section-title {
        text-align: center;
        font-size: 36px;
        font-weight: bold;
        color: white;
        margin-bottom: 50px;
    }

    .feature-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
        gap: 30px;
    }

    .feature-card {
        background: white;
        border-radius: 20px;
        padding: 40px 30px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        transition: all 0.3s;
        position: relative;
        overflow: hidden;
    }

    .feature-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 4px;
        background: linear-gradient(90deg, #006994, #0099cc);
    }

    .feature-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
    }

    .feature-icon {
        width: 70px;
        height: 70px;
        background: linear-gradient(135deg, rgba(0, 105, 148, 0.1), rgba(0, 153, 204, 0.1));
        border-radius: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 32px;
        margin-bottom: 25px;
    }

    .feature-title {
        font-size: 22px;
        font-weight: bold;
        color: #2d3748;
        margin-bottom: 15px;
    }

    .feature-desc {
        color: #718096;
        line-height: 1.6;
        font-size: 16px;
    }

    /* 서비스 특징 */
    .service-features {
        background: white;
        margin-top: 80px;
        padding: 80px 0;
    }

    .service-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }

    .service-title {
        text-align: center;
        font-size: 36px;
        font-weight: bold;
        color: #2d3748;
        margin-bottom: 20px;
    }

    .service-subtitle {
        text-align: center;
        color: #718096;
        font-size: 18px;
        margin-bottom: 60px;
    }

    .service-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 40px;
    }

    .service-item {
        text-align: center;
    }

    .service-icon {
        width: 80px;
        height: 80px;
        margin: 0 auto 20px;
        background: linear-gradient(135deg, #006994, #0099cc);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 36px;
    }

    .service-name {
        font-size: 20px;
        font-weight: 600;
        color: #2d3748;
        margin-bottom: 10px;
    }

    .service-info {
        color: #718096;
        font-size: 15px;
        line-height: 1.5;
    }

    /* 푸터 */
    .footer {
        margin-top: 100px;
        padding: 40px 20px;
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
    }

    .footer-content {
        max-width: 1200px;
        margin: 0 auto;
        text-align: center;
        color: white;
    }

    .footer-logo {
        font-size: 24px;
        font-weight: bold;
        margin-bottom: 20px;
    }

    .footer-links {
        display: flex;
        gap: 30px;
        justify-content: center;
        margin-bottom: 20px;
    }

    .footer-links a {
        color: white;
        text-decoration: none;
        opacity: 0.8;
        transition: opacity 0.3s;
    }

    .footer-links a:hover {
        opacity: 1;
    }

    .copyright {
        opacity: 0.7;
        font-size: 14px;
    }

    @media (max-width: 768px) {
        .hero h1 {
            font-size: 36px;
        }

        .hero-subtitle {
            font-size: 20px;
        }

        .cta-buttons {
            flex-direction: column;
            align-items: center;
        }

        .feature-grid {
            grid-template-columns: 1fr;
        }

        .nav-links {
            flex-wrap: wrap;
        }
    }
</style>
</head>
<body>
    <!-- 헤더 -->
    <header class="header">
        <nav class="nav-container">
            <div class="logo">
                <span>🥗</span>
                <span>냠냠코치</span>
            </div>
            <div class="nav-links">
                <% if (loginMember == null) { %>
                    <a href="${pageContext.request.contextPath}/register.jsp">회원가입</a>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn-login">로그인</a>
                <% } else { %>
                    <span class="user-name">안녕하세요, <%= loginMember.getName() %>님</span>
                    <a href="${pageContext.request.contextPath}/food/search.jsp">음식 검색</a>
                    <a href="${pageContext.request.contextPath}/food/list.jsp">음식 목록</a>
                    <a href="${pageContext.request.contextPath}/member/profile">내 정보</a>
                    <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
                <% } %>
            </div>
        </nav>
    </header>

    <!-- 히어로 섹션 -->
    <section class="hero">
        <div class="hero-content">
            <h1>맞춤형 영양 관리의 시작</h1>
            <div class="hero-subtitle">당신의 건강한 식단을 위한 스마트 코치</div>
            <p class="hero-desc">
                14,000개 이상의 음식 데이터베이스와 개인 맞춤 추천 시스템으로<br>
                건강한 식습관을 만들어가세요
            </p>
            <div class="cta-buttons">
                <% if (loginMember == null) { %>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn-primary">무료로 시작하기</a>
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn-secondary">로그인</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/food/search.jsp" class="btn-primary">음식 검색하기</a>
                    <a href="${pageContext.request.contextPath}/member/profile" class="btn-secondary">내 정보 관리</a>
                <% } %>
            </div>
        </div>
    </section>

    <!-- 통계 섹션 -->
    <section class="stats">
        <div class="stat-card">
            <div class="stat-number">14,584</div>
            <div class="stat-label">음식 데이터베이스</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">10+</div>
            <div class="stat-label">영양소 분석 항목</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">실시간</div>
            <div class="stat-label">빠른 검색 속도</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">맞춤형</div>
            <div class="stat-label">개인 추천 시스템</div>
        </div>
    </section>

    <!-- 기능 소개 -->
    <section class="features">
        <h2 class="section-title">주요 기능</h2>
        <div class="feature-grid">
            <div class="feature-card">
                <div class="feature-icon">🔍</div>
                <h3 class="feature-title">스마트 음식 검색</h3>
                <p class="feature-desc">
                    음식명, 카테고리, 영양소별로 빠르고 정확한 검색이 가능합니다.
                    실시간 자동완성 기능으로 편리하게 찾아보세요.
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h3 class="feature-title">상세 영양 분석</h3>
                <p class="feature-desc">
                    칼로리, 탄수화물, 단백질, 지방 등 10가지 이상의 영양소를
                    한눈에 확인하고 관리할 수 있습니다.
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">❤️</div>
                <h3 class="feature-title">개인 맞춤 추천</h3>
                <p class="feature-desc">
                    건강 상태와 목표 체중을 고려한 맞춤형 식단 추천으로
                    효과적인 영양 관리가 가능합니다.
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📱</div>
                <h3 class="feature-title">편리한 접근성</h3>
                <p class="feature-desc">
                    PC, 태블릿, 모바일 등 모든 기기에서 편리하게 사용할 수 있으며,
                    언제 어디서나 식단을 관리할 수 있습니다.
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🎯</div>
                <h3 class="feature-title">목표 설정</h3>
                <p class="feature-desc">
                    다이어트, 근육 증가, 건강 유지 등 개인의 목표에 맞는
                    식단 계획을 수립할 수 있습니다.
                </p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">🔒</div>
                <h3 class="feature-title">안전한 데이터 관리</h3>
                <p class="feature-desc">
                    개인 정보와 건강 데이터는 안전하게 보호되며,
                    언제든지 수정하거나 삭제할 수 있습니다.
                </p>
            </div>
        </div>
    </section>

    <!-- 서비스 특징 -->
    <section class="service-features">
        <div class="service-container">
            <h2 class="service-title">왜 냠냠코치인가요?</h2>
            <p class="service-subtitle">전문적인 영양 관리를 쉽고 편리하게</p>
            <div class="service-grid">
                <div class="service-item">
                    <div class="service-icon">✅</div>
                    <div class="service-name">정확한 데이터</div>
                    <div class="service-info">
                        식품의약품안전처 인증<br>
                        영양 데이터베이스
                    </div>
                </div>
                <div class="service-item">
                    <div class="service-icon">⚡</div>
                    <div class="service-name">빠른 검색</div>
                    <div class="service-info">
                        실시간 검색과<br>
                        자동완성 기능
                    </div>
                </div>
                <div class="service-item">
                    <div class="service-icon">🎨</div>
                    <div class="service-name">직관적인 디자인</div>
                    <div class="service-info">
                        누구나 쉽게 사용할 수 있는<br>
                        깔끔한 인터페이스
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 푸터 -->
    <footer class="footer">
        <div class="footer-content">
            <div class="footer-logo">🥗 냠냠코치</div>
            <div class="footer-links">
                <a href="#">서비스 소개</a>
                <a href="#">이용약관</a>
                <a href="#">개인정보처리방침</a>
                <a href="#">고객지원</a>
            </div>
            <div class="copyright">
                © 2025 냠냠코치. All rights reserved.
            </div>
        </div>
    </footer>
</body>
</html>