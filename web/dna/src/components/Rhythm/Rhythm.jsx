import React, { useEffect, useState } from "react";
import styled from "styled-components";
import HeartBeat from "./HeartBeat";
import Stress from "./Stress/Stress";
import Tired from "./Tried/Tired";
import Radar from "./Radar";
import HeatMap from "./HeatMap";

const Rhythm = () => {
  return (
    <RhythmBox>
      <HeartBeat />
      <MeasurementBox>
        <Stress />
        <Tired />
      </MeasurementBox>
      <Radar />
      <HeatMap />
    </RhythmBox>
  );
};

export default Rhythm;

const RhythmBox = styled.div`
  margin: 0 300px 0 300px;
  
  @media only screen and (max-width: 1300px) {
    margin: 0px;
    flex-direction: column;
    gap: 0px;
  }
`


// 스트레스 피로도 전체 div---------
const MeasurementBox = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 100px;
  gap: 100px;
  @media only screen and (max-width: 1300px) {
    flex-direction: column;
    gap: 0px;
  }
`;
