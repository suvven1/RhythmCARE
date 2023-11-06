import React, { useState } from "react";
import { VscEdit } from "react-icons/vsc";
import styled from "styled-components";
const Image = () => {
  const [img, setImg] = useState({ pre: "", data: "" });
  const setImage = (e) => {
    if (e.target.files[0]) {
      setImg({
        pre: URL.createObjectURL(e.target.files[0]),
        data: e.target.files[0],
      });
    }
  };
  return (
    <ImageBox>
      <Img>
        {img.pre ? (
          <img src={img.pre} alt="유저사진" />
        ) : (
          <img
            src={`${process.env.PUBLIC_URL}/images/User.png`}
            alt="유저사진"
          />
        )}
      </Img>
      <label for="file">
        <VscEdit />
      </label>
      <input
        type="file"
        id="file"
        accept="image/*"
        onChange={(e) => {
          setImage(e);
        }}
      />
    </ImageBox>
  );
};

export default Image;

const ImageBox = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 40px 0 0 0;

  label {
    position: relative;
    top: -25px;
    right: -40px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    border-radius: 50%;
    border: 3px solid white;
    background-color: #d0d0d0;
    cursor: pointer;
    height: 25px;
    width: 25px;
  }

  & input[type="file"] {
    position: absolute;
    width: 0;
    height: 0;
    padding: 0;
    overflow: hidden;
    border: 0;
  }
`;

const Img = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  width: 150px;
  height: 150px;
  border-radius: 75px;
  border: 1px solid #bdbdbd;
  overflow: hidden;

  & img {
    max-width: 150px;
    max-height: 150px;
  }
`;
