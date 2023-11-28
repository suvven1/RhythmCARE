const express = require("express");
const router = express.Router();
const pool = require("../config/database");

// 게시판 정보 업로드(글작성)
router.post("/uploadBoard", async (req, res) => {
  console.log("uploadBoard", req.body);
  let { title, content, id } = req.body;
  let uploadBoardSql =
    "insert into t_board(bd_title, bd_content, mem_id) values (?,?,?)";

  try {
    await pool.query(uploadBoardSql, [title, content, id]);
    console.log("게시판 업로드 성공!");
    initBoardInx();
    res.json({
      uploadBoardResult: true,
    });
  } catch (err) {
    console.log("게시판 업로드 실패!", err);
    res.json({
      uploadBoardResult: false,
    });
  }
});

// 게시판 목록 조회(글조회)
router.post("/getBoard", async (req, res) => {
  console.log("getBoard");
  let getBoardSql = "select * from t_board order by created_at";

  try {
    const [rows] = await pool.query(getBoardSql);
    console.log("게시판 정보 조회 성공!", rows[0]);
    //   rows.map((board) => {
    //     board.started_at.setDate(schedule.started_at.getDate() + 1);
    //     board.ended_at.setDate(schedule.ended_at.getDate() + 2);
    //   });
    //   res.json({
    //     boardData: rows,
    //   });
  } catch (err) {
    console.log("[ERROR] 캘린더 정보 조회 실패!", err);
    //   res.json({
    //     scheduleData: false,
    //   });
  }
});
// 켈린더 인덱스 초기화
const initBoardInx = async () => {
  let setCountSql = "set @count=0;";
  let setBoardIndexSql = "update t_board set bd_idx=@count:=@count+1;";

  try {
    await pool.query(setCountSql);
    try {
      await pool.query(setBoardIndexSql);
      console.log("인덱스 초기화 성공");
    } catch (err) {
      console.log("인덱스 초기화 실패!", err);
    }
  } catch (err) {
    console.log("set @count=0 실패!", err);
  }
};

module.exports = router;
