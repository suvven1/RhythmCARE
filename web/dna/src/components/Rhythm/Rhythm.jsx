import React from "react";
import ReactApexChart from 'react-apexcharts';
import styled from "styled-components";

const Rhythm = () => {
  var heartbeat = 80
  var stress = 62;
  var fatigue = 50;

  // 스트레스 바 그래프---------------
  const StressBar = () => {
    const options = {
      chart: {
        type: 'bar',
        height: 350,
      },
      plotOptions: {
        bar: {
          horizontal: false,
          columnWidth: '60%',
          endingShape: 'rounded',
        },
      },
      dataLabels: {
        enabled: false,
      },
      stroke: {
        show: true,
        width: 2,
        colors: ['transparent'],
      },
      xaxis: {
        categories: ['AM 12', ' 1', ' 2', ' 3', ' 4', ' 5', ' 6', ' 7', ' 8', ' 9', ' 10', ' 11', 'PM 12', ' 1', ' 2', ' 3', ' 4', ' 5', ' 6', ' 7', ' 8', ' 9', ' 10', ' 11'],
      },
      yaxis: {
        max: 100,
        tickAmount: 4
      },
      // fill: {
      //   opacity: 1,
      // },
      // tooltip: {
      //   y: {
      //     formatter: function (val) {
      //       return "$ " + val + " thousands";
      //     },
      //   },
      // },
      colors: ['#4bb56d']
    };

    const series = [
      {
        name: 'Stress',
        data: [44, 55, 57, 56, 61, 58, 63, 60, 80],
      },
    ];

    return (
      <div id="chart">
        <ReactApexChart options={options} series={series} type="bar" height={350} />
      </div>
    );
  };

  // 스트레스 라인 그래프-------------
  const StressLine = () => {

    const today = new Date();
    const sevenDaysAgo = new Date(today);
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 6);

    const formatDate = (date) => {
      const month = date.getMonth() + 1;
      const day = date.getDate();
      return `${month < 10 ? '0' : ''}${month}-${day < 10 ? '0' : ''}${day}`;
    };


    const options = {
      chart: {
        height: 350,
        type: 'line',
        zoom: {
          enabled: false
        }
      },
      dataLabels: {
        enabled: false
      },
      stroke: {
        curve: 'smooth'
      },
      // grid: {
      //   row: {
      //     colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
      //     opacity: 0.5
      //   },
      // },
      xaxis: {
        categories: Array.from({ length: 7 }, (_, i) => {
          const date = new Date(sevenDaysAgo);
          date.setDate(date.getDate() + i);
          return formatDate(date);
        }),
      },
      yaxis: {
        min: 0,
        max: 100,
        tickAmount: 4
      },
      colors: ['#4bb56d']
    }

    const series = [
      {
        name: "Stress",
        data: [10, 41, 35, 51, 49, 62, 6]
      }
    ]

    return (
      <div id="lineChart">
        <ReactApexChart options={options} series={series} type="line" height={350} />
      </div>
    );
  }

  // 피로도 바 그래프----------------
  const FatigueBar = () => {
    const options = {
      chart: {
        type: 'bar',
        height: 350,
      },
      plotOptions: {
        bar: {
          horizontal: false,
          columnWidth: '60%',
          endingShape: 'rounded',
        },
      },
      dataLabels: {
        enabled: false,
      },
      stroke: {
        show: true,
        width: 2,
        colors: ['transparent'],
      },
      xaxis: {
        categories: ['AM 12', ' 1', ' 2', ' 3', ' 4', ' 5', ' 6', ' 7', ' 8', ' 9', ' 10', ' 11', 'PM 12', ' 1', ' 2', ' 3', ' 4', ' 5', ' 6', ' 7', ' 8', ' 9', ' 10', ' 11'],
      },
      yaxis: {
        max: 100,
        tickAmount: 4
      },
      fill: {
        opacity: 1,
      },
      tooltip: {
        y: {
          formatter: function (val) {
            return "$ " + val + " thousands";
          },
        },
      },
      colors: ['#5c95d0']
    };

    const series = [
      {
        name: 'Fatigue',
        data: [44, 55, 57, 56, 61, 58, 63, 60, 80],
      },
    ];

    return (
      <div id="chart">
        <ReactApexChart options={options} series={series} type="bar" height={350} />
      </div>
    );
  };

  // 피로도 라인 그래프--------------
  const FatigueLine = () => {

    const today = new Date();
    const sevenDaysAgo = new Date(today);
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 6);

    const formatDate = (date) => {
      const month = date.getMonth() + 1;
      const day = date.getDate();
      return `${month < 10 ? '0' : ''}${month}-${day < 10 ? '0' : ''}${day}`;
    };


    const options = {
      chart: {
        height: 350,
        type: 'line',
        zoom: {
          enabled: false
        }
      },
      dataLabels: {
        enabled: false
      },
      stroke: {
        curve: 'smooth'
      },
      // grid: {
      //   row: {
      //     colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
      //     opacity: 0.5
      //   },
      // },
      xaxis: {
        categories: Array.from({ length: 7 }, (_, i) => {
          const date = new Date(sevenDaysAgo);
          date.setDate(date.getDate() + i);
          return formatDate(date);
        }),
      },
      yaxis: {
        min: 0,
        max: 100,
        tickAmount: 4
      },
      colors: ['#5c95d0']
    }

    const series = [
      {
        name: "Fatigue",
        data: [10, 41, 35, 51, 49, 62, 6]
      }
    ]

    return (
      <div id="lineChart">
        <ReactApexChart options={options} series={series} type="line" height={350} />
      </div>
    );
  }

  return (
    <div>
      <HeartBeat>
        <p id="hb">{heartbeat}</p>
        <p>bpm</p>
      </HeartBeat>
      <MeasurementBox>
        <StressBox>
          {/* 현재 */}
          <Title>현재 스트레스 지수</Title>
          <CircleBack>
            <CircleBack2>
              <Circle
                style={{
                  left: `${stress}%`,
                }}
              />
            </CircleBack2>
          </CircleBack>
          <RowHighText>
            <p className="row">낮음</p>
            <p className="high">높음</p>
          </RowHighText>
          <NowStatus>
            <p>
              현재 스트레스는 <br />
              <span>{stress > 60 ? '높은' : '낮은'}</span> 상태 입니다
            </p>
            <img src={process.env.PUBLIC_URL + `/images/rhythm/${stress > 60 ? 'bad_status.png' : 'nice_status.png'}`} />
          </NowStatus>

          {/* 하루 */}
          <Title>하루 스트레스</Title>
          <StressBar />

          {/* 한 주 */}
          <Title>한 주 스트레스</Title>
          <StressLine />
        </StressBox>


        <FatigueBox>
          <Title>현재 피로도 지수</Title>
          <CircleBack>
            <CircleBack2>
              <Circle
                style={{
                  left: `${fatigue}%`,
                }}
              />
            </CircleBack2>
          </CircleBack>
          <RowHighText>
            <p className="row">낮음</p>
            <p className="high">높음</p>
          </RowHighText>
          <NowStatus>
            <p>
              현재 피로도는 <br />
              <span>{fatigue > 60 ? '높은' : '낮은'}</span> 상태 입니다
            </p>
            <img src={process.env.PUBLIC_URL + `/images/rhythm/${fatigue > 60 ? 'bad_status.png' : 'nice_status.png'}`} />
          </NowStatus>

          {/* 하루 */}
          <Title>하루 피로도</Title>
          <FatigueBar />

          {/* 한 주 */}
          <Title>한 주 피로도</Title>
          <FatigueLine/>

        </FatigueBox>
      </MeasurementBox>
      <RaderBox>
        <p>
          건강 그래프<br/>
          한 눈에 보기
        </p>
        <div>
          그래프가 들어갈 공간 
        </div>
      </RaderBox>


    </div>
  );
};

