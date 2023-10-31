import "./App.css";
import { Routes, Route } from "react-router-dom";
import Main from "./components/Main/Main";
import Header from "./components/Header";
import Rhythm from "./components/Rhythm/Rhythm";
import Calender from "./components/Calender/Calender";
import Hospital from "./components/Hospital/Hospital";
import Community from "./components/Community/Community";
import Login from "./components/Login/Login";
import Join from "./components/Join/Join";
import MyPage from "./components/MyPage/MyPage";

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
        <Route path="/join" element={<Join />}></Route>
        <Route path="/join" element={<MyPage />}></Route>
      </Routes>
    </div>
  );
}

export default App;
