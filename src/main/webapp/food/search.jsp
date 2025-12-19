<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); response.setCharacterEncoding("UTF-8"); %>
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
    <title>음식 검색 - 냠냠코치</title>
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
            padding: 20px 0;
        }

        /* 헤더 */
        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
            margin-bottom: 30px;
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

        /* 컨테이너 */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* 검색 섹션 */
        .search-section {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .search-title {
            font-size: 32px;
            font-weight: bold;
            background: linear-gradient(135deg, #006994, #0099cc);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 10px;
            text-align: center;
        }

        .search-subtitle {
            color: #718096;
            text-align: center;
            margin-bottom: 30px;
        }

        .search-box {
            position: relative;
            max-width: 600px;
            margin: 0 auto;
        }

        .search-input {
            width: 100%;
            padding: 18px 60px 18px 24px;
            font-size: 16px;
            border: 2px solid #e2e8f0;
            border-radius: 16px;
            outline: none;
            transition: all 0.3s;
            background: #f7fafc;
        }

        .search-input:focus {
            border-color: #0077be;
            background: white;
            box-shadow: 0 0 0 3px rgba(0, 119, 190, 0.1);
        }

        .search-icon {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #0077be;
            font-size: 20px;
            pointer-events: none;
        }

        /* 자동완성 */
        .autocomplete-items {
            position: absolute;
            width: 100%;
            background: white;
            border: 1px solid #e2e8f0;
            border-top: none;
            border-radius: 0 0 16px 16px;
            max-height: 300px;
            overflow-y: auto;
            z-index: 99;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .autocomplete-item {
            padding: 15px 20px;
            cursor: pointer;
            transition: background 0.3s;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .autocomplete-item:hover {
            background: #f7fafc;
        }

        .autocomplete-item strong {
            color: #2d3748;
            font-weight: 600;
        }

        .autocomplete-category {
            background: #edf2f7;
            color: #4a5568;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 12px;
        }

        /* 통계 카드 */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
        }

        .stat-icon {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 28px;
            font-weight: bold;
            color: #2d3748;
        }

        .stat-label {
            color: #718096;
            font-size: 14px;
            margin-top: 5px;
        }

        /* 결과 섹션 */
        .results-section {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            min-height: 400px;
        }

        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e2e8f0;
        }

        .results-title {
            font-size: 24px;
            font-weight: bold;
            color: #2d3748;
        }

        .results-count {
            background: linear-gradient(135deg, #006994, #0099cc);
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        /* 음식 카드 */
        .food-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        .food-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s;
            border: 2px solid transparent;
        }

        .food-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            border-color: #0077be;
        }

        .food-header {
            background: linear-gradient(135deg, #006994, #0099cc);
            color: white;
            padding: 15px;
        }

        .food-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .food-category {
            font-size: 12px;
            opacity: 0.9;
            background: rgba(255, 255, 255, 0.2);
            padding: 3px 8px;
            border-radius: 10px;
            display: inline-block;
        }

        .food-body {
            padding: 15px;
        }

        .serving-size {
            color: #718096;
            font-size: 14px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e2e8f0;
        }

        .nutrition-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }

        .nutrition-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 8px 12px;
            background: #f7fafc;
            border-radius: 8px;
            transition: background 0.3s;
        }

        .nutrition-item:hover {
            background: #edf2f7;
        }

        .nutrition-label {
            color: #718096;
            font-size: 13px;
        }

        .nutrition-value {
            font-weight: bold;
            color: #2d3748;
            font-size: 14px;
        }

        .nutrition-highlight {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
        }

        /* 칼로리 강조 */
        .calories-display {
            background: linear-gradient(135deg, #006994, #0099cc);
            color: white;
            padding: 12px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 15px;
            font-size: 20px;
            font-weight: bold;
        }

        /* 로딩 애니메이션 */
        .loading {
            text-align: center;
            padding: 40px;
            color: #718096;
        }

        .loading-spinner {
            border: 3px solid #e2e8f0;
            border-top: 3px solid #667eea;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 0 auto 20px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* 검색 없음 메시지 */
        .no-results {
            text-align: center;
            padding: 60px;
            color: #718096;
        }

        .no-results-icon {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .no-results-text {
            font-size: 20px;
            font-weight: 500;
            color: #4a5568;
            margin-bottom: 10px;
        }

        .no-results-hint {
            font-size: 16px;
            color: #718096;
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
                <a href="${pageContext.request.contextPath}/food/list.jsp">음식 목록</a>
                <a href="${pageContext.request.contextPath}/member/profile">내 정보</a>
                <a href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- 검색 섹션 -->
        <div class="search-section">
            <h1 class="search-title">🔍 음식 검색</h1>
            <p class="search-subtitle">14,000개 이상의 음식 데이터베이스에서 영양 정보를 찾아드립니다</p>

            <div class="search-box">
                <input type="text" id="searchInput" class="search-input"
                       placeholder="찾고 싶은 음식을 검색해보세요 (예: 김치, 닭가슴살, 사과)">
                <span class="search-icon">🔍</span>
                <div id="autocomplete" class="autocomplete-items" style="display: none;"></div>
            </div>

        </div>

        <!-- 통계 카드 -->
        <div class="stats-container">
            <div class="stat-card">
                <div class="stat-icon">🥗</div>
                <div class="stat-value" id="totalFoods">14,584</div>
                <div class="stat-label">전체 음식</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📊</div>
                <div class="stat-value" id="searchCount">0</div>
                <div class="stat-label">검색 결과</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">⚡</div>
                <div class="stat-value" id="avgCalories">-</div>
                <div class="stat-label">평균 칼로리</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">💪</div>
                <div class="stat-value" id="avgProtein">-</div>
                <div class="stat-label">평균 단백질(g)</div>
            </div>
        </div>

        <!-- 결과 섹션 -->
        <div class="results-section">
            <div class="results-header">
                <h2 class="results-title">검색 결과</h2>
                <span class="results-count" id="resultCount" style="display: none;">0개</span>
            </div>

            <div id="searchResults">
                <div class="no-results">
                    <div class="no-results-icon">🔍</div>
                    <div class="no-results-text">음식을 검색해보세요!</div>
                    <div class="no-results-hint">검색어를 입력하면 실시간으로 결과를 보여드립니다</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        let searchTimeout;
        const searchInput = document.getElementById('searchInput');
        const autocompleteDiv = document.getElementById('autocomplete');
        const resultsDiv = document.getElementById('searchResults');
        const searchCountEl = document.getElementById('searchCount');
        const resultCountEl = document.getElementById('resultCount');
        const avgCaloriesEl = document.getElementById('avgCalories');
        const avgProteinEl = document.getElementById('avgProtein');

        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            const keyword = this.value.trim();

            if (keyword.length < 1) {
                autocompleteDiv.style.display = 'none';
                autocompleteDiv.innerHTML = '';
                showNoResults();
                return;
            }

            searchTimeout = setTimeout(() => {
                const startTime = performance.now();

                // 자동완성
                fetch('${pageContext.request.contextPath}/api/food/search?keyword=' + encodeURIComponent(keyword) + '&mode=autocomplete&max=5')
                    .then(response => response.json())
                    .then(data => {

                        autocompleteDiv.innerHTML = '';
                        if (data.length > 0) {
                            autocompleteDiv.style.display = 'block';
                            data.forEach(food => {
                                const item = document.createElement('div');
                                item.className = 'autocomplete-item';
                                item.innerHTML = `
                                    <div>
                                        <strong>\${food.name}</strong>
                                    </div>
                                    <span class="autocomplete-category">\${food.category}</span>
                                `;
                                item.addEventListener('click', function() {
                                    searchInput.value = food.name;
                                    autocompleteDiv.style.display = 'none';
                                    performSearch(food.name);
                                });
                                autocompleteDiv.appendChild(item);
                            });
                        } else {
                            autocompleteDiv.style.display = 'none';
                        }
                    });

                // 동시에 전체 검색도 수행
                performSearch(keyword);
            }, 300);
        });

        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                autocompleteDiv.style.display = 'none';
                performSearch(this.value);
            }
        });

        function performSearch(keyword) {
            if (!keyword) return;

            showLoading();
            const startTime = performance.now();

            fetch('${pageContext.request.contextPath}/api/food/search?keyword=' + encodeURIComponent(keyword))
                .then(response => response.json())
                .then(data => {

                    if (data.length > 0) {
                        displayResults(data);
                        updateStats(data);
                    } else {
                        showNoResults(keyword);
                    }
                })
                .catch(error => {
                    console.error('Search error:', error);
                    resultsDiv.innerHTML = '<div class="no-results"><div class="no-results-text">검색 중 오류가 발생했습니다.</div></div>';
                });
        }

        function displayResults(foods) {
            searchCountEl.textContent = foods.length;
            resultCountEl.textContent = foods.length + '개';
            resultCountEl.style.display = 'inline-block';

            resultsDiv.innerHTML = '<div class="food-grid">' +
                foods.map(food => `
                    <div class="food-card">
                        <div class="food-header">
                            <div class="food-name">\${food.name}</div>
                            <span class="food-category">\${food.category}</span>
                        </div>
                        <div class="food-body">
                            <div class="serving-size">1회 제공량: \${food.servingSize}</div>
                            <div class="calories-display">\${food.calories} kcal</div>
                            <div class="nutrition-grid">
                                <div class="nutrition-item">
                                    <span class="nutrition-label">탄수화물</span>
                                    <span class="nutrition-value">\${food.carbohydrate}g</span>
                                </div>
                                <div class="nutrition-item nutrition-highlight">
                                    <span class="nutrition-label">단백질</span>
                                    <span class="nutrition-value">\${food.protein}g</span>
                                </div>
                                <div class="nutrition-item">
                                    <span class="nutrition-label">지방</span>
                                    <span class="nutrition-value">\${food.fat}g</span>
                                </div>
                                <div class="nutrition-item">
                                    <span class="nutrition-label">나트륨</span>
                                    <span class="nutrition-value">\${food.sodium}mg</span>
                                </div>
                                <div class="nutrition-item">
                                    <span class="nutrition-label">당류</span>
                                    <span class="nutrition-value">\${food.sugar}g</span>
                                </div>
                                <div class="nutrition-item">
                                    <span class="nutrition-label">콜레스테롤</span>
                                    <span class="nutrition-value">\${food.cholesterol}mg</span>
                                </div>
                            </div>
                        </div>
                    </div>
                `).join('') + '</div>';
        }

        function updateStats(foods) {
            const avgCalories = foods.reduce((sum, food) => sum + food.calories, 0) / foods.length;
            const avgProtein = foods.reduce((sum, food) => sum + food.protein, 0) / foods.length;

            avgCaloriesEl.textContent = Math.round(avgCalories);
            avgProteinEl.textContent = avgProtein.toFixed(1);
        }

        function showLoading() {
            resultsDiv.innerHTML = `
                <div class="loading">
                    <div class="loading-spinner"></div>
                    <div>검색 중입니다...</div>
                </div>
            `;
        }

        function showNoResults(keyword) {
            searchCountEl.textContent = '0';
            resultCountEl.style.display = 'none';
            avgCaloriesEl.textContent = '-';
            avgProteinEl.textContent = '-';

            if (keyword) {
                resultsDiv.innerHTML = `
                    <div class="no-results">
                        <div class="no-results-icon">😔</div>
                        <div class="no-results-text">'<strong>\${keyword}</strong>'에 대한 검색 결과가 없습니다</div>
                        <div class="no-results-hint">다른 검색어로 시도해보세요</div>
                    </div>
                `;
            } else {
                resultsDiv.innerHTML = `
                    <div class="no-results">
                        <div class="no-results-icon">🔍</div>
                        <div class="no-results-text">음식을 검색해보세요!</div>
                        <div class="no-results-hint">검색어를 입력하면 실시간으로 결과를 보여드립니다</div>
                    </div>
                `;
            }
        }

        // 클릭 외부 시 자동완성 닫기
        document.addEventListener('click', function(e) {
            if (!searchInput.contains(e.target) && !autocompleteDiv.contains(e.target)) {
                autocompleteDiv.style.display = 'none';
            }
        });
    </script>
</body>
</html>