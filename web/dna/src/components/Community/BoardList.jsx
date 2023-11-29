import React from "react";
import { Link, useNavigate } from "react-router-dom";
import styled from "styled-components";

const BoardList = ({ data, index, length }) => {
  const nav = useNavigate();
  return (
    <React.Fragment>
      <TableRow
        onClick={() => nav(`/boarddetail/${data.bd_idx}`, { state: data })}
      >
        <div style={{ width: "10%" }}>{data.bd_idx}</div>
        <div className="infoBox">
          <div className="title">
            <Link style={{ textDecoration: "none", color: "black" }}>
              {data.bd_title}
            </Link>
          </div>

          <div className="idAndDate">
            <div>{data.mem_id}</div>
            <div>{data.created_at}</div>
          </div>
        </div>
        <div className="likesAndViews">
          <div>
            <img
              src={`${process.env.PUBLIC_URL}/images/community/likes.png`}
              style={{ width: "20px", marginRight: "5px" }}
            />
            {data.bd_likes}
          </div>
          <div>
            <img
              src={`${process.env.PUBLIC_URL}/images/community/view.png`}
              style={{ width: "20px", marginRight: "5px" }}
            />
            {data.bd_views}
          </div>
        </div>
      </TableRow>
      {index < length - 1 && <hr />}
    </React.Fragment>
  );
};

export default BoardList;

const TableRow = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  cursor: pointer;
  & div {
    padding: 10px 0 10px 0;
    text-align: center;
  }

  & .infoBox {
    display: flex;
    align-items: center;
    width: 70%;

    & .title {
      width: 70%;
    }

    & .idAndDate {
      display: flex;
      align-items: center;
      width: 30%;
      & div {
        width: 50%;
      }
    }

    @media only screen and (max-width: 1040px) {
      flex-direction: column;
      width: 60%;
      margin-left: 3%;
      & div {
        text-align: left;
      }

      & .title {
        width: 100%;
        & a {
          width: 100%;
        }
      }

      & .idAndDate {
        width: 100%;
      }
    }
  }

  & .likesAndViews {
    display: flex;
    align-items: center;
    width: 20%;
    & div {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 50%;
    }
    @media only screen and (max-width: 1040px) {
      width: 30%;
      align-items: start;
    }
  }
  @media only screen and (max-width: 1040px) {
    & div {
      padding: 5px 0 5px 0;
    }
  }
`;
