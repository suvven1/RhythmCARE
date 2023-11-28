import React, { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import styled from "styled-components";
import { useLocation } from "react-router-dom";
import axios from "../../axios";

const BoardDetail = () => {
  const { bd_idx } = useParams();
  const logined_id = JSON.parse(localStorage.getItem("loginData")).id;
  const data = useLocation().state;
  const [likecount, setLikeCount] = useState(data.bd_likes);
  const [views, setViews] = useState(data.bd_views);
  const [likeImage, setLikeImage] = useState("likes.png");

  // 조회수 증가
  useEffect(() => {
    axios.post("/board/viewsAdd", { bd_idx: data.bd_idx }).then((res) => {
      if (res.data.viewsAddResult) {
        setViews(res.data.viewsAddResult);
      } else {
        console.log("조회수 증가 실패");
      }
    });
  }, []);

  // 게시글 삭제
  const deleteBord = () => {
    axios
      .post("/board/deleteBoard", { id: data.mem_id, bd_idx: data.bd_idx })
      .then((res) => {
        if (res.data.deleteBoardResult) {
          alert("삭제가 완료되었습니다.");
          window.location.replace("/community");
        } else {
          alert("[NetWork ERROR] 삭제에 실패하였습니다.");
        }
      });
  };

  // 게시글 좋아요 여부 가져오기
  useEffect(() => {
    axios
      .post("/board/getIsLiked", { mem_id: logined_id, bd_idx: data.bd_idx })
      .then((res) => {
        if (res.data.getIsLikedResult) {
          setLikeImage("likes2.png");
          setLikeCount(res.data.getIsLikedResult);
        }
      });
  }, []);

  // 게시글 좋아요 버튼
  const toggleLike = () => {
    if (likeImage === "likes.png") {
      setLikeCount((prevCount) => prevCount + 1);
      setLikeImage("likes2.png");
      axios
        .post("/board/likesAdd", { mem_id: logined_id, bd_idx: data.bd_idx })
        .then((res) => {
          if (!res.data.likesAddResult) {
            console.log("좋아요 추가 실패!");
          }
        });
    } else {
      setLikeCount((prevCount) => prevCount - 1);
      setLikeImage("likes.png");
      axios
        .post("/board/likesPop", { mem_id: logined_id, bd_idx: data.bd_idx })
        .then((res) => {
          if (!res.data.likesPopResult) {
            console.log("좋아요 추가 성공!");
          }
        });
    }
  };

  const [comment, setComment] = useState("");
  const [commentList, setCommentList] = useState([]);
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

      updatedImages[commentId] =
        updatedImages[commentId] === "likes.png" ? "likes2.png" : "likes.png";

      return updatedImages;
    });
  };

  // 댓글 불러오기
  useEffect(() => {
    axios.post("/comment/getComment", { bd_idx: data.bd_idx }).then((res) => {
      if (res.data.commentData) {
        res.data.commentData.map((comment) => {
          comment.created_at = comment.created_at.split("T")[0];
          comment.mem_profile_img = btoa(
            String.fromCharCode(
              ...new Uint8Array(comment.mem_profile_img?.data)
            )
          );
          setCommentList((prev) => [...prev, comment]);
        });
      }
    });
  }, []);

  const postComment = (e) => {
    e.preventDefault();
    axios
      .post("/comment/uploadComment", {
        bd_idx: data.bd_idx,
        cmt_content: comment,
        mem_id: logined_id,
      })
      .then((res) => {
        if (res.data.uploadCommentResult) {
          alert("댓글 작성이 완료되었습니다.");
          window.location.replace(`/boarddetail/${data.bd_idx}`);
        } else {
          alert("[Network ERROR] 댓글 작성에 실패 하였습니다.");
        }
      });
  };

  return (
    <BoardDetailBox>
      <div className="btnBox">
        {logined_id == data.mem_id ? (
          <button className="delete" onClick={deleteBord}>
            삭제
          </button>
        ) : (
          <></>
        )}
        <Link to="/community">
          <button className="list">목록으로</button>
        </Link>
      </div>
      <hr className="custom-hr" />
      <TableHeader>
        <div className="titleBox">
          <div id="header_title">{data.bd_title}</div>
          <div id="header_writer">{data.mem_nick}</div>
        </div>
        <div className="dateBox">
          <div id="header_date">{data.created_at}</div>
          <div id="header_view">조회 {views}</div>
        </div>
      </TableHeader>
      <hr />
      <ContentBox>
        <div>{data.bd_content}</div>
        <img
          src={`${process.env.PUBLIC_URL}/images/community/${likeImage}`}
          onClick={toggleLike}
        />
        <p>{likecount}</p>
      </ContentBox>
      <CommentBox>
        <h2>댓글</h2>
        <hr />
        {commentList.map((comment) => (
          <React.Fragment key={comment.cmt_idx}>
            <div id="comment_date">{comment.created_at}</div>
            <Comment>
              <div id="userProfile">
                {comment.mem_profile_img != "" ? (
                  <img
                    src={`data:image/png;base64,${comment.mem_profile_img}`}
                    alt="유저사진"
                  />
                ) : (
                  <img
                    src={`${process.env.PUBLIC_URL}/images/User.png`}
                    alt="기본 유저사진"
                  />
                )}
                <div>{comment.mem_nick}</div>
              </div>
              <div id="comment_content">{comment.cmt_content}</div>
              <div id="comment_like" style={{ width: "100px" }}>
                <img
                  src={`${process.env.PUBLIC_URL}/images/community/${
                    commentLikeImages[comment.id] === "likes.png"
                      ? "likes2.png"
                      : "likes.png"
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
  margin: 20px 300px 0 300px;

  & .custom-hr {
    border: 1px solid #2e2288;
  }

  & .btnBox {
    display: flex;
    justify-content: end;
    gap: 10px;
  }

  & .delete {
    background-color: #e05151;
  }

  & .list {
    background-color: #2e2288;
  }

  & button {
    margin: 0 0 20px auto;
    padding: 15px 25px;
    border-radius: 10px;
    border: none;
    color: white;
    font-size: 15px;
    cursor: pointer;
    display: block;
  }

  @media only screen and (max-width: 1040px) {
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
    & #putCommentBtn {
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
`;

const TableHeader = styled.div`
  display: flex;
  /* justify-content: space-between; */
  align-items: center;
  text-align: center;
  font-weight: bold;
  padding: 10px 0 10px 0;

  & .titleBox {
    display: flex;
    justify-content: space-between;
    width: 80%;
  }

  & .dateBox {
    display: flex;
    justify-content: center;
    width: 20%;
    gap: 10px;
  }

  & #header_title {
    width: 80%;
    text-align: left;
    padding-left: 10px;
  }

  & div {
    /* width: 150px; */
  }
  @media only screen and (max-width: 1040px) {
    flex-direction: column;
    gap: 10px;
    & #header_title {
      width: 60%;
    }

    & .titleBox {
      width: 100%;
    }

    & .dateBox {
      width: 100%;
      justify-content: end;
    }
  }
`;

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
`;

const CommentBox = styled.div`
  width: 100%;
  & h2 {
    font-size: 20px;
    font-weight: bold;
    padding: 10px;
  }
  & img {
    width: 20px;
    margin-right: 10px;
  }
  & #comment_date {
    padding-left: 10px;
  }
`;

const Comment = styled.div`
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px;
  text-align: center;
  width: 100%;

  & #userProfile {
    display: flex;
    align-items: center;
    width: 180px;

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

  & #comment_like {
    width: 10%;
    order: 2;
  }

  @media only screen and (max-width: 1040px) {
    flex-direction: column;
    & #userProfile {
      width: 100%;
      margin-bottom: 20px;
      order: 1;
    }

    & #comment_content {
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
`;
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

  & #putCommentBtn {
    padding: 15px 25px;
    border-radius: 10px;
    border: none;
    background-color: #2e2288;
    color: white;
    font-size: 15px;
    cursor: pointer;
  }
  @media only screen and (max-width: 1040px) {
    & form {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
    }
    & textarea {
      width: 90%;
      margin-right: 0px;
    }
    & #putCommentBtn {
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
`;
