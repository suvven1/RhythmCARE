import React from "react";
import { Link } from "react-router-dom";
const ManagerData = () => {
  return (
    <div>
      <div>보호자 정보 입력</div>
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
      <Link to="/join/logindata">
        <button>이전</button>
      </Link>
      <Link to="/join/userdata">
        <button>다음</button>
      </Link>
    </div>
  );
};

export default ManagerData;
