import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";

const BoardWriteForm = () => {
  const nav = useNavigate();
  const [title, setTitle] = useState("");
  const [content, setContent] = useState("");
  const [file, setFile] = useState("");

  const uploadBoard = (e) => {
    e.preventDefault();
    console.log("upload board");
    console.log(title);
    console.log(content);
    console.log(file);
    nav("/community");
  };

  return (
    <div>
      <Link to="/community">
        <button>목록으로</button>
      </Link>
      <hr />
      <form onSubmit={uploadBoard}>
        <div>제목</div>
        <input
          type="text"
          onChange={(e) => {
            setTitle(e.target.value);
          }}
        />
        <br />
        <br />
        <div>내용</div>
        <textarea
          name=""
          id=""
          cols="30"
          rows="10"
          onChange={(e) => {
            setContent(e.target.value);
          }}
        ></textarea>
        <br />
        <br />
        <div>파일 첨부하기</div>
        <input
          type="file"
          onChange={(e) => {
            setFile(e.target.value);
          }}
        />
        <br />
        <br />
        <input type="submit" value="등록하기" />
      </form>
    </div>
  );
};

export default BoardWriteForm;
