import { Routes, Route, useLocation } from "react-router-dom";
import { useEffect, useState } from "react";
import { UserContext } from "./context/UserContext";
import axios from "./axios";

// 화면 페이지 import
import Main from "./components/Main/Main";
import Header from "./components/Header/Header";
import Rhythm from "./components/Rhythm/Rhythm";
import Calender from "./components/Calender/Calender";
import Hospital from "./components/Hospital/Hospital";
import Hospitalapp from "./components/Hospital/Hospitalapp";
import Community from "./components/Community/Community";
import Login from "./components/Login/Login";
import Join from "./components/Join/Join";
import MyPage from "./components/MyPage/MyPage";
import BoardWriteForm from "./components/Community/BoardWriteForm";
import BoardDetail from "./components/Community/BoardDetail";
import LoginData from "./components/Join/LoginData";
import UserData from "./components/Join/UserData";
import FindIdPw from "./components/Login/FindIdPw";

function App() {
  const getUserData = JSON.parse(localStorage.getItem("userData"));
  const [userData, setUserData] = useState(getUserData);
<<<<<<< HEAD
  console.log(userData);

  // AppWebView Header 삭제
  const location = useLocation();
  const logoView = !(location.pathname === '/hospitalapp')
=======
  useEffect(() => {
    console.log(userData);
  }, [userData]);
>>>>>>> a7eb266da60b6407174ab98959edacac81c179bc

  return (
    <div>
      <UserContext.Provider value={userData}>
        {logoView && <Header />}
        <Routes>
          <Route path="/" element={<Main />}></Route>
          <Route path="/rhythm" element={<Rhythm />}></Route>
          <Route path="/calender" element={<Calender />}></Route>
          <Route path="/hospital" element={<Hospital />}></Route>
          <Route path="/hospitalapp" element={<Hospitalapp />}></Route>
          <Route path="/community" element={<Community />}></Route>
          <Route path="/login" element={<Login />}></Route>
          <Route path="/findidpw" element={<FindIdPw />}></Route>
          <Route path="/join" element={<Join />}>
            <Route path="/join/logindata" element={<LoginData />}></Route>
            <Route path="/join/userdata" element={<UserData />}></Route>
          </Route>
          <Route path="/mypage" element={<MyPage />}></Route>
          <Route path="/boardwriteform" element={<BoardWriteForm />}></Route>
          <Route path="/boarddetail" element={<BoardDetail />}></Route>
        </Routes>
      </UserContext.Provider>
    </div>
  );
}

export default App;
