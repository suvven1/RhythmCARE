import React, { useState } from "react";
import { Link, useParams } from "react-router-dom";
import styled from "styled-components";

const BoardDetail = () => {
  const {bd_idx} = useParams();
  

  const [likecount, setLikeCount] = useState(0);
  const [likeImage, setLikeImage] = useState("likes.png");

  const toggleLike = () => {
    if (likeImage === "likes.png") {
      setLikeCount((prevCount) => prevCount + 1);
      setLikeImage("likes2.png");
    } else {
      setLikeCount((prevCount) => prevCount - 1);
      setLikeImage("likes.png");
    }
  };

  const [comment, setComment] = useState("");
  const [commentLikes, setCommentLikes] = useState(0);
  const [commentLikeImage, setCommentLikeImage] = useState("likes.png");

  const toggleCommentLike = () => {
    if (commentLikeImage === "likes.png") {
      setCommentLikes((prevCount) => prevCount + 1);
      setCommentLikeImage("likes2.png");
    } else {
      setCommentLikes((prevCount) => prevCount - 1);
      setCommentLikeImage("likes.png");
    }
  };

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
            <th width="1000px" style={{textAlign:'left'}}>첫번째 게시글</th>
            <th width="150px">최진수</th>
            <th width="150px">23.10.31</th>
            <th width="150px">조회 2</th>
          </tr>
          </tbody>
      </table>
      <hr />
      <ContentBox>
        <div>첫번째 테스트 게시글입니다.</div>
        <img src={`${process.env.PUBLIC_URL}/images/community/${likeImage}`}
          onClick={toggleLike} />
        <p>{likecount}</p>
      </ContentBox>
      <hr />
      <CommentBox>
        <table>
          <tbody>
            <tr>
              <td width="100px">류하경</td>
              <td width="300px">재밌겠다~</td>
              <td width="100px">
              <img
                  src={`${process.env.PUBLIC_URL}/images/community/${commentLikeImage}`}
                  onClick={toggleCommentLike}
                />
                <span>{commentLikes}</span>
              </td>
              <td width="100px">23.10.31</td>
            </tr>
          </tbody>
        </table>
      </CommentBox>
      <form onSubmit={postComment}>
        <textarea
          placeholder="댓글을 입력해주세요"
          name=""
          id=""
          cols="160"
          rows="5"
          onChange={(e) => {
            setComment(e.target.value);
          }}
        ></textarea>
        <input id="putCommentBtn" type="submit" value="댓글달기" />
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

  & button{
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

  & textarea {
    /* border: none; */
    font-size: 15px;
    font-family: sans-serif;
    margin-top: 10px;
    padding: 10px;
  }

  & #putCommentBtn{
    display: block;
    margin: 0 0 auto auto;
    padding: 15px 25px;
    border-radius: 10px;
    border: none;
    background-color: #2e2288;
    color: white;
    font-size: 15px;
    cursor: pointer;
  }
`
const ContentBox = styled.div`
  width: 100%;
  height: 400px;
  padding: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;

  & div {
    align-self: flex-start;
    height: 80%;
  }
  & img {
    width: 50px;
    cursor: pointer;
  }
  & p {
    color: #bcbbbb;
    margin-top: 5px;
    font-size: 20px;
  }
`

const CommentBox = styled.div`
  

  & img {
    width: 20px;
    margin-right : 10px;
  }

`