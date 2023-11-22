import React from "react";
import axios from "../../axios";
import { Link, useNavigate } from "react-router-dom";
import styled from "styled-components";

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
    <CommunityBox>
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
            <th width="150px">글번호</th>
            <th width="700px">제목</th>
            <th width="150px">글쓴이</th>
            <th width="150px">날짜</th>
            <th width="150px">공감</th>
            <th width="150px">조회</th>
          </tr>
          </tbody>
      </table>
      <hr/>
      <table>
        <tbody>
          <tr onClick={moveToBoardDetail} style={{ cursor: "pointer" }}>
            <th width="150px">001</th>
            <th width="700px">첫번째 게시글</th>
            <th width="150px">최진수</th>
            <th width="150px">23.10.31</th>
            <th width="150px">2</th>
            <th width="150px">2</th>
          </tr>
          </tbody>
      </table>
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
    </CommunityBox>
  );
};

export default Community;

const CommunityBox = styled.div`
  margin-left: 300px;
  margin-right: 300px;

  & hr {
    border: 1px solid #2e2288;
  }

  & Button{
    position: fixed;
    bottom: 50px;
    right: 300px;
    padding: 15px 30px;
    border-radius: 20px;
    border: none;
    background-color: #2e2288;
    color: white;
    font-size: 20px;
    cursor: pointer;
  }
`