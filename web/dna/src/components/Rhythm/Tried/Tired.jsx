import React, { useEffect, useState } from "react";
import styled from "styled-components";
import TiredChart from "./TiredChart";
import { useNavigate } from "react-router-dom";
const Tired = ({ heart }) => {
  const nav = useNavigate();
  const [fatigue, setFatigue] = useState(0);
  const [windowWidth, setWindowWidth] = useState(window.innerWidth);

  useEffect(() => {
    const calFatigue = parseInt(((heart - 60) / 60) * 100);
    if (calFatigue < 0) {
      setFatigue(0);
    } else if (calFatigue > 100) {
      setFatigue(100);
    } else {
      setFatigue(calFatigue);
    }
  }, [heart]);

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
          <img src={`${process.env.PUBLIC_URL}/images/rhythm/status.png`}></img>
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
  @media only screen and (max-width: 600px) {
    cursor: pointer;
  }
`;

// 피로도 div
const FatigueBox = styled.div`
  width: 610px;
  @media only screen and (max-width: 600px) {
    width: 80%;
  }
`;

const Title = styled.h2`
  font-size: 28px;
  color: #212e3d;
  @media only screen and (max-width: 600px) {
    font-size: 23px;
  }
`;

// 상태바
const CircleBack = styled.div`
  width: 100%;
  height: 90px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 30px;

  & img {
    width: 600px;
    position: relative;
    z-index: 1;
  }

  @media only screen and (max-width: 600px) {
    margin-top: -10px;

    & img {
      width: 300px;
    }
  }
`;

// circle을 위한 div(0% or 100% 위치해 있을 때 여백을 주기위한 용도)
const CircleBack2 = styled.div`
  width: 500px;
  position: absolute;
  height: 90px;

  @media only screen and (max-width: 600px) {
    width: 250px;
  }
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

  @media only screen and (max-width: 600px) {
    width: 30px;
    height: 30px;
  }
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
  @media only screen and (max-width: 600px) {
    margin-top: -30px;
    & p {
      font-size: 18px;
      font-weight: bold;
    }
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

  @media only screen and (max-width: 600px) {
    & p {
      font-size: 20px;
      font-weight: bold;
    }

    & img {
      width: 80px;
      height: 80px;
    }
  }
`;
