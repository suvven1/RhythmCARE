import React from "react";
import styled from "styled-components";
import TiredBar from "./TiredBar";
import TiredLine from "./TiredLine";

const TiredChart = () => {
  return (
    <ChartBox>
      {/* 하루 */}
      <Title>하루 피로도</Title>
      <TiredBar />
      <hr/>
      {/* 한 주 */}
      <Title>한 주 피로도</Title>
      <TiredLine />
    </ChartBox>
  );
};

export default TiredChart;

const ChartBox = styled.div`
  margin: 0 50px 0 50px;
`

const Title = styled.h2`
  font-size: 28px;
  color: #212e3d;
`;
