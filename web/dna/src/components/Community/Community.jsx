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
        <img src={`${process.env.PUBLIC_URL}/images/board/search.png`}/>
        <input 
          className="search_text" 
          type="text"
          placeholder="검색어를 입력해주세요" />
        <input className="search_btn" type="submit" value="검색" />
        <Link to="/boardwriteform">
          <button>글쓰기</button>
        </Link>
      </form>
      <hr className="custom-hr"/>
      <table>
        <tbody>
          <tr>
            <th width="150px">글번호</th>
            <th width="700px">제목</th>
            <th width="150px">글쓴이</th>
            <th width="150px">작성일자</th>
            <th width="150px">공감수</th>
            <th width="150px">조회수</th>
          </tr>
          </tbody>
      </table>
      <hr className="custom-hr"/>
      <table>
        <tbody>
          <tr onClick={moveToBoardDetail} style={{ cursor: "pointer" }}>
            <td width="150px">001</td>
            <td width="700px">첫번째 게시글</td>
            <td width="150px">최진수</td>
            <td width="150px">23.10.31</td>
            <td width="150px">2</td>
            <td width="150px">2</td>
          </tr>
          </tbody>
      </table>
          <hr/>
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
  margin-top: 50px;

  & img {
    width: 20px;
    padding-right: 10px;
  }

  & .search_text {
    width: 200px;
    height: 25px;
    margin-right: 10px;
  }

  & .search_btn {
    padding: 8px 10px;
    border-radius: 5px;
    border: none;
    background-color: #2e2288;
    color: white;
    font-size: 12px;
    cursor: pointer;
  }

  & .custom-hr {
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

  & table {
    width: 100%;
    /* border-collapse: collapse; */
  }

  & th, & td {
    text-align: center;
    padding: 10px;
  }
`