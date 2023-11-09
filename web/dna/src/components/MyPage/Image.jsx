import React, { useContext, useEffect, useState } from "react";
import axios from "../../axios";
import { UserContext } from "../../context/UserContext";
import imageCompression from "browser-image-compression";

import { VscEdit } from "react-icons/vsc";
import styled from "styled-components";

const Image = () => {
  // 유저 전체 정보
  const userData = useContext(UserContext);

  // 이미지 변환시 바로 표시하는 기능
  const [img, setImg] = useState({ pre: "", data: "" });
  const setImage = async (e) => {
    if (e.target.files[0]) {
      const options = {
        maxSizeMB: 0.05, // 이미지 최대 용량
        maxWidthOrHeight: 500, // 최대 넓이(혹은 높이)
        useWebWorker: true,
      };
      try {
        let compFile = await imageCompression(e.target.files[0], options);
        setImg({
          pre: URL.createObjectURL(compFile),
          data: compFile,
        });
      } catch (error) {
        console.log(error);
      }
    }
  };

  // 이미지 변환시 데이터 베이스/로컬스토리지에 이미지 저장
  const sendImg = () => {
    let formData = new FormData();
    formData.append("image", img.data);
    formData.append("id", userData.data.manager_id);
    axios
      .post("/user/changeImg", formData, {
        headers: {
          "Content-Type": "multipart/form-data",
        },
      })
      .then((res) => {
        if (res.data.chageImgResult) {
          userData.data.img = res.data.img;
          localStorage.setItem("userData", JSON.stringify(userData));
          alert("이미지 변경이 완료되었습니다.");
          window.location.replace("/mypage");
        } else {
          alert("이미지 변경이 실패하였습니다.");
          window.location.replace("/mypage");
        }
      });
  };

  // 이미지 선택을 새로 하는 경우 이미지 저장 함수 실행
  useEffect(() => {
    if (img.data != "") {
      sendImg();
    }
  }, [img]);

  // 로컬 스토리지에서 불러온 이미지 데이터 변환
  let conImg = "";
  if (userData != null) {
    conImg = btoa(
      String.fromCharCode(...new Uint8Array(userData.data.img.data))
    );
  }

  return (
    <ImageBox>
      <Img>
        {img.pre ? (
          <img src={img.pre} alt="새로 등록할 유저사진" />
        ) : (
          <>
            {userData.data.img != null ? (
              <img src={`data:image/png;base64,${conImg}`} alt="유저사진" />
            ) : (
              <img
                src={`${process.env.PUBLIC_URL}/images/User.png`}
                alt="기본 유저사진"
              />
            )}
          </>
        )}
      </Img>
      <label htmlFor="file">
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
  margin: 60px 0 0 0;

  label {
    position: relative;
    top: -30px;
    right: -50px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    border-radius: 50%;
    border: 4px solid white;
    background-color: #d0d0d0;
    cursor: pointer;
    height: 30px;
    width: 30px;
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
  width: 225px;
  height: 225px;
  border-radius: 50%;
  border: 1px solid #bdbdbd;
  overflow: hidden;

  & img {
    max-width: 260px;
    max-height: 260px;
  }
`;
