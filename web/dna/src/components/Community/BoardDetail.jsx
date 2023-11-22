import React, { useState } from "react";
import { Link } from "react-router-dom";
import styled from "styled-components";

const BoardDetail = () => {
  const [comment, setComment] = useState("");
  const postComment = (e) => {
    e.preventDefault();
    console.log(comment);
  };

  return (
    <BoardDetailBox>
      <Link to="/community">
        <button>목록으로</button>
      </Link>
      <hr className="custom-hr"/>
      <table>
        <tbody>
          <tr>
            <th width="1000px">첫번째 게시글</th>
            <th width="150px">최진수</th>
            <th width="150px">23.10.31</th>
            <th width="150px">조회 2</th>
          </tr>
          </tbody>
      </table>
      <hr />
      <div>❤ 2</div>
      <div style={{fontSize:"20px"}}>첫번째 테스트 게시글입니다.</div>
      <hr />
      <div>댓글</div>
      <table>
        <tbody>
          <tr>
            <td width="100px">류하경</td>
            <td width="300px">재밌겠다~</td>
            <td width="100px">23.10.31</td>
          </tr>
        </tbody>
      </table>
      <hr />
      <form onSubmit={postComment}>
        <textarea
          name=""
          id=""
          cols="30"
          rows="10"
          onChange={(e) => {
            setComment(e.target.value);
          }}
        ></textarea>
        <input type="submit" value="댓글달기" />
      </form>
    </BoardDetailBox>
  );
};

export default BoardDetail;

const BoardDetailBox = styled.div`
  margin : 20px 300px 0 300px;

  & .custom-hr {
    border: 1px solid #2e2288;
  }

  & Button{
    margin : 0 0 20px auto;
    padding: 15px 25px;
    border-radius: 10px;
    border: none;
    background-color: #2e2288;
    color: white;
    font-size: 15px;
    cursor: pointer;
    display: block;
    
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