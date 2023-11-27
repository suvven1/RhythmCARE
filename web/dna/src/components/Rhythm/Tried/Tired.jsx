import React, { useEffect, useState } from "react";
import styled from "styled-components";
import TiredChart from "./TiredChart";
import { useNavigate } from "react-router-dom";
const Tired = () => {
  const nav = useNavigate();
  var fatigue = 50;
  const [windowWidth, setWindowWidth] = useState(window.innerWidth);

  // 화면 크기 감지
  const handelResize = () => {
    setWindowWidth(window.innerWidth);
  };

  useEffect(() => {
    window.addEventListener("resize", handelResize);
    return () => {
      window.removeEventListener("resize", handelResize);
    };
  }, []);

  const showChart = () => {
    if (windowWidth < 1300) {
      nav("/tiredChart");
    }
  };
  return (
    <FatigueBox>
      <NowStatus onClick={showChart}>
        <Title>현재 피로도 지수</Title>
        <CircleBack>
          <CircleBack2>
            <Circle
              style={{
                left: `${fatigue}%`,
              }}
            />
          </CircleBack2>
        </CircleBack>
        <RowHighText>
          <p className="row">낮음</p>
          <p className="high">높음</p>
        </RowHighText>
        <NowStatusText>
          <p>
            현재 피로도는 <br />
            <span>{fatigue > 60 ? "높은" : "낮은"}</span> 상태 입니다
          </p>
          <img
            src={
              process.env.PUBLIC_URL +
              `/images/rhythm/${
                fatigue > 60 ? "bad_status.png" : "nice_status.png"
              }`
            }
          />
        </NowStatusText>
      </NowStatus>
      {windowWidth < 1300 ? <></> : <TiredChart />}
    </FatigueBox>
  );
};

export default Tired;

const NowStatus = styled.div`
  @media only screen and (max-width: 1300px) {
    cursor: pointer;
  }
`;

// 피로도 div
const FatigueBox = styled.div`
  width: 50%;
  margin-right: 300px;
  @media only screen and (max-width: 1300px) {
    width: 80%;
    margin-right: 0px;
  }
`;

const Title = styled.h2`
  font-size: 28px;
  color: #212e3d;
`;

// 상태바
const CircleBack = styled.div`
  width: 100%;
  height: 90px;
  background-image: url("${process.env.PUBLIC_URL}/images/rhythm/status.png");
  background-size: cover;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 30px;
`;

// circle을 위한 div(0% or 100% 위치해 있을 때 여백을 주기위한 용도)
const CircleBack2 = styled.div`
  width: 80%;
  height: 90px;
  position: relative;
`;

const Circle = styled.div`
  width: 60px;
  height: 60px;
  background-color: white;
  border-radius: 50%;
  position: absolute;
  z-index: 3;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
`;

const RowHighText = styled.div`
  display: flex;
  justify-content: space-between;
  margin-top: -10px;

  & p {
    font-size: 20px;
    font-weight: bold;
  }

  & .row {
    color: #4bb56d;
  }

  & .high {
    color: #da4b3c;
  }
`;

// 현재 상태
const NowStatusText = styled.div`
  display: flex;
  justify-content: space-between;
  margin-top: 5px;
  padding-bottom: 50px;

  & p {
    font-size: 22px;
    font-weight: bold;
    color: #212e3d;

    & span {
      color: #ec7271;
    }
  }

  & img {
    width: 100px;
    height: 100px;
  }
`;
