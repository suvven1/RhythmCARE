import React, { useEffect, useState } from "react";
import styled from "styled-components";
import HeartBeat from "./HeartBeat";
import Stress from "./Stress/Stress";
import Tired from "./Tried/Tired";
import Radar from "./Radar";
import HeatMap from "./HeatMap";

const Rhythm = () => {
  return (
    <div>
      <HeartBeat />
      <MeasurementBox>
        <Stress />
        <Tired />
      </MeasurementBox>
      <Radar />
      <HeatMap />
    </div>
  );
};

export default Rhythm;

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
