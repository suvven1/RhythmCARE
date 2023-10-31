import React from "react";
import axios from "../../axios";
import { Link, useNavigate } from "react-router-dom";

const Community = () => {
  const nav = useNavigate();
  const searchBoard = (e) => {
    e.preventDefault();
    console.log("search");
  };
  const moveToBoardDetail = () => {
    nav("/boarddetail");
  };
  return (
    <div>
      <form onSubmit={searchBoard}>
        <input type="text" />
        <input type="submit" value="검색" />
        <Link to="/boardwriteform">
          <button>글쓰기</button>
        </Link>
      </form>
      <hr />
      <table>
        <tbody>
          <tr>
            <th width="100px">글번호</th>
            <th width="300px">제목</th>
            <th width="100px">글쓴이</th>
            <th width="100px">날짜</th>
            <th width="100px">공감</th>
            <th width="100px">조회</th>
          </tr>

          <tr onClick={moveToBoardDetail} style={{ cursor: "pointer" }}>
            <th width="100px">01</th>
            <th width="300px">첫번째 게시글</th>
            <th width="100px">최진수</th>
            <th width="100px">23.10.31</th>
            <th width="100px">2</th>
            <th width="100px">2</th>
          </tr>

          {/* {userData.map((data) => {
            return (
              <tr key={num}>
                <td>{num}</td>
                <td>{data.id}</td>
                <td>{data.user_name}</td>
                <td>{data.email}</td>
                <td>{data.email}</td>
                <td>{data.email}</td>
              </tr>
            );
          })} */}
        </tbody>
      </table>
    </div>
  );
};

export default Community;
