<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ssafy.exam.model.service.FoodDataService"%>
<%@ page import="com.ssafy.exam.model.service.FoodSearchService"%>
<%@ page import="com.ssafy.exam.model.dto.Food"%>
<%@ page import="com.ssafy.exam.model.dto.Member"%>
<%@ page import="java.util.List"%>
<%
    Member loginMember = (Member) session.getAttribute("loginMember");
    if (loginMember == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    FoodDataService foodService = FoodDataService.getInstance();
    FoodSearchService searchService = FoodSearchService.getInstance();
    List<Food> foods = foodService.getAllFoods();

    String searchQuery = request.getParameter("search");
    List<Food> displayFoods = foods;

    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        displayFoods = searchService.searchFoods(foods, searchQuery);
    }

    // 페이징 처리
    int itemsPerPage = 20;
    int currentPage = 1;
    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        try {
            currentPage = Integer.parseInt(pageParam);
        } catch (NumberFormatException e) {
            currentPage = 1;
        }
    }

    int totalItems = displayFoods.size();
    int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = Math.min(startIndex + itemsPerPage, totalItems);

    List<Food> currentPageFoods = displayFoods.subList(startIndex, endIndex);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>음식 목록 - 냠냠코치</title>
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

        .header-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 24px;
            font-weight: bold;
            color: #0077be;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
            color: #4a5568;
        }

        .user-info a {
            color: #0077be;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 8px;
            transition: background 0.3s;
        }

        .user-info a:hover {
            background: rgba(0, 119, 190, 0.1);
        }

        /* 메인 컨테이너 */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px 20px;
        }

        /* 페이지 타이틀 */
        .page-header {
            background: white;
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .page-title {
            font-size: 32px;
            font-weight: bold;
            background: linear-gradient(135deg, #006994, #0099cc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
        }

        .page-subtitle {
            color: #718096;
            font-size: 16px;
        }

        /* 통계 카드 */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            text-align: center;
            transition: transform 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-4px);
        }

        .stat-value {
            font-size: 28px;
            font-weight: bold;
            background: linear-gradient(135deg, #006994, #0099cc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .stat-label {
            color: #718096;
            font-size: 14px;
            margin-top: 5px;
        }

        /* 검색 영역 */
        .search-section {
            background: white;
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .search-form {
            display: flex;
            gap: 15px;
        }

        .search-input {
            flex: 1;
            padding: 14px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s;
            background: #f7fafc;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn-search {
            padding: 14px 30px;
            background: linear-gradient(135deg, #006994, #0099cc);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-reset {
            padding: 14px 30px;
            background: white;
            color: #0077be;
            border: 2px solid #667eea;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
        }

        .btn-reset:hover {
            background: rgba(0, 119, 190, 0.1);
        }

        /* 테이블 스타일 */
        .table-container {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .table-header {
            padding: 20px 30px;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
            border-bottom: 2px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .table-title {
            font-size: 20px;
            font-weight: bold;
            color: #2d3748;
        }

        .result-count {
            background: linear-gradient(135deg, #006994, #0099cc);
            color: white;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        thead th {
            background: #f7fafc;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #4a5568;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e2e8f0;
        }

        tbody td {
            padding: 15px;
            border-bottom: 1px solid #f1f5f9;
            color: #2d3748;
            font-size: 14px;
        }

        tbody tr {
            transition: background 0.2s;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        .food-name {
            font-weight: 600;
            color: #2d3748;
        }

        .category-badge {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
            color: #0077be;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
            display: inline-block;
        }

        .nutrient-value {
            font-weight: 500;
        }

        .nutrient-high {
            color: #f56565;
        }

        .nutrient-medium {
            color: #ed8936;
        }

        .nutrient-low {
            color: #48bb78;
        }

        /* 페이지네이션 */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            padding: 30px;
            background: white;
            border-radius: 0 0 20px 20px;
        }

        .page-link {
            padding: 10px 16px;
            border-radius: 8px;
            text-decoration: none;
            color: #4a5568;
            font-weight: 500;
            transition: all 0.3s;
        }

        .page-link:hover {
            background: #f7fafc;
            color: #0077be;
        }

        .page-link.active {
            background: linear-gradient(135deg, #006994, #0099cc);
            color: white;
        }

        .page-link.disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* 검색 결과 없음 */
        .no-results {
            padding: 80px 30px;
            text-align: center;
            background: white;
            border-radius: 20px;
        }

        .no-results-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .no-results-text {
            font-size: 20px;
            color: #4a5568;
            margin-bottom: 10px;
        }

        .no-results-hint {
            color: #718096;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .stats-row {
                grid-template-columns: 1fr 1fr;
            }

            .search-form {
                flex-direction: column;
            }

            .table-container {
                overflow-x: auto;
            }

            table {
                min-width: 800px;
            }
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
            <div class="user-info">
                <span>안녕하세요, <strong><%= loginMember.getName() %></strong>님</span>
                <a href="${pageContext.request.contextPath}/food/search.jsp">음식 검색</a>
                <a href="${pageContext.request.contextPath}/member/profile">내 정보</a>
                <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- 페이지 헤더 -->
        <div class="page-header">
            <h1 class="page-title">음식 영양정보 데이터베이스</h1>
            <p class="page-subtitle">14,000개 이상의 음식 영양 정보를 확인하고 관리하세요</p>
        </div>

        <!-- 통계 카드 -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-value"><%= foods.size() %></div>
                <div class="stat-label">전체 음식</div>
            </div>
            <div class="stat-card">
                <div class="stat-value"><%= displayFoods.size() %></div>
                <div class="stat-label">검색 결과</div>
            </div>
            <div class="stat-card">
                <div class="stat-value"><%= currentPage %> / <%= totalPages %></div>
                <div class="stat-label">현재 페이지</div>
            </div>
            <div class="stat-card">
                <div class="stat-value"><%= itemsPerPage %></div>
                <div class="stat-label">페이지당 항목</div>
            </div>
        </div>

        <!-- 검색 영역 -->
        <div class="search-section">
            <form method="get" action="" class="search-form">
                <input type="text" name="search" placeholder="음식 이름으로 검색하세요"
                       class="search-input" value="<%= searchQuery != null ? searchQuery : "" %>">
                <button type="submit" class="btn-search">🔍 검색</button>
                <% if (searchQuery != null && !searchQuery.trim().isEmpty()) { %>
                    <a href="${pageContext.request.contextPath}/food/list.jsp" class="btn-reset">초기화</a>
                <% } %>
            </form>
        </div>

        <% if (displayFoods.isEmpty()) { %>
            <!-- 검색 결과 없음 -->
            <div class="no-results">
                <div class="no-results-icon">😔</div>
                <div class="no-results-text">검색 결과가 없습니다</div>
                <div class="no-results-hint">다른 검색어로 시도해보세요</div>
            </div>
        <% } else { %>
            <!-- 테이블 -->
            <div class="table-container">
                <div class="table-header">
                    <div class="table-title">음식 목록</div>
                    <div class="result-count"><%= displayFoods.size() %>개 결과</div>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th style="width: 200px;">이름</th>
                            <th style="width: 120px;">카테고리</th>
                            <th>1회 제공량</th>
                            <th>칼로리</th>
                            <th>탄수화물</th>
                            <th>단백질</th>
                            <th>지방</th>
                            <th>당류</th>
                            <th>나트륨</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Food food : currentPageFoods) { %>
                        <tr>
                            <td class="food-name"><%= food.getName() %></td>
                            <td>
                                <span class="category-badge"><%= food.getCategory() %></span>
                            </td>
                            <td><%= food.getServingSize() %></td>
                            <td class="nutrient-value <%= food.getCalories() > 500 ? "nutrient-high" : food.getCalories() > 200 ? "nutrient-medium" : "nutrient-low" %>">
                                <%= food.getCalories() %> kcal
                            </td>
                            <td><%= String.format("%.1f", food.getCarbohydrate()) %>g</td>
                            <td class="nutrient-value"><%= String.format("%.1f", food.getProtein()) %>g</td>
                            <td><%= String.format("%.1f", food.getFat()) %>g</td>
                            <td><%= String.format("%.1f", food.getSugar()) %>g</td>
                            <td class="nutrient-value <%= food.getSodium() > 1000 ? "nutrient-high" : food.getSodium() > 500 ? "nutrient-medium" : "nutrient-low" %>">
                                <%= String.format("%.0f", food.getSodium()) %>mg
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <!-- 페이지네이션 -->
                <% if (totalPages > 1) { %>
                <div class="pagination">
                    <% if (currentPage > 1) { %>
                        <a href="?page=<%= currentPage - 1 %><%= searchQuery != null ? "&search=" + searchQuery : "" %>"
                           class="page-link">← 이전</a>
                    <% } %>

                    <%
                    int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(totalPages, startPage + 4);
                    if (endPage - startPage < 4) {
                        startPage = Math.max(1, endPage - 4);
                    }

                    if (startPage > 1) { %>
                        <a href="?page=1<%= searchQuery != null ? "&search=" + searchQuery : "" %>"
                           class="page-link">1</a>
                        <% if (startPage > 2) { %>
                            <span>...</span>
                        <% } %>
                    <% }

                    for (int i = startPage; i <= endPage; i++) { %>
                        <a href="?page=<%= i %><%= searchQuery != null ? "&search=" + searchQuery : "" %>"
                           class="page-link <%= i == currentPage ? "active" : "" %>"><%= i %></a>
                    <% }

                    if (endPage < totalPages) {
                        if (endPage < totalPages - 1) { %>
                            <span>...</span>
                        <% } %>
                        <a href="?page=<%= totalPages %><%= searchQuery != null ? "&search=" + searchQuery : "" %>"
                           class="page-link"><%= totalPages %></a>
                    <% } %>

                    <% if (currentPage < totalPages) { %>
                        <a href="?page=<%= currentPage + 1 %><%= searchQuery != null ? "&search=" + searchQuery : "" %>"
                           class="page-link">다음 →</a>
                    <% } %>
                </div>
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>