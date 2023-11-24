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
  const [commentLikeImages, setCommentLikeImages] = useState("likes.png");

  const toggleCommentLike = (commentId) => {
    setCommentLikes((prevLikes) => {
      const updatedLikes = { ...prevLikes };

      if (updatedLikes[commentId] === undefined) {
        updatedLikes[commentId] = 0;
      }

      updatedLikes[commentId] += updatedLikes[commentId] === 0 ? 1 : -1;

      return updatedLikes;
    });

    setCommentLikeImages((prevImages) => {
      const updatedImages = { ...prevImages };

      updatedImages[commentId] = updatedImages[commentId] === "likes.png" ? "likes2.png" : "likes.png";

      return updatedImages;
    });
  };

  const postComment = (e) => {
    e.preventDefault();
    console.log(comment);
  };

  const dummyComments = [
    {id: 1, created_at: "23.11.24", mem_id: "콩수니", cmt_content : "무슨 맛이냐하면,,, 우선 꽉 깨물 때 부드럽구,,, 말랑말랑하구,,"},
    {id: 2, created_at: "23.11.24", mem_id: "콩수니", cmt_content : "아카시아 꽃 향기가 나구,,, 참기름 처럼 고소하면서,,(꿀꺽) 그리구,,"}, 
    {id: 3, created_at: "23.11.24", mem_id: "콩수니", cmt_content : "그리구,, (아움꺽) 하늘!!! 땅!!! 하늘 땅 하늘 땅 하늘 땅땅땅땅만큼 맛있어!!!"},
  ]

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
      <CommentBox>
        <h2>댓글</h2>
        <hr/>
      <table>
    <tbody>
    {dummyComments.map((comment) => (
              <React.Fragment key={comment.id}>
                <tr>
                  <td colSpan="3">{comment.created_at}</td>
                </tr>
                <tr>
                  <td className="comment"id="profile" width="100">
                    <div style={{ width: "30px", height: "30px", backgroundColor: "gray", borderRadius: "15px", marginRight: "15px" }}></div>
                    {comment.mem_id}
                  </td>
                  <td className="comment"width="1200px">{comment.cmt_content}</td>
                  <td className="comment"width="100px">
                    <img
                      src={`${process.env.PUBLIC_URL}/images/community/${commentLikes[comment.id] > 0 ? "likes2.png" : "likes.png"}`}
                      onClick={() => toggleCommentLike(comment.id)}
                    />
                    <span>{commentLikes[comment.id] || 0}</span>
                  </td>
                </tr>
                
              </React.Fragment>
      ))}
    </tbody>
  </table>
      </CommentBox>
      <form onSubmit={postComment}>
        <textarea
          placeholder="댓글을 입력해주세요"
          name=""
          id=""
          cols="160"
          rows="4"
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
    padding: 10px;
  }
  & td#profile{
    display: flex;
    align-items: center;
  }

  & textarea {
    /* border: none; */
    font-size: 15px;
    font-family: sans-serif;
    margin-top: 30px;
    padding: 10px;
    resize: none;
  }

  & #putCommentBtn{
    display: block;
    margin: -53px 0 auto auto;
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
  & h2{
    font-size: 20px;
    font-weight: bold;
    padding: 10px;
  }
  & img {
    width: 20px;
    margin-right : 10px;
  }

  & .comment {
    border-bottom: 1px solid #BBBBBB;
  }

`