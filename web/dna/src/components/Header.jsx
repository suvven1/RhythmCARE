import React from "react";
import { Link } from "react-router-dom";

const Header = () => {
  return (
    <div>
      <Link to="/">
        <button>서비스소개</button>
      </Link>
      <Link to="/rhythm">
        <button>측정데이터확인</button>
      </Link>
      <Link to="/calender">
        <button>캘린더</button>
      </Link>
      <Link to="/hospital">
        <button>주변병원정보</button>
      </Link>
      <Link to="/community">
        <button>커뮤니티</button>
      </Link>
      <Link to="/login">
        <button>로그인</button>
      </Link>
      <Link to="/join">
        <button>회원가입</button>
      </Link>
      <hr />
    </div>
  );
};

export default Header;
