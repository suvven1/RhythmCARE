import { Routes, Route } from "react-router-dom";
import Main from "./components/Main/Main";
import Header from "./components/Header/Header";
import Rhythm from "./components/Rhythm/Rhythm";
import Calender from "./components/Calender/Calender";
import Hospital from "./components/Hospital/Hospital";
import Community from "./components/Community/Community";
import Login from "./components/Login/Login";
import Join from "./components/Join/Join";
import MyPage from "./components/MyPage/MyPage";
import BoardWriteForm from "./components/Community/BoardWriteForm";
import BoardDetail from "./components/Community/BoardDetail";
import LoginData from "./components/Join/LoginData";
import ManagerData from "./components/Join/ManagerData";
import UserData from "./components/Join/UserData";
import FindID from "./components/Login/FindID";
import FindPW from "./components/Login/FindPW";

function App() {
  return (
    <div>
      <Header />
      <Routes>
        <Route path="/" element={<Main />}></Route>
        <Route path="/rhythm" element={<Rhythm />}></Route>
        <Route path="/calender" element={<Calender />}></Route>
        <Route path="/hospital" element={<Hospital />}></Route>
        <Route path="/community" element={<Community />}></Route>
        <Route path="/login" element={<Login />}></Route>
        <Route path="/findid" element={<FindID />}></Route>
        <Route path="/findpw" element={<FindPW />}></Route>
        <Route path="/join" element={<Join />}>
          <Route path="/join/logindata" element={<LoginData />}></Route>
          <Route path="/join/managerdata" element={<ManagerData />}></Route>
          <Route path="/join/userdata" element={<UserData />}></Route>
        </Route>
        <Route path="/mypage" element={<MyPage />}></Route>
        <Route path="/boardwriteform" element={<BoardWriteForm />}></Route>
        <Route path="/boarddetail" element={<BoardDetail />}></Route>
      </Routes>
    </div>
  );
}

export default App;
