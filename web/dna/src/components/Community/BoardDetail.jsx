import React, { useState } from "react";
import { Link } from "react-router-dom";

const BoardDetail = () => {
  const [comment, setComment] = useState("");
  const postComment = (e) => {
    e.preventDefault();
    console.log(comment);
  };

  return (
    <div>
      <input type="button" value="<이전글" />
      <input type="button" value="다음글>" />
      <hr />
      <span>첫번째 게시글</span>
      <span>최진수</span>
      <span>23.10.31</span>
      <span>조회 2</span>
      <hr />
      <div>❤ 2</div>
      <div>첫번째 테스트 게시글입니다.</div>
      <hr />
      <div>댓글</div>
      <table>
        <tbody>
          <tr>
            <th width="100px">류하경</th>
            <th width="300px">재밌겠다~</th>
            <th width="100px">23.10.31</th>
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
      <Link to="/community">
        <button>목록으로</button>
      </Link>
    </div>
  );
};

export default BoardDetail;
