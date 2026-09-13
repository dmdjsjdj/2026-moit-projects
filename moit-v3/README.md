# 🔷 MOIT v3

> **Spring Boot REST API + React 기반으로 프론트엔드와 백엔드를 분리하고 광고 시스템을 고도화한 MOIT 세 번째 프로젝트**

MOIT v3에서는 기존 서버 사이드 렌더링 구조에서 벗어나 **Spring Boot REST API + React** 구조로 전환했습니다.

또한 광고 기능을 중심으로 결제, 통계, Scheduler, Redis, LLM API 등을 적용하여 단순 기능 구현을 넘어 하나의 서비스 흐름을 설계하고 구현하는 것을 목표로 했습니다.

---

## 📌 Project

**MOIT (Meet Our Interest Together)**

스터디, 프로젝트, 운동, 취미 등 공통 관심사를 가진 사람들이 모임을 만들고 참여할 수 있는 목적형 커뮤니티 플랫폼입니다.

---

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| Language | Java 17, JavaScript |
| Backend | Spring Boot, Spring Security |
| Authentication | JWT |
| Data Access | JPA |
| Database | Oracle |
| Cache | Redis |
| Frontend | React |
| State | Redux, Redux-Saga |
| HTTP | Axios |
| UI | Ant Design |
| Payment | Toss Payments |
| Mail | JavaMailSender |
| AI | LLM API |
| Chart | Chart.js |
| Version Control | Git, GitHub |

---

## 🔄 v1 → v2 → v3

| Version | 구조 | 핵심 변화 |
|---|---|---|
| v1 | Spring + JSP | 기본 커뮤니티 기능 구현 |
| v2 | Spring Boot + Thymeleaf | Security / AI / Open API 기능 고도화 |
| **v3** | **Spring Boot REST API + React** | **프론트·백엔드 분리 및 광고 서비스 고도화** |

---

# 🔌 Frontend / Backend 분리

v3에서는 React와 Spring Boot를 분리하여 REST API 기반으로 데이터를 주고받도록 구조를 변경했습니다.

```text
[React]
    │
    │ Axios
    ↓
[Spring Boot REST API]
    ↓
[Controller]
    ↓
[Service]
    ↓
[JPA]
    ↓
[Oracle]
```

프론트엔드는 화면과 상태 관리를 담당하고 백엔드는 API와 비즈니스 로직을 담당하도록 역할을 분리했습니다.

---

# 🔐 인증 및 권한

Spring Security와 JWT를 활용하여 사용자의 인증과 권한을 관리했습니다.

### 주요 권한

```text
ROLE_MEMBER
ROLE_PARTNER
ROLE_ADMIN
ROLE_SUPERADMIN
```

특히 광고 기능에서는 JWT 인증 정보를 기반으로 요청 사용자의 권한과 광고 소유자를 검증하도록 구성했습니다.

---

# 📢 Advertisement

v3에서 가장 집중적으로 고도화한 기능입니다.

파트너가 광고를 등록한 이후 관리자 승인, 결제, 광고 노출, 통계, 종료 및 연장까지 하나의 비즈니스 흐름으로 구현했습니다.

## 광고 흐름

```text
광고 등록
    ↓
관리자 승인 / 반려
    ↓
결제 요청
    ↓
Toss 결제
    ↓
광고 OPEN
    ↓
광고 노출
    ↓
노출 / 클릭 수집
    ↓
통계 생성
    ↓
종료 / 연장
```

승인 상태와 실제 광고 운영 상태를 분리하여 관리했습니다.

### 승인 상태

```text
WAITING
APPROVED
REJECTED
```

### 운영 상태

```text
PENDING
OPEN
CLOSED
```

---

# 💰 광고 가격 및 결제

광고 금액은 다음 조건을 기준으로 계산했습니다.

- 광고 등급
- 광고 위치
- 광고 기간

### 광고 등급

```text
GENERAL
PREMIUM
```

### 광고 위치

```text
MAIN
MEETUP_LIST_BANNER
MEETUP_LIST_SIDEBAR
MEETUP_DETAIL_SIDEBAR
```

### 결제 유형

```text
INITIAL
EXTENSION
```

초기 광고 결제와 광고 연장 결제를 구분하여 처리했습니다.

---

## 결제 금액 고정

관리자가 가격 정책을 변경한 이후 이미 신청한 광고의 결제 금액까지 변경될 수 있는 문제가 있었습니다.

이를 해결하기 위해 신청 시점에 계산된 금액을 `totalBudget`에 저장했습니다.

```text
광고 신청
   ↓
신청 당시 가격 계산
   ↓
totalBudget 저장
   ↓
관리자 가격 정책 변경
   ↓
기존 광고 금액 유지
```

이를 통해 가격 정책 변경과 기존 계약 금액을 분리했습니다.

---

# 📊 광고 통계

광고 노출과 클릭 데이터를 수집하고 일별 통계를 생성하도록 구성했습니다.

### 제공 데이터

- 일별 노출 수
- 일별 클릭 수
- CTR
- 등급별 성과
- 위치별 성과
- 광고 연장 비율

Chart.js를 활용하여 관리자가 광고 성과를 한눈에 확인할 수 있도록 대시보드를 구성했습니다.

---

# 🎯 광고 노출 우선순위

여러 광고가 동시에 노출되는 환경을 고려하여 광고별 우선순위를 계산하는 로직을 적용했습니다.

```text
광고 등급
   +
노출 / 클릭 데이터
   +
랜덤 요소
   ↓
Priority Score
   ↓
노출 우선순위
```

또한 동일 광고의 반복 노출을 줄이기 위해 최근 노출 데이터를 기반으로 **Fatigue Score**를 반영했습니다.

---

# ⏰ Scheduler

