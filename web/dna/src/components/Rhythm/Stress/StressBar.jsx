import React from "react";
import ReactApexChart from "react-apexcharts";
const StressBar = () => {
  const options = {
    chart: {
      type: "bar",
      height: 350,
    },
    plotOptions: {
      bar: {
        horizontal: false,
        columnWidth: "60%",
        endingShape: "rounded",
      },
    },
    dataLabels: {
      enabled: false,
    },
    stroke: {
      show: true,
      width: 2,
      colors: ["transparent"],
    },
    xaxis: {
      categories: [
        "AM 12",
        " 1",
        " 2",
        " 3",
        " 4",
        " 5",
        " 6",
        " 7",
        " 8",
        " 9",
        " 10",
        " 11",
        "PM 12",
        " 1",
        " 2",
        " 3",
        " 4",
        " 5",
        " 6",
        " 7",
        " 8",
        " 9",
        " 10",
        " 11",
      ],
    },
    yaxis: {
      max: 100,
      tickAmount: 4,
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
    colors: ["#4bb56d"],
  };

  const series = [
    {
      name: "Stress",
      data: [44, 55, 57, 56, 61, 58, 63, 60, 80],
    },
  ];
  return (
    <div id="chart">
      <ReactApexChart
        options={options}
        series={series}
        type="bar"
        height={350}
      />
    </div>
  );
};

export default StressBar;
