import React from "react";
import ReactApexChart from "react-apexcharts";
const StressLine = () => {
  const today = new Date();
  const sevenDaysAgo = new Date(today);
  sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 6);

  const formatDate = (date) => {
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month < 10 ? "0" : ""}${month}-${day < 10 ? "0" : ""}${day}`;
  };

  const options = {
    chart: {
      height: 350,
      type: "line",
      zoom: {
        enabled: false,
      },
    },
    dataLabels: {
      enabled: false,
    },
    stroke: {
      curve: "smooth",
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
      tickAmount: 4,
    },
    colors: ["#4bb56d"],
  };

  const series = [
    {
      name: "Stress",
      data: [10, 41, 35, 51, 49, 62, 6],
    },
  ];

  return (
    <div id="lineChart">
      <ReactApexChart
        options={options}
        series={series}
        type="line"
        height={350}
      />
    </div>
  );
};

export default StressLine;
