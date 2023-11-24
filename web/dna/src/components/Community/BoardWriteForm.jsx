import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import styled from "styled-components";

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
    <BoardWriteBox>
      <Link to="/community">
        <button>목록으로</button>
      </Link>
      <form onSubmit={uploadBoard}>
      <hr className="custom-hr"/>
        <input
          id="boardtitle"
          type="text"
          placeholder="제목을 입력해주세요"
          onChange={(e) => {
            setTitle(e.target.value);
          }}
        />
        <hr/>
        <textarea
          placeholder="내용을 입력해주세요"
          name=""
          id=""
          cols="140"
          rows="20"
          onChange={(e) => {
            setContent(e.target.value);
          }}
        ></textarea>
        <hr/>
        
        <input id="putBtn" type="submit" value="등록하기" />
      </form>
    </BoardWriteBox>
  );
};

export default BoardWriteForm;

const BoardWriteBox = styled.div`

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

  & #boardtitle {
    margin-top: 20px;
    margin-bottom: 20px;
    border: none;
    font-size: 20px;
    width: 100%;
  }

  & textarea {
    border: none;
    font-size: 20px;
    font-family: sans-serif;
    resize: none;
  }

  & #putBtn{
    margin: 20px auto 0 auto;
    padding: 15px 25px;
    border-radius: 10px;
    border: none;
    background-color: #2e2288;
    color: white;
    font-size: 15px;
    cursor: pointer;
    display: block;
  }
`