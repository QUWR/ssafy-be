-- 데이터베이스 생성
CREATE DATABASE IF NOT EXISTS ssafy_diet DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE ssafy_diet;

-- 회원 테이블
CREATE TABLE IF NOT EXISTS member (
    mno INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'USER',
    height DOUBLE DEFAULT 0,
    weight DOUBLE DEFAULT 0,
    health_condition VARCHAR(255),
    goal VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 음식 테이블
CREATE TABLE IF NOT EXISTS food (
    code VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    serving_size VARCHAR(100),
    calories DOUBLE DEFAULT 0,
    carbohydrate DOUBLE DEFAULT 0,
    protein DOUBLE DEFAULT 0,
    fat DOUBLE DEFAULT 0,
    sugar DOUBLE DEFAULT 0,
    sodium DOUBLE DEFAULT 0,
    cholesterol DOUBLE DEFAULT 0,
    saturated_fat DOUBLE DEFAULT 0,
    trans_fat DOUBLE DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 식단 테이블
CREATE TABLE IF NOT EXISTS diet (
    diet_id INT AUTO_INCREMENT PRIMARY KEY,
    member_no INT NOT NULL,
    meal_time DATETIME NOT NULL,
    meal_type VARCHAR(50),
    memo TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (member_no) REFERENCES member(mno) ON DELETE CASCADE
);

-- 식단-음식 관계 테이블
CREATE TABLE IF NOT EXISTS diet_food (
    diet_food_id INT AUTO_INCREMENT PRIMARY KEY,
    diet_id INT NOT NULL,
    food_code VARCHAR(50) NOT NULL,
    quantity DOUBLE DEFAULT 1.0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (diet_id) REFERENCES diet(diet_id) ON DELETE CASCADE,
    FOREIGN KEY (food_code) REFERENCES food(code) ON DELETE CASCADE
);

-- 인덱스 생성
CREATE INDEX idx_member_email ON member(email);
CREATE INDEX idx_food_name ON food(name);
CREATE INDEX idx_food_category ON food(category);
CREATE INDEX idx_diet_member ON diet(member_no);
CREATE INDEX idx_diet_meal_time ON diet(meal_time);
CREATE INDEX idx_diet_food_diet ON diet_food(diet_id);
CREATE INDEX idx_diet_food_food ON diet_food(food_code);