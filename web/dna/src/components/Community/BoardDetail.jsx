import React, { useState } from "react";
import { Link, useParams } from "react-router-dom";
import styled from "styled-components";

const BoardDetail = () => {
  const { bd_idx } = useParams();

  const [likecount, setLikeCount] = useState(0);
  const [likeImage, setLikeImage] = useState("likes.png");

  // 게시글 좋아요 버튼
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

  // 댓글별 좋아요 버튼
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
    { id: 1, created_at: "23.11.24", mem_id: "콩수니", cmt_content: "무슨 맛이냐하면,,, 우선 꽉 깨물 때 부드럽구,,, 말랑말랑하구,," },
    { id: 2, created_at: "23.11.24", mem_id: "콩수니", cmt_content: "아카시아 꽃 향기가 나구,,, 참기름 처럼 고소하면서,,(꿀꺽) 그리구,," },
    { id: 3, created_at: "23.11.24", mem_id: "콩수니", cmt_content: "그리구,, (아움꺽) 하늘!!! 땅!!! 하늘 땅 하늘 땅 하늘 땅땅땅땅만큼 맛있어!!!" },
  ]

  return (
    <BoardDetailBox>
      <Link to="/community">
        <button>목록으로</button>
      </Link>
      <hr className="custom-hr" />
      <TableHeader>
        <div id="header_title">첫번째 게시글</div>
        <div id="header_writer">최진수</div>
        <div id="header_date">23.10.31</div>
        <div id="header_view">조회 2</div>
      </TableHeader>
      <hr />
      <ContentBox>
        <div>첫번째 테스트 게시글입니다.</div>
        <img src={`${process.env.PUBLIC_URL}/images/community/${likeImage}`}
          onClick={toggleLike} />
        <p>{likecount}</p>
      </ContentBox>
      <CommentBox>
        <h2>댓글</h2>
        <hr />
            {dummyComments.map((comment) => (
              <React.Fragment key={comment.id}>
                <div id="comment_date">{comment.created_at}</div>
                <Comment>
                  <div id="userProfile" >
                    <img src={`${process.env.PUBLIC_URL}/images/community/likes.png`}/>
                    <div>{comment.mem_id}</div>
                  </div>
                  <div id="comment_content">{comment.cmt_content}</div>
                  <div id="comment_like"style={{width:"100px"}}>
                    <img
                      src={`${process.env.PUBLIC_URL}/images/community/${
                        commentLikeImages[comment.id] === "likes.png" ? "likes2.png" : "likes.png"
                      }`}
                      onClick={() => toggleCommentLike(comment.id)}
                    />
                    <span>{commentLikes[comment.id] || 0}</span>
                  </div>
                </Comment>
                <hr />
              </React.Fragment>
            ))}
      </CommentBox>
      <AddComment>
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
      </AddComment>
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

  @media only screen and (max-width: 1040px){
    margin: 20px 50px 0 50px;

    & Button {
      padding: 8px 10px;
    border-radius: 5px;
    border: none;
    background-color: #2e2288;
    color: white;
    font-size: 12px;
    cursor: pointer;
    text-decoration: none;
    }

    & textarea {
      width: 100%;
    }
    & #putCommentBtn{
      padding: 8px 10px;
      border-radius: 5px;
      border: none;
      background-color: #2e2288;
      color: white;
      font-size: 12px;
      cursor: pointer;
      text-decoration: none;
      margin: auto;
    }
  }
`

const TableHeader = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  text-align: center;
  font-weight: bold;
  padding: 10px 0 10px 0;

  & #header_title{
    width: 80%;
    text-align: left;
    padding-left: 10px;
  }

  & div{
    width: 150px;
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
  width: 100%;
  & h2{
    font-size: 20px;
    font-weight: bold;
    padding: 10px;
  }
  & img {
    width: 20px;
    margin-right : 10px;
  }
  & #comment_date{
    padding-left: 10px;
  }

`

const Comment = styled.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px;
  text-align: center;
  width: 100%;
  

  & #userProfile{
    display: flex;
    align-items: center;
    width: 10%;
    
  
    & img {
      width: 30px;
      height: 30px;
      border-radius: 15px;
    }
  }

  & #comment_content {
    width: 80%;
    text-align: left;
    order: 1;
  }

  & #comment_like{
    width: 10%;
    order: 2;
  }

  @media only screen and (max-width: 1040px){
    flex-direction: column;
    & #userProfile{
      width: 100%;
      margin-bottom: 20px;
      order: 1;
    }
    
    & #comment_content{
      width: 100%;
      order: 2;
    }
    
    & #comment_like {
      width: 100%; 
      margin-top: -45px;
      margin-bottom: 20px;
      align-self: self-end;
      order: 1;
    }
  }
`
const AddComment = styled.div`
  & form {
    display: flex;
    align-items: end;
    justify-content: space-between;
    margin-bottom: 20px;
  }

  & textarea {
    /* border: none; */
    font-size: 15px;
    font-family: sans-serif;
    margin-top: 30px;
    margin-right: 20px;
    padding: 10px;
    resize: none;
  }

  & #putCommentBtn{
    padding: 15px 25px;
    border-radius: 10px;
    border: none;
    background-color: #2e2288;
    color: white;
    font-size: 15px;
    cursor: pointer;
  }
  @media only screen and (max-width: 1040px){
    & form{
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }
    & textarea {
      width: 90%;
      margin-right: 0px;
    }
    & #putCommentBtn{
      padding: 8px 10px;
      border-radius: 5px;
      border: none;
      background-color: #2e2288;
      color: white;
      font-size: 12px;
      cursor: pointer;
      text-decoration: none;
      margin: 10px 0 10px 0;
    }
  }
`