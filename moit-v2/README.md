# 🔷 MOIT v2

> **Spring Boot 기반으로 구조를 개선하고 AI 및 Open API 기능을 추가한 MOIT 두 번째 프로젝트**

MOIT v2에서는 v1에서 구현한 기본 커뮤니티 기능을 기반으로 Spring Boot 환경으로 전환하고 다양한 외부 API와 AI 기능을 적용했습니다.

서비스의 기본 기능을 유지하면서 사용자 편의성과 보안, 자동화 기능을 중심으로 고도화했습니다.

---

## 📌 Project

**MOIT (Meet Our Interest Together)**

관심사를 기반으로 사용자가 모임을 생성하고 참여할 수 있는 목적형 커뮤니티 플랫폼입니다.

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| Language | Java |
| Backend | Spring Boot, Spring Security |
| Frontend | Thymeleaf, HTML, CSS, JavaScript |
| Database | Oracle |
| Data Access | MyBatis |
| Authentication | OAuth2, BCrypt |
| AI | OpenAI GPT API |
| Open API | 기상청, VWorld, 네이버 MAP |
| Mail | SMTP |
| Build | Gradle |
| Version Control | Git, GitHub |

---

## 🔄 v1 → v2

| 구분 | v1 | v2 |
|---|---|---|
| Framework | Spring | Spring Boot |
| View | JSP | Thymeleaf |
| Database | MySQL | Oracle |
| Data Access | MyBatis | MyBatis |
| Security | 기본 로그인 | Spring Security + OAuth2 |
| AI | - | OpenAI GPT API |
| External API | - | 기상청 / VWorld / 네이버 MAP |
| 목적 | 기본 기능 구현 | 구조 개선 및 기능 고도화 |

---

## ✨ 주요 기능

### 👤 회원

- 회원가입 / 로그인
- OAuth2 소셜 로그인
- 관심사 태그 등록
- BCrypt 비밀번호 암호화
- HIBP API 기반 비밀번호 유출 여부 검사

---

### 🤝 모임

- 모임 등록 및 조회
- 모임 신청
- OpenAI GPT API 기반 모임 제목 추천
- 카테고리 추천
- 소개글 작성 보조
- 참가자 신뢰도 AI 평가
- 기상청 단기예보 기반 날씨 정보
- VWorld 주소 검색
- 네이버 MAP 기반 위치 시각화

---

### 📝 후기

- 후기 작성 / 조회 / 수정 / 삭제
- 후기 좋아요
- OpenAI GPT API 기반 욕설 및 비방 필터링
- 개설자 후기 분석

---

### 📨 문의

- 문의 작성 / 조회 / 수정 / 삭제
- 관리자 답변
- AI 기반 비속어 필터링
- 답변 등록 시 비동기 이벤트 기반 알림

---

### 🚨 신고

- 모집글 / 후기 신고
- 관리자 신고 처리
- AI 기반 신고 사유 문장 생성
- 중복 신고 방지
- SMTP 기반 처리 결과 메일 발송

---

### 📢 광고

- 광고 등록 / 수정 / 삭제
- 광고 상태 관리
- Scheduler 기반 광고 상태 자동 관리
- 광고 종료 예정 메일 발송
- AI 기반 광고 제목 및 내용 작성 보조

---

## 🤖 AI 및 Open API

v2에서는 단순 CRUD 기능을 넘어 외부 서비스를 실제 서비스 흐름에 연결하는 경험을 확대했습니다.

```text
사용자 요청
    ↓
Spring Boot
    ↓
외부 API
    ↓
응답 데이터 처리
    ↓
서비스 적용
```

OpenAI GPT API를 이용해 콘텐츠 생성과 필터링을 구현하고, 기상청, VWorld, 네이버 MAP 등의 API를 서비스 기능과 연동했습니다.

---

## 📈 v2에서 배운 점

### 01. 기존 프로젝트를 개선하는 과정

새로운 프로젝트를 처음부터 만드는 것이 아니라 v1의 구조와 기능을 기반으로 필요한 부분을 개선하면서 리팩토링의 필요성을 경험했습니다.

### 02. 외부 API 연동

외부 API의 요청과 응답 데이터를 서비스의 비즈니스 로직에 연결하면서 외부 시스템과 내부 서비스를 연동하는 과정을 경험했습니다.

### 03. 보안과 사용자 경험

Spring Security와 OAuth2를 적용하고 AI 및 외부 API를 활용하면서 기능 구현뿐 아니라 보안과 사용자 경험까지 고려하게 되었습니다.

---

## 🚀 Next

v2에서는 서버가 화면까지 렌더링하는 구조를 사용했습니다.

v3에서는 **Spring Boot REST API + React** 구조로 전환하고 광고 시스템을 중심으로 결제, 통계, 자동화 기능을 고도화했습니다.

➡️ [MOIT v3](../moit-v3/README.md)
