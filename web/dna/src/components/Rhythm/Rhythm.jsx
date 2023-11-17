import React from "react";
import styled from "styled-components";

const Rhythm = () => {
  var stress = 100;
  return (
    <div>
      <HeartBeat>
        <p id="hb">100</p>
        <p>bpm</p>
      </HeartBeat>
      <MeasurementBox>
        <StressBox>
          <p>현재 스트레스 지수</p>
          <CircleBack>
            <CircleBack2>

            <Circle
              style={{
                left: `${stress}%`,
              }}
              />
              </CircleBack2>
          </CircleBack>

        </StressBox>
        <FatigueBox>
          <p>현재 피로도 지수</p>
        </FatigueBox>
      </MeasurementBox>


    </div>
  );
};

export default Rhythm;

const HeartBeat = styled.div`
  margin-top: 50px;
  width: 100%;
  height: 460PX;
  background-image:  url("${process.env.PUBLIC_URL}/images/web_heartbeat.gif");
  background-size: cover;
  display: flex;
  flex-direction: column;
  align-items: center;

  & #hb {
    margin-top: 150px;
    font-size: 80px;
    font-weight: bold;
  }

  & p {
    margin-top: -70px;
    font-size: 40px;
    font-weight: bold;
  }
`
const MeasurementBox = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 100px;
  gap: 100px;
`;

const StressBox = styled.div`
  width: 50%;
  margin-left: 300px;
  position: relative;
`;

const CircleBack = styled.div`
  width: 100%;
  height: 90px;
  background-image:  url("${process.env.PUBLIC_URL}/images/status.png");
  background-size: cover;
  display: flex;
  align-items: center;
  justify-content: center;
`;

const CircleBack2 = styled.div`
  width: 80%;
  height: 90px;
  position: relative;
`
  

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

const FatigueBox = styled.div`
  width: 50%;
  margin-right: 300px;
`;