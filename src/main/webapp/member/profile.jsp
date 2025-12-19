<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ssafy.exam.model.dto.Member"%>
<%
    Member loginMember = (Member) session.getAttribute("loginMember");
    if (loginMember == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보 - 냠냠코치</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
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

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .nav-links a {
            color: #667eea;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 8px;
            transition: background 0.3s;
        }

        .nav-links a:hover {
            background: rgba(102, 126, 234, 0.1);
        }

        /* 컨테이너 */
        .container {
            max-width: 900px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* 프로필 카드 */
        .profile-card {
            background: white;
            border-radius: 30px;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.2);
        }

        .profile-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 40px;
            color: white;
            text-align: center;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            background: white;
            border-radius: 50%;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            color: #667eea;
        }

        .profile-name {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .profile-email {
            font-size: 16px;
            opacity: 0.9;
        }

        .profile-stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            padding: 30px;
            background: #f7fafc;
            border-bottom: 1px solid #e2e8f0;
        }

        .stat-item {
            text-align: center;
        }

        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #2d3748;
        }

        .stat-label {
            color: #718096;
            font-size: 14px;
            margin-top: 5px;
        }

        /* 알림 메시지 */
        .alert {
            margin: 20px;
            padding: 15px 20px;
            border-radius: 12px;
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
            background: linear-gradient(135deg, rgba(72, 187, 120, 0.1), rgba(56, 161, 105, 0.1));
            color: #22543d;
            border: 1px solid rgba(72, 187, 120, 0.3);
        }

        .alert-error {
            background: linear-gradient(135deg, rgba(245, 101, 101, 0.1), rgba(229, 62, 62, 0.1));
            color: #e53e3e;
            border: 1px solid rgba(229, 62, 62, 0.3);
        }

        /* 프로필 폼 */
        .profile-form {
            padding: 40px;
        }

        .form-title {
            font-size: 24px;
            font-weight: bold;
            color: #2d3748;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
        }

        .form-group {
            margin-bottom: 0;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            color: #4a5568;
            font-weight: 500;
            font-size: 14px;
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
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .form-input[readonly] {
            background: #edf2f7;
            cursor: not-allowed;
        }

        /* BMI 표시 */
        .bmi-display {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            padding: 20px;
            border-radius: 12px;
            margin: 20px 0;
            text-align: center;
        }

        .bmi-value {
            font-size: 32px;
            font-weight: bold;
            color: #667eea;
        }

        .bmi-status {
            font-size: 16px;
            color: #4a5568;
            margin-top: 5px;
        }

        /* 버튼 그룹 */
        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
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
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: white;
            color: #667eea;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #f7fafc;
            border-color: #667eea;
        }

        .btn-danger {
            background: white;
            color: #e53e3e;
            border: 2px solid #fed7d7;
        }

        .btn-danger:hover {
            background: #fff5f5;
            border-color: #e53e3e;
        }

        /* 위험 구역 */
        .danger-zone {
            margin-top: 40px;
            padding-top: 40px;
            border-top: 2px solid #e2e8f0;
        }

        .danger-title {
            color: #e53e3e;
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .danger-text {
            color: #718096;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- 헤더 -->
    <div class="header">
        <div class="header-content">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                <span>🥗</span>
                <span>냠냠코치</span>
            </a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/food/search.jsp">음식 검색</a>
                <a href="${pageContext.request.contextPath}/food/list.jsp">음식 목록</a>
                <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="profile-card">
            <!-- 프로필 헤더 -->
            <div class="profile-header">
                <div class="profile-avatar">👤</div>
                <h1 class="profile-name"><%= loginMember.getName() %></h1>
                <p class="profile-email"><%= loginMember.getEmail() %></p>
            </div>

            <!-- 통계 -->
            <div class="profile-stats">
                <div class="stat-item">
                    <div class="stat-value">
                        <%= loginMember.getHeight() != 0 ? String.format("%.1f", loginMember.getHeight()) + " cm" : "-" %>
                    </div>
                    <div class="stat-label">키</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">
                        <%= loginMember.getWeight() != 0 ? String.format("%.1f", loginMember.getWeight()) + " kg" : "-" %>
                    </div>
                    <div class="stat-label">체중</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">
                        <%
                            double bmi = 0;
                            if (loginMember.getHeight() > 0 && loginMember.getWeight() > 0) {
                                bmi = loginMember.getWeight() / Math.pow(loginMember.getHeight() / 100, 2);
                                out.print(String.format("%.1f", bmi));
                            } else {
                                out.print("-");
                            }
                        %>
                    </div>
                    <div class="stat-label">BMI</div>
                </div>
            </div>

            <!-- 알림 메시지 -->
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert alert-success">
                    ✅ <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-error">
                    ⚠️ <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <!-- 프로필 수정 폼 -->
            <div class="profile-form">
                <h2 class="form-title">
                    <span>📝</span>
                    <span>내 정보 수정</span>
                </h2>

                <form action="${pageContext.request.contextPath}/member/update" method="post">
                    <div class="form-grid">
                        <div class="form-group">
                            <label class="form-label">이름</label>
                            <input type="text" name="name" value="<%= loginMember.getName() %>"
                                   class="form-input" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label">이메일</label>
                            <input type="email" value="<%= loginMember.getEmail() %>"
                                   class="form-input" readonly>
                        </div>

                        <div class="form-group">
                            <label class="form-label">새 비밀번호</label>
                            <input type="password" name="password" class="form-input"
                                   placeholder="변경시에만 입력">
                        </div>

                        <div class="form-group">
                            <label class="form-label">비밀번호 확인</label>
                            <input type="password" class="form-input"
                                   placeholder="비밀번호 재입력">
                        </div>

                        <div class="form-group">
                            <label class="form-label">키 (cm)</label>
                            <input type="number" name="height" value="<%= loginMember.getHeight() %>"
                                   class="form-input" step="0.1" min="100" max="250">
                        </div>

                        <div class="form-group">
                            <label class="form-label">체중 (kg)</label>
                            <input type="number" name="weight" value="<%= loginMember.getWeight() %>"
                                   class="form-input" step="0.1" min="30" max="200">
                        </div>

                        <div class="form-group">
                            <label class="form-label">건강 상태</label>
                            <select name="healthCondition" class="form-select">
                                <option value="">선택하세요</option>
                                <option value="정상" <%= "정상".equals(loginMember.getHealthCondition()) ? "selected" : "" %>>정상</option>
                                <option value="당뇨" <%= "당뇨".equals(loginMember.getHealthCondition()) ? "selected" : "" %>>당뇨</option>
                                <option value="당뇨 전단계" <%= "당뇨 전단계".equals(loginMember.getHealthCondition()) ? "selected" : "" %>>당뇨 전단계</option>
                                <option value="고혈압" <%= "고혈압".equals(loginMember.getHealthCondition()) ? "selected" : "" %>>고혈압</option>
                                <option value="비만" <%= "비만".equals(loginMember.getHealthCondition()) ? "selected" : "" %>>비만</option>
                                <option value="저체중" <%= "저체중".equals(loginMember.getHealthCondition()) ? "selected" : "" %>>저체중</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label class="form-label">목표</label>
                            <select name="goal" class="form-select">
                                <option value="">선택하세요</option>
                                <option value="다이어트" <%= "다이어트".equals(loginMember.getGoal()) ? "selected" : "" %>>다이어트</option>
                                <option value="근육증가" <%= "근육증가".equals(loginMember.getGoal()) ? "selected" : "" %>>근육증가</option>
                                <option value="건강유지" <%= "건강유지".equals(loginMember.getGoal()) ? "selected" : "" %>>건강유지</option>
                                <option value="체중증가" <%= "체중증가".equals(loginMember.getGoal()) ? "selected" : "" %>>체중증가</option>
                            </select>
                        </div>
                    </div>

                    <% if (bmi > 0) { %>
                    <div class="bmi-display">
                        <div class="bmi-value">BMI <%= String.format("%.1f", bmi) %></div>
                        <div class="bmi-status">
                            <%
                                if (bmi < 18.5) {
                                    out.print("저체중");
                                } else if (bmi < 23) {
                                    out.print("정상");
                                } else if (bmi < 25) {
                                    out.print("과체중");
                                } else {
                                    out.print("비만");
                                }
                            %>
                        </div>
                    </div>
                    <% } %>

                    <div class="button-group">
                        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-secondary">취소</a>
                        <button type="submit" class="btn btn-primary">정보 수정</button>
                    </div>
                </form>

                <!-- 계정 삭제 -->
                <div class="danger-zone">
                    <h3 class="danger-title">⚠️ 위험 구역</h3>
                    <p class="danger-text">계정을 삭제하면 모든 데이터가 영구적으로 삭제됩니다.</p>
                    <form action="${pageContext.request.contextPath}/member/delete" method="post"
                          onsubmit="return confirm('정말로 계정을 삭제하시겠습니까?');">
                        <button type="submit" class="btn btn-danger">계정 삭제</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>