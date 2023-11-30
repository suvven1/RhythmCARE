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
      content1:
        ID.includes("w1") != ""
          ? "걸음수 잔디밭에 처음으로"
          : "조건을 달성하여",
      content2:
        ID.includes("w1") != "" ? "잔디를 심었어요." : "뱃지를 획득해보세요.",
      img:
        ID.includes("w1") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge1.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w2",
      title: ID.includes("w2") != "" ? "반갑잔디" : "????",
      content1: ID.includes("w2") != "" ? "걸음수 잔디밭에" : "조건을 달성하여",
      content2:
        ID.includes("w2") != ""
          ? "잔디를 7개 심었어요."
          : "뱃지를 획득해보세요.",
      img:
        ID.includes("w2") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge2.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w3",
      title: ID.includes("w3") != "" ? "고맙잔디" : "????",
      content1: ID.includes("w3") != "" ? "걸음수 잔디밭에" : "조건을 달성하여",
      content2:
        ID.includes("w3") != ""
          ? "잔디를 30개 심었어요."
          : "뱃지를 획득해보세요.",
      img:
        ID.includes("w3") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge3.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w4",
      title: ID.includes("w4") != "" ? "멋잔디" : "????",
      content1:
        ID.includes("w4") != "" ? "걸음수 잔디밭에 잔디를" : "조건을 달성하여",
      content2:
        ID.includes("w4") != ""
          ? "연속으로 7개 심었어요."
          : "뱃지를 획득해보세요.",
      img:
        ID.includes("w4") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge4.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w5",
      title: ID.includes("w5") != "" ? "예쁘잔디" : "????",
      content1:
        ID.includes("w5") != "" ? "걸음수 잔디밭에 잔디를" : "조건을 달성하여",
      content2:
        ID.includes("w5") != ""
          ? "연속으로 15개 심었어요."
          : "뱃지를 획득해보세요.",
      img:
        ID.includes("w5") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge5.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w6",
      title: ID.includes("w6") != "" ? "초록잔디" : "????",
      content1:
        ID.includes("w6") != "" ? "걸음수 잔디밭에 잔디를" : "조건을 달성하여",
      content2:
        ID.includes("w6") != ""
          ? "연속으로 30개 심었어요."
          : "뱃지를 획득해보세요.",
      img:
        ID.includes("w6") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge6.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w7",
      title: ID.includes("w7") != "" ? "첫걸음" : "????",
      content1:
        ID.includes("w7") != "" ? "첫 5000보를 달성했어요." : "조건을 달성하여",
      content2: ID.includes("w7") != "" ? "" : "뱃지를 획득해보세요.",
      img:
        ID.includes("w7") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge7.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w8",
      title: ID.includes("w8") != "" ? "발걸음" : "????",
      content1:
        ID.includes("w8") != ""
          ? "첫 10000보를 달성했어요."
          : "조건을 달성하여",
      content2: ID.includes("w8") != "" ? "" : "뱃지를 획득해보세요.",
      img:
        ID.includes("w8") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge8.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w9",
      title: ID.includes("w9") != "" ? "활개걸음" : "????",
      content1:
        ID.includes("w9") != ""
          ? "지금까지 50000보를 걸었어요!"
          : "조건을 달성하여",
      content2: ID.includes("w9") != "" ? "" : "뱃지를 획득해보세요.",
      img:
        ID.includes("w9") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge9.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "w10",
      title: ID.includes("w10") != "" ? "황소걸음" : "????",
      content1:
        ID.includes("w10") != ""
          ? "지금까지 200000보를 걸었어요!"
          : "조건을 달성하여",
      content2: ID.includes("w10") != "" ? "" : "뱃지를 획득해보세요.",
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
      content1:
        ID.includes("s1") != ""
          ? "스트레스를 처음으로 측정했어요."
          : "조건을 달성하여",
      content2: ID.includes("s1") != "" ? "" : "뱃지를 획득해보세요.",
      img:
        ID.includes("s1") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge11.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "s2",
      title: ID.includes("s2") != "" ? "관리대상" : "????",
      content1:
        ID.includes("s2") != ""
          ? "스트레스가 지속적으로 높아요."
          : "조건을 달성하여",
      content2:
        ID.includes("s2") != "" ? "관리가 필요해요." : "뱃지를 획득해보세요.",
      img:
        ID.includes("s2") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge12.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "s3",
      title: ID.includes("s3") != "" ? "지킴이" : "????",
      content1:
        ID.includes("s3") != ""
          ? "스트레스가 지속적으로 낮아요."
          : "조건을 달성하여",
      content2:
        ID.includes("s3") != ""
          ? "관리를 잘 하고 있어요."
          : "뱃지를 획득해보세요.",
      img:
        ID.includes("s3") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge13.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "s4",
      title: ID.includes("s4") != "" ? "롤러코스터" : "????",
      content1:
        ID.includes("s4") != "" ? "스트레스가 풀리셨나요?" : "조건을 달성하여",
      content2:
        ID.includes("s4") != ""
          ? "지금처럼만 유지해주세요."
          : "뱃지를 획득해보세요.",
      img:
        ID.includes("s4") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge14.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "s5",
      title: ID.includes("s5") != "" ? "평온의폭발" : "????",
      content1:
        ID.includes("s5") != "" ? "무슨 일이 생기셨나요?" : "조건을 달성하여",
      content2:
        ID.includes("s5") != ""
          ? "스트레스가 갑자기 높아졌어요."
          : "뱃지를 획득해보세요.",
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
      content1:
        ID.includes("t1") != ""
          ? "피로도를 처음으로 측정했어요."
          : "조건을 달성하여",
      content2: ID.includes("t1") != "" ? "" : "뱃지를 획득해보세요.",
      img:
        ID.includes("t1") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge16.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "t2",
      title: ID.includes("t2") != "" ? "관리대상" : "????",
      content1:
        ID.includes("t2") != ""
          ? "피로도가 지속적으로 높아요."
          : "조건을 달성하여",
      content2:
        ID.includes("t2") != "" ? "관리가 필요해요." : "뱃지를 획득해보세요.",
      img:
        ID.includes("t2") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge17.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "t3",
      title: ID.includes("t3") != "" ? "지킴이" : "????",
      content1:
        ID.includes("t3") != ""
          ? "피로도가 지속적으로 낮아요."
          : "조건을 달성하여",
      content2:
        ID.includes("t3") != ""
          ? "관리를 잘 하고 있어요."
          : "뱃지를 획득해보세요.",
      img:
        ID.includes("t3") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge18.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "t4",
      title: ID.includes("t4") != "" ? "롤러코스터" : "????",
      content1:
        ID.includes("t4") != "" ? "피로가 풀리셨나요?" : "조건을 달성하여",
      content2:
        ID.includes("t4") != ""
          ? "지금처럼만 유지해주세요."
          : "뱃지를 획득해보세요.",
      img:
        ID.includes("t4") != ""
          ? `${process.env.PUBLIC_URL}/images/badges/badge19.png`
          : `${process.env.PUBLIC_URL}/images/badges/unknown.png`,
    },
    {
      id: "t5",
      title: ID.includes("t5") != "" ? "평온의폭발" : "????",
      content1:
        ID.includes("t5") != "" ? "너무 무리하지 마세요!" : "조건을 달성하여",
      content2:
        ID.includes("t5") != ""
          ? "피로도가 갑자기 높아졌어요."
          : "뱃지를 획득해보세요.",
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
