# Yum Yum Coach API 명세서

이 문서는 Yum Yum Coach 백엔드 API의 사양을 정의합니다.

## 목차
- [Food API](#food-api)
- [Member API](#member-api)

---

## Food API
**Base Path:** `/api/food`

### 1. 음식 데이터베이스 업로드 (초기 설정용)
- **Description:** 서버에 저장된 Excel 파일을 읽어 음식 정보를 데이터베이스에 저장합니다. 프론트엔드에서 직접 호출할 필요는 없는 기능으로 보입니다.
- **Endpoint:** `GET /api/food/upload`
- **Request:** 없음
- **Success Response:**
  - **Code:** `200 OK`
  - **Body:** `Successfully processed {count} records.` (문자열)
- **Error Response:**
  - **Code:** `500 Internal Server Error`
  - **Body:** `Error during upload: {error_message}` (문자열)

### 2. 음식 검색
- **Description:** 키워드를 사용하여 음식을 검색합니다. `autocomplete` 파라미터로 자동완성 여부를 제어할 수 있습니다.
- **Endpoint:** `GET /api/food/search`
- **Query Parameters:**
  - `keyword` (string, required): 검색할 키워드.
  - `autocomplete` (boolean, optional): `true`로 설정 시 자동완성 검색을 수행합니다. 기본값은 `false`입니다.
  - `max` (int, optional): `autocomplete`가 `true`일 때 최대 결과 개수를 지정합니다. 기본값은 10입니다.
- **Success Response:**
  - **Code:** `200 OK`
  - **Body:** `Food` 객체의 배열
    ```json
    [
      {
        "code": "D000006",
        "name": "가자미구이",
        "category": "구이류",
        "servingSize": "150",
        "calories": 237.9,
        "carbohydrate": 3.7,
        "protein": 31.2,
        "fat": 10.9,
        "sugar": 0.0,
        "sodium": 440.5,
        "cholesterol": 131.1,
        "saturatedFat": 2.8,
        "transFat": 0.1
      }
    ]
    ```
- **Error Response:**
  - **Code:** `400 Bad Request` (키워드가 없을 경우)

### 3. 전체 음식 목록 조회
- **Description:** 데이터베이스에 있는 모든 음식 목록을 가져옵니다.
- **Endpoint:** `GET /api/food/list`
- **Request:** 없음
- **Success Response:**
  - **Code:** `200 OK`
  - **Body:** `Food` 객체의 배열 (위의 `Food` 객체 구조와 동일)

---

## Member API
**Base Path:** `/api/member`

### 1. 회원가입
- **Description:** 새로운 회원을 등록합니다.
- **Endpoint:** `POST /api/member/register`
- **Request Body:** `Member` 객체
  ```json
  {
    "name": "김싸피",
    "email": "ssafy@ssafy.com",
    "password": "password123",
    "height": 175.5,
    "weight": 70.2,
    "healthCondition": "특이사항 없음",
    "goal": "체중 감량"
  }
  ```
- **Success Response:**
  - **Code:** `200 OK`
  - **Body:**
    ```json
    {
      "message": "회원가입에 성공했습니다.",
      "error": null
    }
    ```
- **Error Response:**
  - **Code:** `409 Conflict` (이미 등록된 이메일일 경우)
  - **Body:**
    ```json
    {
      "message": null,
      "error": "이미 등록된 이메일입니다."
    }
    ```

### 2. 로그인
- **Description:** 이메일과 비밀번호로 로그인하여 JWT 토큰을 발급받습니다.
- **Endpoint:** `POST /api/member/login`
- **Request Body:**
  ```json
  {
    "email": "ssafy@ssafy.com",
    "password": "password123"
  }
  ```
- **Success Response:**
  - **Code:** `200 OK`
  - **Body:**
    ```json
    {
      "token": "ey...",
      "error": null
    }
    ```
- **Error Response:**
  - **Code:** `401 Unauthorized`
  - **Body:**
    ```json
    {
      "token": null,
      "error": "로그인 실패: {error_message}"
    }
    ```

### 3. 프로필 조회
- **Description:** 현재 로그인된 사용자의 프로필 정보를 조회합니다.
- **Endpoint:** `GET /api/member/profile`
- **Headers:**
  - `Authorization`: `Bearer {jwt_token}`
- **Success Response:**
  - **Code:** `200 OK`
  - **Body:**
    ```json
    {
      "member": {
        "mno": 1,
        "name": "김싸피",
        "email": "ssafy@ssafy.com",
        "password": null, // 보안상 null 처리
        "role": "USER",
        "height": 175.5,
        "weight": 70.2,
        "healthCondition": "특이사항 없음",
        "goal": "체중 감량"
      },
      "error": null
    }
    ```
- **Error Response:**
  - **Code:** `401 Unauthorized` (로그인이 필요할 경우)
  - **Body:**
    ```json
    {
      "member": null,
      "error": "로그인이 필요합니다."
    }
    ```

### 4. 프로필 수정
- **Description:** 현재 로그인된 사용자의 프로필 정보를 수정합니다.
- **Endpoint:** `PUT /api/member/update`
- **Headers:**
  - `Authorization`: `Bearer {jwt_token}`
- **Request Body:** `Member` 객체 (수정할 필드만 포함)
  ```json
  {
    "name": "김싸피",
    "password": "new_password123",
    "height": 176.0,
    "weight": 69.5,
    "healthCondition": "주 3회 운동",
    "goal": "근력 증가"
  }
  ```
- **Success Response:**
  - **Code:** `200 OK`
  - **Body:**
    ```json
    {
      "message": "프로필이 성공적으로 업데이트되었습니다.",
      "error": null
    }
    ```
- **Error Response:**
  - **Code:** `401 Unauthorized`
  - **Code:** `500 Internal Server Error`

### 5. 회원 탈퇴
- **Description:** 현재 로그인된 사용자의 계정을 삭제합니다.
- **Endpoint:** `DELETE /api/member/delete`
- **Headers:**
  - `Authorization`: `Bearer {jwt_token}`
- **Success Response:**
  - **Code:** `200 OK`
  - **Body:**
    ```json
    {
      "message": "회원 탈퇴가 성공적으로 처리되었습니다.",
      "error": null
    }
    ```
- **Error Response:**
  - **Code:** `401 Unauthorized`