export default Rhythm;

// 심박수 ------------------------
const HeartBeat = styled.div`
  margin-top: 50px;
  width: 100%;
  height: 460PX;
  background-image:  url("${process.env.PUBLIC_URL}/images/rhythm/web_heartbeat.gif");
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

const Title = styled.h2`
  font-size: 28px;
`

// 스트레스 피로도 전체 div---------
const MeasurementBox = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 100px;
  gap: 100px;
`;

// 스트레스 div
const StressBox = styled.div`
  width: 50%;
  margin-left: 300px;
  `;

// 피로도 div
const FatigueBox = styled.div`
  width: 50%;
  margin-right: 300px;
`;

// 상태바
const CircleBack = styled.div`
  width: 100%;
  height: 90px;
  background-image:  url("${process.env.PUBLIC_URL}/images/rhythm/status.png");
  background-size: cover;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 30px;
  `;

// circle을 위한 div(0% or 100% 위치해 있을 때 여백을 주기위한 용도)
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

const RowHighText = styled.div`
  display: flex;
  justify-content: space-between;
  margin-top: -10px;

  & p {
    font-size: 20px;
    font-weight: bold;
  }

  & .row {
    color : #4bb56d
  }

  & .high {
    color: #da4b3c;
  }
`

// 현재 상태
const NowStatus = styled.div`
  display: flex;
  justify-content: space-between;
  margin-top: 5px;
  padding-bottom: 50px;

  & p {
    font-size: 22px;
    font-weight : bold;
    color: #212e3d;
    
    & span {
      color: #ec7271
    }
  }

  & img {
    width: 100px;
    height: 100px;
  }
`
// 방사형 그래프
const RaderBox = styled.div`
  width: 100%;
  height: 400px;
  margin-top: 80px;
  background-color: #5c95d0;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 300px;

  & p {
    color: white;
    font-size: 35px;
    font-weight: bold;
  }
`;