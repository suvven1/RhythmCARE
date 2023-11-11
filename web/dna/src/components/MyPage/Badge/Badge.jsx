import React, { useContext, useEffect, useState } from "react";
import styled from "styled-components";
import BadgeCont from "./BadgeCont";
import { UserContext } from "../../../context/UserContext";

const Badge = () => {
  const userData = useContext(UserContext);
  const [ID, setID] = useState(userData == null ? [] : userData?.badge);
  const [walkBadgeData, setWalkBadgeData] = useState([
    {
      id: "w1",
      title: ID.includes("w1") != "" ? "안녕잔디" : "????",
      img:
        ID.includes("w1") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge1.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w2",
      title: ID.includes("w2") != "" ? "반갑잔디" : "????",
      img:
        ID.includes("w2") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge2.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w3",
      title: ID.includes("w3") != "" ? "고맙잔디" : "????",
      img:
        ID.includes("w3") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge3.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w4",
      title: ID.includes("w4") != "" ? "멋잔디" : "????",
      img:
        ID.includes("w4") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge4.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w5",
      title: ID.includes("w5") != "" ? "예쁘잔디" : "????",
      img:
        ID.includes("w5") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge5.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w6",
      title: ID.includes("w6") != "" ? "초록잔디" : "????",
      img:
        ID.includes("w6") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge6.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w7",
      title: ID.includes("w7") != "" ? "첫걸음" : "????",
      img:
        ID.includes("w7") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge7.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w8",
      title: ID.includes("w8") != "" ? "발걸음" : "????",
      img:
        ID.includes("w8") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge8.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w9",
      title: ID.includes("w9") != "" ? "활개걸음" : "????",
      img:
        ID.includes("w9") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge9.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w10",
      title: ID.includes("w10") != "" ? "황소걸음" : "????",
      img:
        ID.includes("w10") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge10.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
  ]);

  const [stressBadgeData, setStressBadgeData] = useState([
    {
      id: "s1",
      title: ID.includes("s1") != "" ? "안녕스트레스" : "????",
      img:
        ID.includes("s1") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge11.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "s2",
      title: ID.includes("s2") != "" ? "관리대상" : "????",
      img:
        ID.includes("s2") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge12.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "s3",
      title: ID.includes("s3") != "" ? "지킴이" : "????",
      img:
        ID.includes("s3") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge13.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "s4",
      title: ID.includes("s4") != "" ? "롤러코스터" : "????",
      img:
        ID.includes("s4") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge14.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "s5",
      title: ID.includes("s5") != "" ? "평온의폭발" : "????",
      img:
        ID.includes("s5") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge15.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
  ]);
  const [tiredBadgeData, setTiredBadgeData] = useState([
    {
      id: "t1",
      title: ID.includes("t1") != "" ? "안녕피로도" : "????",
      img:
        ID.includes("t1") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge16.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "t2",
      title: ID.includes("t2") != "" ? "관리대상" : "????",
      img:
        ID.includes("t2") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge17.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "t3",
      title: ID.includes("t3") != "" ? "지킴이" : "????",
      img:
        ID.includes("t3") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge18.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "t4",
      title: ID.includes("t4") != "" ? "롤러코스터" : "????",
      img:
        ID.includes("t4") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge19.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "t5",
      title: ID.includes("t5") != "" ? "평온의폭발" : "????",
      img:
        ID.includes("t5") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge20.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
  ]);

  return (
    <BadgeBox>
      <div className="title">걸음수</div>
      <Walk>
        {walkBadgeData.map((item) => (
          <BadgeCont badgeData={item} key={item.id} />
        ))}
      </Walk>
      <hr width="78%" />
      <br />
      <div className="title">스트레스</div>
      <Stress>
        {stressBadgeData.map((item) => (
          <BadgeCont badgeData={item} key={item.id} />
        ))}
      </Stress>
      <hr width="78%" />
      <br />
      <div className="title">피로도</div>
      <Tired>
        {tiredBadgeData.map((item) => (
          <BadgeCont badgeData={item} key={item.id} />
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

  @media only screen and (max-width: 430px) {
    grid-template-columns: repeat(auto-fill, minmax(125px, auto));
  }
`;

const Stress = styled.div`
  display: grid;
  width: 80%;
  grid-template-columns: repeat(auto-fill, minmax(160px, auto));
  place-items: center;
  margin: -20px 0 0 0;
  @media only screen and (max-width: 430px) {
    grid-template-columns: repeat(auto-fill, minmax(125px, auto));
  }
`;

const Tired = styled.div`
  display: grid;
  width: 80%;
  grid-template-columns: repeat(auto-fill, minmax(160px, auto));
  place-items: center;
  margin: -20px 0 0 0;
  @media only screen and (max-width: 430px) {
    grid-template-columns: repeat(auto-fill, minmax(125px, auto));
  }
`;
