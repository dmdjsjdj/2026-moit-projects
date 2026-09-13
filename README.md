# 🚀 MOIT Project History

**MOIT(Meet Our Interest Together)​**는 관심사를 기반으로 사용자가 원하는 모임을 만들고 참여할 수 있는 **목적형 모임 커뮤니티 플랫폼**입니다.

하나의 프로젝트를 여러 차례 고도화하며  
**Spring → Spring Boot → React 기반의 분리형 구조**로 발전시켰습니다.

---

## 📌 Project Evolution

| Version | Tech Stack | 주요 내용 |
| :---: | :--- | :--- |
| **v1** | Spring Framework, JSP, MyBatis, MySQL, Ajax | 기본 웹 서비스 및 핵심 기능 구현 |
| **v2** | Spring Boot, Thymeleaf, MyBatis, Oracle, Ajax, Open API | Spring Boot 기반 마이그레이션 및 기능 고도화 |
| **v3** | Spring Boot, React, JPA, MyBatis, Oracle, JWT, Redis, Next.js, Ant Design | 프론트·백엔드 분리 및 인증·광고·결제·통계 기능 확장 |

---

# 📂 Version Details

## 📌 MOIT v1

### Tech Stack

`Spring Framework` · `JSP` · `MyBatis` · `MySQL` · `Ajax`

### 주요 내용

- Spring MVC 기반 웹 서비스 구현
- JSP 기반 화면 구성
- MyBatis를 활용한 데이터베이스 연동
- 회원가입 및 로그인
- 모임 등록 및 신청
- 문의
- 후기
- 신고
- 광고

### Project

📁 [README](./moit-v1/README.md)

📖 [Notion](https://app.notion.com/p/MoA-37195798f73380cebe19e12b11b69dad?source=copy_link)

---

## 📌 MOIT v2

### Tech Stack

`Spring Boot` · `Thymeleaf` · `MyBatis` · `Oracle` · `Ajax` · `Open API`

### 주요 내용

- Spring Framework → Spring Boot 기반으로 마이그레이션
- JSP → Thymeleaf 기반 화면 구성
- Oracle 데이터베이스 전환
- 기존 프로젝트 구조 개선
- 기존 MOIT 기능 고도화
- Ajax 및 Open API 연동

### Project

📁 [README](./moit-v2/README.md)

📖 [Notion](https://app.notion.com/p/MoA-37195798f73380cebe19e12b11b69dad?source=copy_link)

---

## 📌 MOIT v3

### Tech Stack

`Spring Boot` · `Gradle` · `JPA` · `MyBatis` · `Oracle` · `JWT` · `Redis` · `React` · `Next.js` · `Ant Design`

### 주요 내용

#### 🔄 프로젝트 구조 개선

- Spring Boot + Gradle 기반 백엔드 환경 구축
- 서버 사이드 렌더링 방식에서 React 기반 프론트엔드로 전환
- REST API 기반 프론트·백엔드 분리
- JPA 도입 및 Entity 중심 데이터 관리
- 기존 MyBatis와 JPA를 함께 사용하는 데이터 접근 구조 적용

#### 🔐 인증 및 데이터 관리

- Spring Security 기반 인증·인가
- JWT 기반 사용자 인증
- Redis를 활용한 인증 및 데이터 관리
- 사용자 권한에 따른 접근 제어

#### 📢 광고 시스템 고도화

- 파트너 광고 등록
- 관리자 승인 및 반려
- 광고 결제
- 광고 노출 및 상태 관리
- 광고 연장
- 노출·클릭 통계
- 광고 우선순위 및 피로도 관리
- 종료 예정 알림 자동화
- 광고 성과 대시보드
- AI 기반 광고 성과 요약

#### 💳 외부 서비스 연동

- Toss Payments 결제 연동
- JavaMailSender를 활용한 이메일 알림
- LLM API를 활용한 AI 기능

### Project

📁 [README](./moit-v3/README.md)

📖 [Notion](https://app.notion.com/p/MoA-37195798f73380cebe19e12b11b69dad?source=copy_link)

---

# 🔄 MOIT Development History

```text
MOIT v1
Spring + JSP + MyBatis + MySQL
        ↓
기본 웹 서비스 구현
        ↓
MOIT v2
Spring Boot + Thymeleaf + MyBatis + Oracle
        ↓
Spring Boot 마이그레이션 및 기능 고도화
        ↓
MOIT v3
Spring Boot + React + JPA + MyBatis
        ↓
프론트·백엔드 분리
        ↓
JWT + Redis + 결제 + 광고 + 통계 + AI
```

---

## 🎯 프로젝트를 통해 발전한 부분

### v1
웹 서비스의 기본 구조와  
Spring MVC, JSP, MyBatis를 활용한 데이터 처리 흐름을 경험했습니다.

### v2
Spring Boot를 도입하고 화면 기술을 Thymeleaf로 변경하면서  
프로젝트 구조와 개발 환경을 개선했습니다.

### v3
React와 Spring Boot를 분리하고 REST API 기반으로 전환하면서  
프론트엔드와 백엔드 간 데이터 흐름을 직접 설계하고 구현했습니다.

또한 광고 기능을 중심으로 **등록 → 승인 → 결제 → 노출 → 통계 → 연장**으로 이어지는 비즈니스 흐름을 구현하며 서비스 전체 구조를 경험했습니다.

---

## 📁 Repository Structure

```text
2026-tjoeun-projects
│
├── moit-v1
│   └── README.md
│
├── moit-v2
│   └── README.md
│
└── moit-v3
    └── README.md
```

> **하나의 MOIT 서비스를 기술과 구조를 단계적으로 발전시키며 구현한 프로젝트입니다.**
