import React, { useEffect, useState } from "react";
import styled from "styled-components";
import ReactApexChart from "react-apexcharts";
const HeatMap = () => {
  const [step, setStep] = useState("--");
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ]; // 월 목록
  const daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]; // 요일 목록

  const generateData = (count, yrange, startDay) => {
    let i = 0;
    const series = [];

    while (i < count) {
      const x = new Date(2023, 0, startDay + i * 7); // 각 주의 시작일
      const y =
        Math.floor(Math.random() * (yrange.max - yrange.min + 1)) + yrange.min;

      series.push({
        x: x.getTime(),
        y: y,
      });
      i++;
    }
    return series;
  };

  const [chartOptions, setChartOptions] = useState({
    chart: {
      height: 250,
      type: "heatmap",
      toolbar: {
        show: false, // 툴바를 숨김
      },
    },
    dataLabels: {
      enabled: false,
    },
    colors: ["#4ab134"],
    xaxis: {
      type: "datetime",
      labels: {
        show: true,
        // rotateAlways: true,
        // rotate: -45,/
        datetimeFormatter: {
          month: "MMM", // 월 표시
        },
      },
    },
    yaxis: {
      categories: daysOfWeek,
      reversed: true,
    },
    tooltip: {
      enabled: true,
      x: {
        formatter: function (val) {
          const date = new Date(val);
          return months[date.getMonth()] + " " + date.getDate();
        },
      },
    },
  });

  const [chartSeries, setChartSeries] = useState([
    { name: "Sun", data: generateData(8, { min: 0, max: 90 }, 1) },
    { name: "Mon", data: generateData(8, { min: 0, max: 90 }, 2) },
    { name: "Tue", data: generateData(8, { min: 0, max: 90 }, 3) },
    { name: "Wed", data: generateData(8, { min: 0, max: 90 }, 4) },
    { name: "Thu", data: generateData(8, { min: 0, max: 90 }, 5) },
    { name: "Fri", data: generateData(8, { min: 0, max: 90 }, 6) },
    { name: "Sat", data: generateData(8, { min: 0, max: 90 }, 7) },
  ]);

  useEffect(() => {
    // 차트 초기화
    setChartOptions((prevOptions) => ({
      ...prevOptions,
    }));
    setChartSeries((prevSeries) => [...prevSeries]);
  }, []);
  return (
    <HeatmapBox>
      <Title>걸음수 잔디밭</Title>
      <StepText>
        <p>
          오늘의 걸음수에 따라 잔디를 채울 수 있어요
          <br />
          6000보 이상은 연한 잔디, 10000보 이상은 진한 잔디가 채워져요
        </p>
        <p id="step">{step}걸음</p>
      </StepText>
      <div>
        <ReactApexChart
          options={chartOptions}
          series={chartSeries}
          type="heatmap"
          height={400}
        />
      </div>
    </HeatmapBox>
  );
};

export default HeatMap;
const Title = styled.h2`
  font-size: 28px;
  color: #212e3d;
`;

const HeatmapBox = styled.div`
  margin-left: 300px;
  margin-right: 300px;
  margin-top: 70px;
`;

const StepText = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: -60px;

  & #step {
    font-size: 45px;
    font-weight: bold;
    color: #212e3d;
  }
`;
