import React from "react";
import styled from "styled-components";
import { Link } from "react-scroll";
import { useNavigate } from "react-router-dom";
import Login from "../Login/Login";

const Main = () => {
  const navigate = useNavigate();

  const start_service = () => {
    navigate("/Login");
  };

  return (
    <MainBox>
      <SloganBack>
        <p>
          리듬 속 건강
          <br />
          당신의 건강한 리듬을
          <br />
          위한 최고의 파트너
        </p>
        <SloganImage />
      </SloganBack>

      <ServiceBack>
        <span>서비스</span>
      </ServiceBack>
      <ServiceCard_back>
        <div className="serviceCard_inner_box">
          <ServiceCard>
            <div
              style={{
                backgroundImage: `URL(${process.env.PUBLIC_URL}/images/main/service_card1.png)`,
                backgroundSize: "cover",
              }}
            />
            <p>
              건강데이터
              <br />
              확인하기
            </p>
            <p className="service_ex">
              wearable기기로 <br /> 측정한 데이터 확인
            </p>
            <Link to="service_detail1" spy={true} smooth={true}>
              자세히보기 ▷
            </Link>
          </ServiceCard>
          <ServiceCard>
            <div
              style={{
                backgroundImage: `URL(${process.env.PUBLIC_URL}/images/main/service_card2.png)`,
                backgroundSize: "cover",
              }}
            />
            <p>
              일정
              <br />
              관리하기
            </p>
            <p className="service_ex">
              나만의 일정을 <br /> 편리하게 관리하기
            </p>
            <Link to="service_detail2" spy={true} smooth={true}>
              자세히보기 ▷
            </Link>
          </ServiceCard>
          <ServiceCard>
            <div
              style={{
                backgroundImage: `URL(${process.env.PUBLIC_URL}/images/main/service_card3.png)`,
                backgroundSize: "cover",
              }}
            />
            <p>
              내주변
              <br />
              병원정보
            </p>
            <p className="service_ex">
              현재 위치에서 <br /> 가까운 병원찾기
            </p>
            <Link to="service_detail3" spy={true} smooth={true}>
              자세히보기 ▷
            </Link>
          </ServiceCard>
          <ServiceCard>
            <div
              style={{
                backgroundImage: `URL(${process.env.PUBLIC_URL}/images/main/service_card4.png)`,
                backgroundSize: "cover",
              }}
            />
            <p>
              건강관련
              <br />
              정보보기
            </p>
            <p className="service_ex">
              건강과 관련된 <br /> 유용한 정보 얻기
            </p>
            <Link to="service_detail4" spy={true} smooth={true}>
              자세히보기 ▷
            </Link>
          </ServiceCard>
        </div>
      </ServiceCard_back>

      <Detail_back>
        <Detail_left id="service_detail1">
          <div
            className="card"
            style={{
              backgroundImage: `URL(${process.env.PUBLIC_URL}/images/main/detail_card1.png)`,
              backgroundSize: "cover",
            }}
          />
          <div className="blank"></div>
          <div>
            <p className="title">측정데이터 확인</p>
            <p className="content">
              그래프 시각화로
              <br /> 측정된 데이터를
              <br /> 한눈에 확인해요
            </p>
            <p className="detail">
              wearable기기로
              <br /> 데이터를 전달 받아
              <br /> 현재 스트레스 및 피로도를
              <br /> 그래프로 확인할 수 있어요
            </p>
          </div>
        </Detail_left>

        <Detail_right id="service_detail2">
          <div>
            <p className="title">일정 관리하기</p>
            <p className="content">
              병원 방문 일자,
              <br /> 개인 일정을 기록해서
              <br /> 관리해요
            </p>
            <p className="detail">
              병원 방문 일자,
              <br /> 개인 일정 등<br /> 나만의 스케줄을
              <br />
              기록하여 관리할 수 있어요
            </p>
          </div>
          <div className="blank"></div>
          <div
            className="card"
            style={{
              backgroundImage: `URL(${process.env.PUBLIC_URL}/images/main/detail_card2.png)`,
              backgroundSize: "cover",
            }}
          />
        </Detail_right>

        <Detail_left id="service_detail3">
          <div
            className="card"
            style={{
              backgroundImage: `URL(${process.env.PUBLIC_URL}/images/main/detail_card3.png)`,
              backgroundSize: "cover",
            }}
          />
          <div className="blank"></div>
          <div>
            <p className="title">측정데이터 확인</p>
            <p className="content">
              그래프 시각화로
              <br /> 측정된 데이터를
              <br /> 한눈에 확인해요
            </p>
            <p className="detail">
              wearable기기로
              <br /> 데이터를 전달 받아
              <br /> 현재 스트레스 및 피로도를
              <br /> 그래프로 확인할 수 있어요
            </p>
          </div>
        </Detail_left>

        <Detail_right id="service_detail4">
          <div>
            <p className="title">일정 관리하기</p>
            <p className="content">
              병원 방문 일자,
              <br /> 개인 일정을 기록해서
              <br /> 관리해요
            </p>
            <p className="detail">
              병원 방문 일자,
              <br /> 개인 일정 등<br /> 나만의 스케줄을
              <br />
              기록하여 관리할 수 있어요
            </p>
          </div>
          <div className="blank"></div>
          <div
            className="card"
            style={{
              backgroundImage: `URL(${process.env.PUBLIC_URL}/images/main/detail_card4.png)`,
              backgroundSize: "cover",
            }}
          />
        </Detail_right>
        <button onClick={start_service}>서비스 시작하기</button>
      </Detail_back>
    </MainBox>
  );
};

export default Main;

