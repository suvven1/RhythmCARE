import React from "react";
import styled from "styled-components";
import StressBar from "./StressBar";
import StressLine from "./StressLine";
const StressChart = () => {
  return (
    <ChartBox>
      {/* 하루 */}
      <Title>하루 스트레스</Title>
      <StressBar />
      <hr/>
      {/* 한 주 */}
      <Title>한 주 스트레스</Title>
      <StressLine />
    </ChartBox>
  );
};

export default StressChart;

const ChartBox = styled.div`
  margin: 0 50px 0 50px;
`

const Title = styled.h2`
  font-size: 28px;
  color: #212e3d;
`;
