# 프로토콜 명세서
버전: 1.0
<br/>
작성일: 2023-11-07
<br/>
작성자: 최진수



## 1. 로그인 (Login)
클라이언트에서 서버로 로그인 요청을 보냅니다.
### 1-1. 요청 (Request)
#### 요청 메시지 (Request Message):
<pre>
{
  "요청타입": "로그인",
  "사용자ID": "manager_id",
  "비밀번호": "password"
}
</pre>
### 2-2. 응답 (Response)
#### 응답 메시지 (Response Message):
<pre>
{
  "성공": true,
  "사용자ID": "manager_id",
  "사용자Nick": "manager_nick"
}
</pre>

## 2. 유저정보조회 (getUserData)
클라이언트에서 서버로 유저정보조회 요청을 보냅니다.
### 2-1. 요청 (Request)
#### 요청 메시지 (Request Message):
<pre>
{
  "요청타입": "유저_데이터_요청",
  "사용자ID": "manager_id",
  "데이터_타입": "Object"
}
</pre>
### 2-2. 응답 (Response)
#### 응답 메시지 (Response Message):
<pre>
{
  "데이터": {
    "manager_id": 123,
    "manager_nick": "nick",
    "password" : 12341234,
    "manager_bd" : 1996-10-07,
    "manager_hp" : 010-2534-9160,
    "manager_gender" : "M",
    "user_bd" : 1957-10-13,
    "user_hp" : 010-9899-9160,
    "user_gender" : "W",
  }
}
</pre>

## 3. 회원가입 (Join)
클라이언트에서 서버로 회원가입 요청을 보냅니다.
### 3-1. 요청 (Request)
#### 요청 메시지 (Request Message):
<pre>
{
  "요청타입": "회원가입",
  "manager_id": 123,
  "manager_nick": "nick",
  "password" : 12341234,
  "manager_bd" : 1996-10-07,
  "manager_hp" : 010-2534-9160,
  "manager_gender" : "M",
  "user_bd" : 1957-10-13,
  "user_hp" : 010-9899-9160,
  "user_gender" : "W",
}
</pre>
### 3-2. 응답 (Response)
#### 응답 메시지 (Response Message):
<pre>
{
  "성공": true
}
</pre>