const MainBox = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
`;

// 슬로건 css---------------
const SloganBack = styled.div`
  margin-top: -10px;
  width: 100%;
  height: 870px;
  display: flex;

  align-items: center;
  justify-content: space-between;

  & p {
    margin-left: 21%;
    font-size: 50px;
    font-weight: bold;
  }

  @media only screen and (max-width: 1040px) {
    justify-content: center;
    flex-direction: column;
    height: 650px;

    & p {
      margin-top: -10px;
      margin-left: 20px;
      font-size: 35px;
      text-align: center;
    }
  }
`;

const SloganImage = styled.div`
  width: 550px;
  height: 550px;
  background-image: url("${process.env.PUBLIC_URL}/images/main/slogan.png");
  background-size: cover;
  margin-right: 21%;

  @media only screen and (max-width: 1040px) {
    justify-content: center;
    flex-direction: column;
    width: 350px;
    height: 350px;
    margin-right: -20px;
  }
`;

// 서비스 css---------------
const ServiceBack = styled.div`
  background-color: #ececec;
  width: 100%;
  display: flex;
  justify-content: center;

  & span {
    margin-top: 30px;
    font-size: 45px;
    font-weight: bold;
  }

  @media only screen and (max-width: 1040px) {
    & span {
      font-size: 30px;
    }
  }
`;

const ServiceCard_back = styled.div`
  background-color: #ececec;
  width: 100%;
  height: fit-content;
  display: flex;
  align-items: center;
  justify-content: center;
  padding-bottom: 40px;

  & .serviceCard_inner_box {
    width: fit-content;
    display: flex;
    align-items: center;
    justify-content: center;

    @media only screen and (max-width: 1040px) {
      display: grid;
      width: 70%;
      grid-template-columns: repeat(auto-fill, minmax(250px, auto));
      grid-column-gap: -30px;
      place-items: center;
      height: fit-content;
    }
  }
`;

const ServiceCard = styled.div`
  background-color: white;
  width: 200px;
  height: 330px;
  border-radius: 30px;
  margin-left: 15px;
  margin-right: 15px;
  padding: 30px;
  box-shadow: rgba(0, 0, 0, 0.15) 1.95px 1.95px 2.6px;

  & div {
    width: 80px;
    height: 80px;
  }

  & p {
    font-size: 30px;
    font-weight: bold;
  }

  & .service_ex {
    font-size: 18px;
    font-weight: normal;
    color: gray;
  }

  & a {
    font-size: 13px;
    color: gray;
    cursor: pointer;
  }

  @media only screen and (max-width: 1040px) {
    justify-content: center;
    flex-direction: column;
    width: 180px;
    height: 260px;
    margin-top: 30px;

    & div {
      width: 60px;
      height: 60px;
      border-radius: 15px;
    }

    & p {
      font-size: 25px;
      font-weight: bold;
    }
  }
`;

// 서비스디테일 css---------------
const Detail_back = styled.div`
  background-color: #f5f5f5;
  width: 100%;
  height: 2200px;

  & button {
    background-color: #2e2288;
    color: white;
    padding: 20px 150px;
    font-size: 20px;
    border-radius: 40px;
    border: none;
    display: block;
    margin: 0 auto;
    text-align: center;
    margin-top: 70px;
  }

  @media only screen and (max-width: 1040px) {
    justify-content: center;
    flex-direction: column;
    height: 3000px;

    & button {
      padding: 15px 70px;
      font-size: 20px;
    }
  }
`;

const Detail_left = styled.div`
  width: 100%;
  height: 400px;
  padding-top: 100px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;

  & .card {
    background-color: white;
    width: 480px;
    height: 380px;
    border-radius: 20px;
    box-shadow: rgba(0, 0, 0, 0.15) 1.95px 1.95px 2.6px;
    order: 1;
  }

  & .blank {
    width: 100px;
  }

  & div {
    width: 480px;
    text-align: left;
    order: 2;
    & .title {
      color: #2e2288;
      font-size: 25px;
      font-weight: bold;
    }
    & .content {
      font-size: 35px;
      font-weight: bold;
    }
    & .detail {
      font-size: 20px;
    }
  }

  @media only screen and (max-width: 1040px) {
    height: 650px;
    padding-top: 50px;

    & .card {
      order: 1;
      width: 400px;
      height: 300px;
    }

    & div {
      order: 2;
      text-align: center;

      & .title {
        font-size: 20px;
      }

      & .content {
        font-size: 28px;
      }

      & .detail {
        font-size: 18px;
      }
    }
  }
`;

const Detail_right = styled.div`
  width: 100%;
  height: 400px;
  padding-top: 100px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-wrap: wrap;

  & .card {
    background-color: white;
    width: 480px;
    height: 380px;
    border-radius: 20px;
    box-shadow: rgba(0, 0, 0, 0.15) 1.95px 1.95px 2.6px;
    order: 2;
  }

  & .blank {
    width: 100px;
  }

  & div {
    width: 480px;
    text-align: right;
    order: 1;
    & .title {
      color: #2e2288;
      font-size: 25px;
      font-weight: bold;
    }
    & .content {
      font-size: 35px;
      font-weight: bold;
    }
    & .detail {
      font-size: 20px;
    }
  }

  @media only screen and (max-width: 1040px) {
    height: 650px;
    padding-top: 50px;

    & .card {
      order: 1;
      width: 400px;
      height: 300px;
    }

    & div {
      order: 2;
      text-align: center;

      & .title {
        font-size: 20px;
      }

      & .content {
        font-size: 28px;
      }

      & .detail {
        font-size: 18px;
      }
    }
  }
`;