반복적으로 발생하는 운영 작업을 Spring Scheduler를 이용해 자동화했습니다.

### 자동화 항목

- 광고 상태 변경
- 광고 우선순위 갱신
- 광고 피로도 갱신
- 종료 예정 알림
- 일별 통계 생성
- AI 통계 요약 갱신

광고 종료 예정일을 기준으로 파트너에게 알림 메일을 자동 발송하도록 구성했습니다.

```text
30일 전
   ↓
14일 전
   ↓
7일 전
   ↓
광고 종료
```

---

# 📈 광고 관리자 대시보드

광고 운영 데이터를 관리자가 확인할 수 있도록 통계 대시보드를 구현했습니다.

### 주요 정보

- 일별 노출 / 클릭
- CTR
- 등급별 광고 성과
- 위치별 광고 성과
- 광고 연장 비율
- AI 성과 요약

LLM API를 이용해 통계 데이터를 분석하고 관리자가 빠르게 성과를 파악할 수 있도록 AI 요약 정보를 제공했습니다.

---

# 🤖 LLM API

LLM API를 광고 기능에 두 가지 방식으로 활용했습니다.

### 광고 작성 보조

광고 작성 과정에서 일정 시간 입력이 없을 경우 AI를 이용해 광고 제목과 내용을 작성할 수 있도록 보조했습니다.

### 통계 요약

```text
광고 통계
   ↓
LLM API
   ↓
JSON 응답 검증
   ↓
AI 성과 요약
```

예상하지 못한 응답 형식에 대비하여 JSON 검증과 fallback 처리를 적용했습니다.

---

# 🗂️ 광고 데이터 구조

```text
Advertisement
 ├── AdvertisementImage
 ├── AdvertisementPayment
 ├── AdvertisementTargetRegion
 ├── AdvertisementDailyStatistics
 ├── AdvertisementClickLog
 ├── AdvertisementImpressionLog
 └── AdvertisementAiSummary
```

광고 본체와 이미지, 결제, 지역, 노출·클릭 로그 및 통계 데이터를 분리하여 관리했습니다.

---

# 🖥️ Frontend

React 기반으로 광고 관련 화면을 구현했습니다.

### 주요 화면

- 광고 등록
- 광고 목록
- 광고 상세
- 광고 수정
- 관리자 승인 / 반려
- 관리자 광고 상태 관리
- 결제
- 광고 연장
- 광고 통계 대시보드

Redux-Saga와 Axios를 이용해 React와 Spring Boot API 간 비동기 통신을 처리했습니다.

---

# 🔧 Troubleshooting

## 01. 광고 연장 결제 금액 및 기간 불일치

광고 연장 과정에서 화면에 표시되는 금액과 실제 결제 및 광고 기간이 서로 다르게 처리되는 문제가 발생했습니다.

### 해결

광고 연장 요청 시

```text
연장 기간
 ↓
연장 가격 조회
 ↓
결제 금액 확정
 ↓
결제 성공
 ↓
광고 종료일 연장
```

순서로 처리하도록 흐름을 명확하게 분리했습니다.

---

## 02. 광고 승인·결제·노출 상태 불일치

승인 상태와 광고 운영 상태를 하나의 값으로 관리하면 결제 전 광고가 노출되는 등 상태 판단이 모호해지는 문제가 있었습니다.

### 해결

```text
승인 상태
WAITING / APPROVED / REJECTED

운영 상태
PENDING / OPEN / CLOSED
```

로 분리하여 각각 독립적으로 관리했습니다.

---

## 03. 7일 통계만으로 광고 성과를 판단하기 어려운 문제

초기 대시보드에서 최근 7일 데이터를 기준으로 통계를 보여주도록 구성했지만 광고 데이터가 충분히 쌓이지 않은 상태에서는 성과를 비교하기 어려웠습니다.

### 해결

일별 통계 데이터를 별도로 축적하고 대시보드 조회 기간을 확장할 수 있도록 구성하여 더 긴 기간의 데이터를 비교할 수 있도록 개선했습니다.

---

# 📈 v3에서 배운 점

### 01. 서비스 전체 흐름을 기준으로 설계

React 화면 하나의 기능만 구현하는 것이 아니라

```text
React
 ↓
API
 ↓
Controller
 ↓
Service
 ↓
Database
 ↓
Response
 ↓
React
```

전체 흐름을 확인하며 기능을 구현했습니다.

---

### 02. 상태 설계의 중요성

광고 기능을 구현하면서 승인, 결제, 운영, 종료, 연장 등 여러 상태가 연결되기 때문에 각 상태의 책임과 전이 조건을 먼저 정의하는 것이 중요하다는 것을 경험했습니다.

---

### 03. 외부 시스템의 실패까지 고려

Toss Payments와 LLM API를 연동하면서 정상 응답만을 가정하지 않고

- 외부 응답 검증
- 서비스 상태 반영
- 예외 상황 처리
- fallback

까지 고려해야 한다는 것을 배웠습니다.

---

# 📝 Retrospective

MOIT v3에서는 새로운 기능을 추가하는 것보다 **기능이 실제 서비스에서 어떻게 연결되는지를 이해하는 것**에 집중했습니다.

특히 광고 기능을 구현하면서

```text
등록
 ↓
승인
 ↓
결제
 ↓
노출
 ↓
통계
 ↓
알림
 ↓
연장
```

이라는 하나의 비즈니스 흐름을 직접 구성했습니다.

이를 통해 하나의 기능을 완성하기 위해서는 화면뿐만 아니라 **데이터, API, 상태, 외부 서비스, 자동화까지 함께 설계해야 한다는 것**을 경험했습니다.

---

## 🔗 Previous Versions

- [MOIT v1](../moit-v1/README.md)
- [MOIT v2](../moit-v2/README.md)
- **MOIT v3**
