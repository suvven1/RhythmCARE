import React from "react";
import styled from "styled-components";

const BadgeCont = ({ badgeData }) => {
  return (
    <BadgeContent>
      <img src={badgeData.img} alt={badgeData.title} />
      <div>{badgeData.title}</div>
    </BadgeContent>
  );
};

export default BadgeCont;

const BadgeContent = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 70px;
  height: fit-content;
  border-radius: 10px;
  margin: 10px;

  & img {
    width: 70px;
    height: 70px;
    background-color: #bdbdbd;
    border-radius: 10px;
  }
`;
