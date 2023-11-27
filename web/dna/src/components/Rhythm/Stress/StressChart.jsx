import React from "react";
import styled from "styled-components";
import StressBar from "./StressBar";
import StressLine from "./StressLine";
const StressChart = () => {
  return (
    <div>
      {/* 하루 */}
      <Title>하루 스트레스</Title>
      <StressBar />

      {/* 한 주 */}
      <Title>한 주 스트레스</Title>
      <StressLine />
    </div>
  );
};

export default StressChart;

const Title = styled.h2`
  font-size: 28px;
  color: #212e3d;
`;
