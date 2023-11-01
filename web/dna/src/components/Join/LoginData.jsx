import React from "react";
import { Link } from "react-router-dom";

const LoginData = () => {
  return (
    <div>
      <div>로그인 정보 입력</div>
      <div>
        <input type="text" placeholder="아이디" />
      </div>
      <div>
        <input type="text" placeholder="닉네임" />
      </div>
      <div>
        <input type="text" placeholder="비밀번호" />
      </div>
      <div>
        <input type="text" placeholder="비밀번호 확인" />
      </div>
      <Link to="/join/managerdata">
        <button>다음</button>
      </Link>
    </div>
  );
};

export default LoginData;
