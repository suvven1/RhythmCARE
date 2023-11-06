import React, { useState } from "react";
import styled from "styled-components";
import BadgeCont from "./BadgeCont";

const Badge = () => {
  const [badgeData, setBadgeData] = useState([
    { title: "test1", img: "" },
    { title: "test2", img: "" },
    { title: "test3", img: "" },
    { title: "test4", img: "" },
    { title: "test5", img: "" },
    { title: "test6", img: "" },
    { title: "test1", img: "" },
    { title: "test2", img: "" },
    { title: "test3", img: "" },
    { title: "test4", img: "" },
    { title: "test5", img: "" },
    { title: "test6", img: "" },
  ]);
  return (
    <BadgeBox>
      {badgeData.map((item) => (
        <BadgeCont badgeData={item} key={item.title} />
      ))}
    </BadgeBox>
  );
};

export default Badge;

const BadgeBox = styled.div`
  display: grid;
  width: 85%;
  grid-template-columns: repeat(auto-fill, minmax(80px, auto));
  justify-content: center;
  margin-top: -20px;
`;
