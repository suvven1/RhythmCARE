import React from "react";
import { Link } from "react-router-dom";
const UserData = () => {
  return (
    <div>
      <div>사용자 정보 입력</div>
      <div>
        <input type="text" placeholder="이름" />
      </div>
      <div>
        <input type="text" placeholder="생년월일 8자리" />
      </div>
      <div>
        <input type="text" placeholder="성별" />
      </div>
      <div>
        <input type="text" placeholder="휴대폰번호" />
      </div>
      <Link to="/join/managerdata">
        <button>이전</button>
      </Link>
      <Link to="/login">
        <button>회원가입 완료</button>
      </Link>
    </div>
  );
};

export default UserData;
