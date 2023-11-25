import React, { useState } from "react";
import axios from "../../axios";
import { Link, useNavigate } from "react-router-dom";
import styled from "styled-components";

const Community = () => {
  const nav = useNavigate();
  const itemsPerPage = 10;

  const [currentPage, setCurrentPage] = useState(1);      // 페이지 이동
  const [searchKeyword, setSearchKeyword] = useState(""); // 검색
  const [searchResults, setSearchResults] = useState([]); // 검색 결과
  const [initialLoad, setInitialLoad] = useState(true); // 초기 로딩 여부

  const searchBoard = (e) => {
    e.preventDefault();
    const results = searchKeyword
      ? dummyData.filter((data) => data.bd_title.includes(searchKeyword))
      : dummyData;
    // 검색 결과 설정
    setSearchResults(results);
    // 검색 결과가 있을 경우 현재 페이지를 1로 설정
    setCurrentPage(results.length > 0 ? 1 : 0);
    setInitialLoad(false)
    console.log("Search results:", searchResults);

  };

  const dummyData = [
    { bd_idx: 1, bd_title: "첫번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
    { bd_idx: 2, bd_title: "두번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
    { bd_idx: 3, bd_title: "첫번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
    { bd_idx: 4, bd_title: "첫번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
    { bd_idx: 5, bd_title: "첫번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
    { bd_idx: 6, bd_title: "첫번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
    { bd_idx: 7, bd_title: "첫번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
    { bd_idx: 8, bd_title: "첫번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
    { bd_idx: 9, bd_title: "첫번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
    { bd_idx: 10, bd_title: "첫번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
    { bd_idx: 11, bd_title: "첫번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
    { bd_idx: 12, bd_title: "첫번째 게시글", mem_id: "최진수", created_at: "23.10.31", bd_likes: 2, bd_views: 2 },
  ];

  // 현재 페이지에 대한 인덱스 범위 계산
  const startIndex = (currentPage - 1) * itemsPerPage;
  const endIndex = startIndex + itemsPerPage;

  // 현재 페이지의 아이템 가져오기
  const currentItems = searchKeyword ? searchResults : dummyData.slice(startIndex, endIndex);

  const totalPages = Math.ceil((searchKeyword ? searchResults.length : dummyData.length) / itemsPerPage);

  const pageNumbers = Array.from({ length: totalPages }, (_, index) => index + 1);

  return (
    <CommunityBox>
      <ToolContainer>
        <form onSubmit={searchBoard}>
          <img src={`${process.env.PUBLIC_URL}/images/community/search.png`} />
          <input
            className="search_text"
            type="text"
            placeholder="검색어를 입력해주세요"
            value={searchKeyword}
            onChange={(e) => setSearchKeyword(e.target.value)} />
          <input className="search_btn" type="submit" value="검색" />
        </form>
        <Link to="/boardwriteform">
          <button className="writeBtn">글쓰기</button>
        </Link>

      </ToolContainer>
      <hr className="custom-hr" />

      <TableHeader>
        <div style={{ width: "150px" }}>글번호</div>
        <div style={{ width: "650px" }}>제목</div>
        <div style={{ width: "150px" }}>작성자</div>
        <div style={{ width: "150px" }}>작성일자</div>
        <div style={{ width: "150px" }}>좋아요수</div>
        <div style={{ width: "150px" }}>조회수</div>
      </TableHeader>
      <hr className="custom-hr" />

      {/* 검색 결과 있을때 */}
      {currentItems.length > 0 ? (
        currentItems.map((data, index) => (
          <React.Fragment key={data.bd_idx}>
            <TableRow>
              <div style={{ width: "150px" }}>{data.bd_idx}</div>
              <div style={{ width: "650px" }}>
                <Link
                  to={`/boarddetail/${data.bd_idx}`}
                  style={{ textDecoration: 'none', color: 'black' }}>
                  {data.bd_title}
                </Link>
              </div>
              <div style={{ width: "150px" }}>{data.mem_id}</div>
              <div style={{ width: "150px" }}>{data.created_at}</div>
              <div style={{ width: "150px", display: 'flex', alignItems: 'center', justifyContent: 'center'}}>
                <img
                  src={`${process.env.PUBLIC_URL}/images/community/likes.png`}
                  style={{ width: '20px', marginRight: '5px' }}
                />
                {data.bd_likes}
              </div>
              <div style={{ width: "150px", display: 'flex', alignItems: 'center', justifyContent: 'center'}}>
                <img
                  src={`${process.env.PUBLIC_URL}/images/community/view.png`}
                  style={{ width: '20px', marginRight: '5px' }}
                />
                {data.bd_views}
              </div>
            </TableRow>
            {index < currentItems.length - 1 && <hr />}
          </React.Fragment>
        ))

        // 결과 없을떄
      ) : !initialLoad ? (
        <div style={{ textAlign: 'center', padding: "10px 0 10px 0" }}>검색 결과가 없습니다.</div>
      ) : (

        // 초기 로딩시 전체 데이터 표시
        dummyData.map((data, index) => (
          <React.Fragment key={data.bd_idx}>
            <TableRow>
              <div style={{ width: "150px" }}>{data.bd_idx}</div>
              <div style={{ width: "650px" }}>
                <Link
                  to={`/boarddetail/${data.bd_idx}`}
                  style={{ textDecoration: 'none', color: 'black' }}>
                  {data.bd_title}
                </Link>
              </div>
              <div style={{ width: "150px" }}>{data.mem_id}</div>
              <div style={{ width: "150px" }}>{data.created_at}</div>
              <div style={{ width: "150px", display: 'flex', alignItems: 'center', justifyContent: 'center'}}>
                <img
                  src={`${process.env.PUBLIC_URL}/images/community/likes.png`}
                  style={{ width: '20px', marginRight: '5px' }}
                />
                {data.bd_likes}
              </div>
              <div style={{ width: "150px", display: 'flex', alignItems: 'center', justifyContent: 'center'}}>
                <img
                  src={`${process.env.PUBLIC_URL}/images/community/view.png`}
                  style={{ width: '20px', marginRight: '5px' }}
                />
                {data.bd_views}
              </div>
            </TableRow>
            {index < dummyData.length - 1 && <hr />}
          </React.Fragment>
        ))
      )}
      <hr />
      {/* 페이지 버튼 이동 */}
      <Pagination>
        <button onClick={() => setCurrentPage(currentPage - 1)} disabled={currentPage === 1}>
          ←
        </button>
        {pageNumbers.map((number) => (
          <button key={number} onClick={() => setCurrentPage(number)} className={currentPage === number ? "active" : ""}>
            {number}
          </button>
        ))}
        <button onClick={() => setCurrentPage(currentPage + 1)} disabled={currentPage === totalPages}>
          →
        </button>
      </Pagination>
    </CommunityBox>
  );
};

export default Community;

const CommunityBox = styled.div`
  margin: 20px 300px 0 300px;
  

  & .custom-hr {
    border: 1px solid #2e2288;
  }

  @media only screen and (max-width: 1040px){
    margin: 20px 50px 0 50px;
    font-size: 13px;

  }
`

const ToolContainer = styled.div`
  display: flex;
  justify-content  : space-between ;
  align-items: center;
  margin-bottom: 20px;
  & img {
    width: 20px;
    padding-right: 10px;
  }

  & .search_text {
    width: 200px;
    height: 25px;
    margin-right: 10px;
  }

  & .search_btn {
    padding: 8px 10px;
    border-radius: 5px;
    border: none;
    background-color: #2e2288;
    color: white;
    font-size: 12px;
    cursor: pointer;
    text-decoration: none;
  }
  
& .writeBtn{
    padding: 15px 32.5px;
    border-radius: 10px;
    border: none;
    background-color: #2e2288;
    color: white;
    font-size: 15px;
    cursor: pointer;
    display: block;
    text-decoration: none;

  }
  @media only screen and (max-width: 1040px){
    & .search_text {
    width: 150px;
    height: 25px;
    margin-right: 10px;
    }

    & .writeBtn{
    padding: 8px 10px;
    border-radius: 5px;
    border: none;
    background-color: #2e2288;
    color: white;
    font-size: 15px;
    cursor: pointer;
    display: block;
    text-decoration: none;
    }
  }
`

const TableHeader = styled.div`
  display: flex;
  justify-content: space-between;
  text-align: center;
  font-weight: bold;
  padding: 10px 0 10px 0;;
  `

const TableRow = styled.div`
  display: flex;
  justify-content: space-between;
  
  
  & div{
    padding: 10px 0 10px 0;
    text-align: center;
  }
  
`

const Pagination = styled.div`
  margin-top: 30px;
  display: flex;
  justify-content: center;

  & button {
    border: none;
    padding: 5px 10px;
    margin: 0 5px;
    cursor: pointer;
    border-radius: 5px;
  }
  
  & button.active {
    background-color: #2e2288;
    color: white;
  }
  
`