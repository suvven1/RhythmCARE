import React from "react";
import styled from "styled-components";
import TiredBar from "./TiredBar";
import TiredLine from "./TiredLine";

const TiredChart = () => {
  return (
    <div>
      {/* 하루 */}
      <Title>하루 피로도</Title>
      <TiredBar />

      {/* 한 주 */}
      <Title>한 주 피로도</Title>
      <TiredLine />
    </div>
  );
};

export default TiredChart;

const Title = styled.h2`
  font-size: 28px;
  color: #212e3d;
`;
