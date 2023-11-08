import React, { useState } from "react";
import styled from "styled-components";
import BadgeCont from "./BadgeCont";

const Badge = () => {
  const [walkBadgeData, setWalkBadgeData] = useState([
    {
      categori: "walk",
      title: "안녕잔디",
      img: `${process.env.PUBLIC_URL}/images/badges/badge1.png`,
    },
    {
      categori: "walk",
      title: "반갑잔디",
      img: `${process.env.PUBLIC_URL}/images/badges/badge2.png`,
    },
    {
      categori: "walk",
      title: "고맙잔디",
      img: `${process.env.PUBLIC_URL}/images/badges/badge3.png`,
    },
    {
      categori: "walk",
      title: "멋잔디",
      img: `${process.env.PUBLIC_URL}/images/badges/badge4.png`,
    },
    {
      categori: "walk",
      title: "예쁘잔디",
      img: `${process.env.PUBLIC_URL}/images/badges/badge5.png`,
    },
    {
      categori: "walk",
      title: "초록잔디",
      img: `${process.env.PUBLIC_URL}/images/badges/badge6.png`,
    },
    {
      categori: "walk",
      title: "첫걸음",
      img: `${process.env.PUBLIC_URL}/images/badges/badge7.png`,
    },
    {
      categori: "walk",
      title: "발걸음",
      img: `${process.env.PUBLIC_URL}/images/badges/badge8.png`,
    },
    {
      categori: "walk",
      title: "활개걸음",
      img: `${process.env.PUBLIC_URL}/images/badges/badge9.png`,
    },
    {
      categori: "walk",
      title: "황소걸음",
      img: `${process.env.PUBLIC_URL}/images/badges/badge10.png`,
    },
  ]);
  const [stressBadgeData, setStressBadgeData] = useState([
    {
      categori: "stress",
      title: "안녕스트레스",
      img: `${process.env.PUBLIC_URL}/images/badges/badge11.png`,
    },
    {
      categori: "stress",
      title: "관리대상",
      img: `${process.env.PUBLIC_URL}/images/badges/badge12.png`,
    },
    {
      categori: "stress",
      title: "지킴이",
      img: `${process.env.PUBLIC_URL}/images/badges/badge13.png`,
    },
    {
      categori: "stress",
      title: "롤러코스터",
      img: `${process.env.PUBLIC_URL}/images/badges/badge14.png`,
    },
    {
      categori: "stress",
      title: "평온의폭발",
      img: `${process.env.PUBLIC_URL}/images/badges/badge15.png`,
    },
  ]);
  const [tiredBadgeData, setTiredBadgeData] = useState([
    {
      categori: "tired",
      title: "안녕피로도",
      img: `${process.env.PUBLIC_URL}/images/badges/badge16.png`,
    },
    {
      categori: "tired",
      title: "관리대상",
      img: `${process.env.PUBLIC_URL}/images/badges/badge17.png`,
    },
    {
      categori: "tired",
      title: "지킴이",
      img: `${process.env.PUBLIC_URL}/images/badges/badge18.png`,
    },
    {
      categori: "tired",
      title: "롤러코스터",
      img: `${process.env.PUBLIC_URL}/images/badges/badge19.png`,
    },
    {
      categori: "tired",
      title: "평온의폭발",
      img: `${process.env.PUBLIC_URL}/images/badges/badge20.png`,
    },
  ]);
  return (
    <BadgeBox>
      <div className="title">걸음수</div>
      <Walk>
        {walkBadgeData.map((item) => (
          <BadgeCont badgeData={item} key={item.title} />
        ))}
      </Walk>
      <hr width="78%" />
      <br />
      <div className="title">스트레스</div>
      <Stress>
        {stressBadgeData.map((item) => (
          <BadgeCont badgeData={item} key={item.title} />
        ))}
      </Stress>
      <hr width="78%" />
      <br />
      <div className="title">피로도</div>
      <Tired>
        {tiredBadgeData.map((item) => (
          <BadgeCont badgeData={item} key={item.title} />
        ))}
      </Tired>
    </BadgeBox>
  );
};

export default Badge;

const BadgeBox = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;

  & .title {
    width: 78%;
    margin: -10px 0 30px 0;
    font-size: 20px;
    font-weight: bold;
  }
`;

const Walk = styled.div`
  display: grid;
  width: 80%;
  grid-template-columns: repeat(auto-fill, minmax(160px, auto));
  place-items: center;
  margin: -20px 0 0 0;
`;

const Stress = styled.div`
  display: grid;
  width: 80%;
  grid-template-columns: repeat(auto-fill, minmax(160px, auto));
  place-items: center;
  margin: -20px 0 0 0;
`;

const Tired = styled.div`
  display: grid;
  width: 80%;
  grid-template-columns: repeat(auto-fill, minmax(160px, auto));
  place-items: center;
  margin: -20px 0 0 0;
`;
