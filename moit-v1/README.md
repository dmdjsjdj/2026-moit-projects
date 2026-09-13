# 🔷 MOIT v1

> **Spring + JSP + MyBatis 기반으로 구현한 MOIT 첫 번째 프로젝트**

MOIT의 초기 버전으로, 관심사를 기반으로 사용자가 모임을 만들고 참여할 수 있는 목적형 커뮤니티 서비스를 구현했습니다.

Java Spring Framework와 JSP를 이용해 화면과 서버를 구성하고, MyBatis를 통해 MySQL 데이터베이스와 연동했습니다.

---

## 📌 Project

**MOIT (Meet Our Interest Together)**

스터디, 프로젝트, 운동, 취미 등 공통 관심사를 가진 사람들이 모임을 만들고 참여할 수 있는 커뮤니티 플랫폼입니다.

### 주요 흐름

```text
사용자
 ↓
JSP
 ↓
Controller
 ↓
Service
 ↓
MyBatis
 ↓
MySQL
```

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| Language | Java |
| Backend | Spring Framework |
| Frontend | JSP, HTML, CSS, JavaScript |
| Database | MySQL |
| Data Access | MyBatis |
| Server | Apache Tomcat |
| Version Control | Git, GitHub |

---

## ✨ 주요 기능

### 👤 회원

- 회원가입
- 로그인

### 🤝 모임

- 모집글 작성
- 모집글 조회
- 모집글 수정 및 삭제
- 모임 신청

### 📝 후기

- 후기 작성
- 후기 조회
- 후기 수정 및 삭제
- 후기 좋아요

### 🚨 신고

- 모집글 신고
- 후기 신고
- 신고 내역 관리
- 관리자 신고 처리

### 📢 광고

- 광고 등록
- 광고 조회
- 광고 수정 및 삭제
- 광고 상태 관리

---

## 🔄 데이터 처리 흐름

```text
Browser
   ↓
JSP
   ↓
Controller
   ↓
Service
   ↓
MyBatis
   ↓
MySQL
   ↓
Service
   ↓
Controller
   ↓
JSP
```

사용자의 요청이 Controller와 Service를 거쳐 데이터베이스에 전달되고 다시 화면으로 반환되는 웹 애플리케이션의 기본적인 요청·응답 흐름을 구현했습니다.

---

## 📚 주요 학습

### Spring MVC

Controller, Service, DAO, View 계층을 분리하여 각 계층의 역할과 MVC 구조를 이해했습니다.

### JSP

서버에서 전달된 데이터를 화면에 출력하고 사용자 요청에 따라 동적으로 페이지를 구성했습니다.

### MyBatis

SQL을 직접 작성하여

- SELECT
- INSERT
- UPDATE
- DELETE
- JOIN

등의 데이터 처리 과정을 구현했습니다.

### MySQL

서비스에 필요한 데이터를 관계형 구조로 설계하고 SQL을 이용한 CRUD와 테이블 간 데이터 조회를 경험했습니다.

---

## 📈 v1에서 배운 점

### 01. MVC 구조

화면, 비즈니스 로직, 데이터 접근 영역을 분리하면서 각 계층의 역할을 이해했습니다.

### 02. SQL과 애플리케이션 연결

MyBatis를 통해 Java 애플리케이션과 SQL을 연결하고 조회 결과를 객체로 전달하는 과정을 경험했습니다.

### 03. 웹 서비스 전체 흐름

```text
Browser
 → Controller
 → Service
 → Database
 → Service
 → Controller
 → JSP
```

사용자의 요청부터 데이터 처리와 화면 응답까지 하나의 흐름으로 이해하는 기반을 만들었습니다.

---

## 🚀 Next

v1에서 경험한 Spring MVC와 데이터 처리 구조를 기반으로 다음 버전에서는 **Spring Boot 기반으로 프로젝트를 전환하고 보안, AI, Open API 등의 기능을 추가했습니다.**

➡️ [MOIT v2](../moit-v2/README.md)
