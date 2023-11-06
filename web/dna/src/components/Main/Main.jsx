import React from "react";
import styled from "styled-components";
import { Link } from "react-scroll";

const Main = () => {
  return (
    <MainBox>
      <SloganBack>
        <p>
          리듬 속 건강🎶
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
        <ServiceCard>
          <div />
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
          <div />
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
          <div />
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
          <div />
          <p>
            건강관련
            <br />
            정보보기
          </p>
          <p className="service_ex">
            건강과 관련된 <br /> 유용한 정보 얻기
          </p>
          <Link to="service_detail4" spy={true}>
            자세히보기 ▷
          </Link>
        </ServiceCard>
      </ServiceCard_back>

      <Detail_back>
        <Detail id="service_detail1">
          <Detail_card />
          <div className="blank" />
          <Detail_text_l>
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
          </Detail_text_l>
        </Detail>

        <Detail id="service_detail2">
          <Detail_text_r>
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
          </Detail_text_r>
          <div className="blank" />
          <Detail_card />
        </Detail>

        <Detail id="service_detail3">
          <Detail_card />
          <div className="blank" />
          <Detail_text_l>
            <p className="title">내주변 병원정보</p>
            <p className="content">
              내 주변에 있는
              <br /> 병원을 알려줘요
            </p>
            <p className="detail">
              현재 위치를 기반으로
              <br /> 주변의 병원 위치 및<br /> 병원 관련 정보를
              <br /> 한눈에 확인할 수 있어요
            </p>
          </Detail_text_l>
        </Detail>

        <Detail id="service_detail4">
          <Detail_text_r>
            <p className="title">건강관련 정보보기</p>
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
          </Detail_text_r>
          <div className="blank" />
          <Detail_card />
        </Detail>
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
    font-size: 55px;
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
  width: 500px;
  height: 500px;
  background-color: whitesmoke;
  border-radius: 50%;
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
  height: 450px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding-bottom: 10px;

  @media only screen and (max-width: 1040px) {
    justify-content: center;
    flex-direction: column;
    height: 1450px;
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

  & div {
    width: 80px;
    height: 80px;
    background-color: black;
    border-radius: 20px;
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
  height: 2500px;
`;

const Detail = styled.div`
  width: 100%;
  height: 500px;
  padding-top: 100px;
  display: flex;
  justify-content: center;

  & .blank {
    width: 100px;
  }
`;

const Detail_card = styled.div`
  background-color: white;
  width: 480px;
  height: 380px;
  border-radius: 20px;
`;

const Detail_text_l = styled.div`
  width: 480px;
  text-align: left;
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
`;

const Detail_text_r = styled.div`
  width: 480px;
  text-align: right;
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
`;
