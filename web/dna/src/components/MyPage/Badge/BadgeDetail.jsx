import React, { useEffect, useRef } from "react";
import styled from "styled-components";

const BadgeDetail = ({ setBadgeOpen, badgeData }) => {
  // 모달 코드 시작------------------------------------------------------------------------------------
  // 모달 끄기
  const closeBadge = () => {
    setBadgeOpen(false);
    alert("닉네임 변경이 취소 되었습니다.");
  };

  // 모달 외부 클릭 시 끄기
  const badgeRef = useRef(null);

  useEffect(() => {
    // 이벤트 핸들러 함수
    const handler = (event) => {
      // mousedown 이벤트가 발생한 영역이 모달창이 아닐 때, 모달창 제거 처리
      if (badgeRef.current && !badgeRef.current.contains(event.target)) {
        setBadgeOpen(false);
      }
    };

    // 이벤트 핸들러 등록
    document.addEventListener("mousedown", handler);
    // document.addEventListener('touchstart', handler); // 모바일 대응

    return () => {
      // 이벤트 핸들러 해제
      document.removeEventListener("mousedown", handler);
      // document.removeEventListener('touchstart', handler); // 모바일 대응
    };
  });
  // 모달 코드 끝-------------------------------------------------------------------------------------

  return (
    <BadgeBox ref={badgeRef}>
      <div className="badgeName">{badgeData.title}</div>
      <div className="badgeImg">
        <div className="imgEffect">
          <img src={badgeData.img} alt={badgeData.title} />
        </div>
      </div>
      <div className="badgeDetail"></div>
    </BadgeBox>
  );
};

export default BadgeDetail;

const BadgeBox = styled.div`
  display: flex;
  flex-direction: column;
  /* justify-content: center; */
  align-items: center;
  width: 450px;
  height: 550px;
  z-index: 99999999;
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background-color: #183263;
  color: white;
  border: 1px solid rgba(0, 0, 0, 0.253);
  border-radius: 30px;
  box-shadow: 0 0 2cqi rgba(30, 30, 30, 0.9);
  padding-bottom: 10px;
  cursor: auto;
  @media only screen and (max-width: 430px) {
    width: 90%;
  }

  & .badgeName {
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 30px;
    margin: 40px 0 0 0;
    padding: 0 10px 0 10px;
    width: 86%;
    height: 40px;
  }

  & .badgeImg {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0 10px 0 10px;
    margin: 0;
    width: 86%;
    height: 350px;

    /* filter: drop-shadow(0 0 10px #c78a12) drop-shadow(0 0 35px #c78a12); */
    filter: drop-shadow(0 0 10px white) drop-shadow(0 0 40px white);
    & .imgEffect {
      display: flex;
      align-items: center;
      justify-content: center;
      --clr: rgba(255, 255, 255, 0.2);
      @property --a {
        syntax: "<angle>";
        inherits: false;
        initial-value: 0deg;
      }
      position: relative;
      width: 213px;
      height: 238px;
      padding-top: 7px;
      background: repeating-conic-gradient(
        from var(--a),
        var(--clr) 0%,
        var(--clr) 5%,
        transparent 5%,
        transparent 40%,
        var(--clr) 50%
      );
      clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
      animation: animate 5s linear infinite;

      @keyframes animate {
        0% {
          --a: 0deg;
        }
        100% {
          --a: 360deg;
        }
      }
      &::before {
        content: "";
        position: absolute;
        inset: 10px;
        background: #191919;
        clip-path: polygon(
          50% 0%,
          100% 25%,
          100% 75%,
          50% 100%,
          0% 75%,
          0% 25%
        );
      }
    }

    & img {
      width: 230px;
      filter: drop-shadow(0 0 0);
      max-width: 300px;
      &:hover {
        width: 230px;
        max-width: 300px;
      }
    }
  }

  & .badgeDetail {
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 0 10px 0 10px;
    margin: 10px 0 10px 0;
    width: 86%;
    height: 185px;
  }
`;
