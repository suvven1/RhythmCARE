import React, { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import styled from "styled-components";
import { useLocation } from "react-router-dom";
import axios from "../../axios";
import Comment from "./Comment";

const BoardDetail = () => {
  const { bd_idx } = useParams();
  const logined_id = JSON.parse(localStorage.getItem("loginData"))?.id;
  const data = useLocation().state;
  const [likecount, setLikeCount] = useState(data.bd_likes);
  const [views, setViews] = useState(data.bd_views);
  const [likeImage, setLikeImage] = useState("likes.png");

  useEffect(() => {
    // 조회수 증가
    axios.post("/board/viewsAdd", { bd_idx: data.bd_idx }).then((res) => {
      if (res.data.viewsAddResult) {
        setViews(res.data.viewsAddResult);
      } else {
        console.log("조회수 증가 실패");
      }
    });

    // 게시글 좋아요 여부 가져오기
    axios
      .post("/board/getIsLiked", { mem_id: logined_id, bd_idx: data.bd_idx })
      .then((res) => {
        if (res.data.getIsLikedResult) {
          setLikeImage("likes2.png");
          setLikeCount(res.data.getIsLikedResult);
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

  // 게시글 좋아요 버튼
  const toggleLike = () => {
    if (logined_id != null) {
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
              console.log("좋아요 삭제 실패!");
            }
          });
      }
    } else {
      alert("로그인 후 이용해 주세요.");
      window.location.replace("/login");
    }
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
      <Comment data={data} logined_id={logined_id} />
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
