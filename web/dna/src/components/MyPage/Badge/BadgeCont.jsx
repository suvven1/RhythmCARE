import React, { useState } from "react";
import styled from "styled-components";
import BadgeDetail from "./BadgeDetail";

const BadgeCont = ({ badgeData }) => {
  // 뱃지 모달 띄우기
  const [badgeOpen, setBadgeOpen] = useState(false);

  // 모달창 노출
  const showBadge = () => {
    setBadgeOpen(true);
  };
  // 뱃지 모달 끝
  return (
    <BadgeContent onClick={showBadge}>
      <img src={badgeData.img} alt={badgeData.title} />
      <div>{badgeData.title}</div>
      {badgeOpen && (
        <BadgeDetail setBadgeOpen={setBadgeOpen} badgeData={badgeData} />
      )}
    </BadgeContent>
  );
};

export default BadgeCont;

const BadgeContent = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 150px;
  height: 170px;
  border-radius: 10px;
  margin: 10px 10px 30px 10px;
  font-size: 17px;
  font-weight: bold;
  cursor: pointer;
  & img {
    width: 130px;
    /* background-color: #bdbdbd; */
    border-radius: 10px;
    margin-bottom: 8px;
    filter: drop-shadow(5px 5px 5px #bdbdbd);
    &:hover {
      width: 140px;
    }
  }
`;
