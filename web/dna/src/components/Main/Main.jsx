import React from "react";
import styled from "styled-components";
//김원영테스트

const Main = () => {
  return (
    <div>
      <SloganBack>
        <p>
          리듬 속 건강🎶
          <br/>
          당신의 건강한 리듬을
          <br/>
          위한 최고의 파트너

        </p>
        <SloganImage/>
      </SloganBack>
      <ServiceBack>
        <span>서비스</span>
      </ServiceBack>
        <ServiceCard_back>
          <ServiceCard>
            <div/>
            <p>측정 데이터<br/>확인</p>
            <p className="service_ex">wearable기기로 <br/> 측정한 데이터 확인</p>
            <a>자세히보기 ▷</a>
          </ServiceCard>
          <ServiceCard/>
          <ServiceCard/>
          <ServiceCard/>
        </ServiceCard_back>
    </div>
  );
};

export default Main;

const mainBox = styled.div`
  display = flex;
  align-items : center;
  justify-content : center;
`;

const SloganBack = styled.div`
  margin-top : -10px;
  width: 100%;
  height: 870px;
  display : flex;
  
  align-items : center;
  justify-content : space-between;

  & p {
    margin-left : 21%;
    font-size : 55px;
    font-weight : bold;
  }

  @media only screen and (max-width : 1040px){
    justify-content : center;
    flex-direction : column;
    height : 650px;

    & p {
      margin-top : -10px;
      margin-left : 20px;
      font-size : 35px;
      text-align : center;
    }
  }
`;

const SloganImage = styled.div`
  width : 500px;
  height : 500px;
  background-color : whitesmoke;
  border-radius: 50%;
  margin-right: 21%;

  @media only screen and (max-width : 1040px){
    justify-content : center;
    flex-direction : column;
    width : 350px;
    height : 350px;
    margin-right : -20px;
  }
`
const ServiceBack = styled.div`
  background-color : #ECECEC;
  width : 100%;
  display : flex;
  justify-content : center;
  
  & span {
    margin-top : 30px;
    font-size : 45px;
    font-weight : bold;
  }
`;

const ServiceCard_back = styled.div`
background-color : #ECECEC;
width : 100%;
height : 400px;
display : flex;
align-items : center;
justify-content : center;
padding-bottom : 10px;
`;

const ServiceCard = styled.div`
  background-color : white;
  width : 250px;
  height : 350px;
  border-radius : 30px;
  margin-left: 15px;
  margin-right : 15px;

  & div {
    margin : 25px;
    width : 80px;
    height : 80px;
    background-color : black;
    border-radius : 20px;
  }

  & p {
    margin-left : 25px;
    font-size : 30px;
    font-weight : bold;
  }

  & .service_ex {
    margin-left : 25px;
    font-size : 15px;


`;