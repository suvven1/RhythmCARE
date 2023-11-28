import React from "react";
import styled from "styled-components";
import ReactApexChart from "react-apexcharts";
const Radar = () => {
  // 심박 백분율
  const heartPersentage = (value) => {
    return (value / 200) * 100;
  };

  const calculatePersentage = (value) => {
    return (value / 100) * 100;
  };

  const stepPersentage = (value) => {
    return (value / 20000) * 100;
  };

  const options = {
    series: [
      {
        name: "평균",
        data: [heartPersentage(80), 73, 26.89, 98, stepPersentage(6000)],
      },
      {
        name: "내 건강정보",
        data: [
          heartPersentage(88),
          calculatePersentage(10),
          calculatePersentage(80),
          calculatePersentage(90),
          stepPersentage(4068),
        ],
      },
    ],
    chart: {
      height: 400,
      width: 500,
      type: "radar",
      dropShadow: {
        enabled: true,
        blur: 1,
        left: 1,
        top: 1,
      },
    },
    stroke: {
      width: 2,
    },
    fill: {
      opacity: 0.1,
    },
    markers: {
      size: 0,
    },
    xaxis: {
      categories: ["심박수", "스트레스", "피로도", "산소포화도", "걸음수"],
      labels: {
        style: {
          colors: ["white", "white", "white", "white", "white"],
        },
      },
    },
    yaxis: {
      max: 100,
      min: 0,
      tickAmount: 5,
    },
    legend: {
      position: "left",
      offsetY: 140,
      labels: {
        colors: "white",
      },
    },
    theme: {
      palette: "palette8", // 팔레트 선택 (선택한 팔레트에 따라 색상이 다르게 적용됩니다)
    },
    responsive : [
      {
        breakpoint: 600,
        options: {
          chart: {
            height: 300,
            width: 400
          }
        }
      }
    ]
  };
  return (
    <RaderBox>
      <p>
        건강 그래프
        <br />한 눈에 보기
      </p>
      <RaderContainer>
        <div id="chart">
          <ReactApexChart
            options={options}
            series={options.series}
            type="radar"
            height={400}
            width={500}
          />
        </div>
      </RaderContainer>
    </RaderBox>
  );
};

export default Radar;

// 방사형 div---------
const RaderBox = styled.div`

  width: 100%;
  height: 400px;
  margin: 80px -300px 0 -300px;
  padding: 0 300px 0 300px;
  background-color: #5c95d0;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 300px;

  & p {
    color: white;
    font-size: 40px;
    font-weight: bold;
  }

  @media only screen and (max-width: 1100px){
    flex-direction: column;
    height: 500px;
    margin-top: -10px;
    gap: 0px;

    & p {
      font-size: 30px;
      text-align: center;
      margin-top: 70px;
    }

  }
`;

const RaderContainer = styled.div`
  margin-top: 70px;

  @media only screen and (max-width: 1100px){
    margin-top: 0px;
  }
`;

