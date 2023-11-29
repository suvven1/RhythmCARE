import React, { useEffect, useState } from "react";
import styled from "styled-components";
import axios from "../../axios";
const Comment = ({ data, logined_id }) => {
  const [comment, setComment] = useState("");
  const [commentList, setCommentList] = useState([]);

  // 댓글별 좋아요 버튼
  const toggleCommentLike = (index, cmt_idx) => {
    if (logined_id != null) {
      const updatedComments = [...commentList];

      // 좋아요 상태를 토글하고 댓글 수를 업데이트합니다.
      if (updatedComments[index].likes_img === "likes.png") {
        updatedComments[index].likes_img = "likes2.png";
        updatedComments[index].cmt_likes += 1;
        updateLikes("cmtLikesAdd", cmt_idx);
      } else {
        updatedComments[index].likes_img = "likes.png";
        updatedComments[index].cmt_likes -= 1;
        updateLikes("cmtLikesPop", cmt_idx);
      }

      // 수정된 commentList로 상태를 업데이트합니다.
      setCommentList(updatedComments);
    } else {
      alert("로그인 후 이용해 주세요.");
      window.location.replace("/login");
    }
  };

  // 댓글 좋아요 수정
  const updateLikes = (router, cmt_idx) => {
    axios
      .post(`/comment/${router}`, { mem_id: logined_id, cmt_idx: cmt_idx })
      .then((res) => {
        if (!res.data.result) {
          console.log("좋아요 추가/삭제 실패!");
        }
      });
  };

  // 댓글 업로드
  const postComment = (e) => {
    e.preventDefault();
    if (logined_id != null) {
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
    } else {
      alert("로그인 후 이용해 주세요.");
      window.location.replace("/login");
    }
  };
  useEffect(() => {
    // 댓글 불러오기
    axios.post("/comment/getComment", { bd_idx: data.bd_idx }).then((res) => {
      if (res.data.commentData) {
        res.data.commentData.map((comment) => {
          comment.created_at = comment.created_at.split("T")[0];
          comment.mem_profile_img = btoa(
            String.fromCharCode(
              ...new Uint8Array(comment.mem_profile_img?.data)
            )
          );

          // 댓글 좋아요 여부 가져오기
          axios
            .post("/comment/getIscmtLiked", {
              mem_id: logined_id,
              cmt_idx: comment.cmt_idx,
            })
            .then((res) => {
              if (res.data.getIsLikedResult) {
                comment.likes_img = "likes2.png";
              } else {
                comment.likes_img = "likes.png";
              }
            });

          setCommentList((prev) => [...prev, comment]);
        });
      }
    });
  }, []);
  return (
    <div>
      <CommentBox>
        <h2>댓글</h2>
        <hr />
        {commentList.map((comment, index) => {
          return (
            <React.Fragment key={comment.cmt_idx}>
              <div id="comment_date">{comment.created_at}</div>
              <Comments>
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
                <div
                  id="comment_like"
                  style={{ width: "100px", cursor: "pointer" }}
                  onClick={() => toggleCommentLike(index, comment.cmt_idx)}
                >
                  <img
                    src={`${process.env.PUBLIC_URL}/images/community/${comment.likes_img}`}
                  />
                  <span>{comment.cmt_likes}</span>
                </div>
              </Comments>
              <hr />
            </React.Fragment>
          );
        })}
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
    </div>
  );
};

export default Comment;

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

const Comments = styled.div`
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
