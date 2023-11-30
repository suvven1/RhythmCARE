const express = require("express");
const router = express.Router();
const pool = require("../config/database");

// 게시글 작성 수정 관련 --------------------------------------------------------------------------------------------------
// 게시판 정보 업로드(글작성)
router.post("/uploadBoard", async (req, res) => {
  let { title, content, id } = req.body;
  let uploadBoardSql =
    "insert into t_board(bd_title, bd_content, mem_id) values (?,?,?)";

  try {
    await pool.query(uploadBoardSql, [title, content, id]);
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
  let getBoardSql = `select board.*,mem.mem_nick, mem.mem_profile_img
                         from t_member as mem left join t_board as board
                           on mem.mem_id = board.mem_id
                           where mem.mem_id = board.mem_id
                           order by bd_idx desc`;
  let rows;
  try {
    [rows] = await pool.execute(getBoardSql);
    rows.map((board) => {
      board.created_at.setHours(board.created_at.getHours() + 18);
    });
    res.json({
      boardData: rows,
    });
  } catch (err) {
    console.log("[ERROR] 게시판 정보 조회 실패!", err);
    res.json({
      boardData: false,
    });
  } finally {
    pool.query(`ALTER TABLE t_board AUTO_INCREMENT = ${rows.length}`);
  }
});

// 게시글 삭제
router.post("/deleteBoard", async (req, res) => {
  let { id, bd_idx } = req.body;
  let deleteBoardSql = "delete from t_board where mem_id=? and bd_idx=?";

  try {
    await pool.query(deleteBoardSql, [id, bd_idx]);
    res.json({ deleteBoardResult: true });
  } catch (err) {
    console.log("게시글 삭제 실패!", err);
    res.json({ deleteBoardResult: false });
  } finally {
    await initBoardInx();
  }
});

// 게시판 인덱스 초기화
const initBoardInx = async () => {
  try {
    await pool.query(`set @count = 0`);
    try {
      await pool.query("update t_board set bd_idx = @count := @count + 1");
    } catch (err) {
      console.log("인덱스 초기화 실패", err);
    }
  } catch (err) {
    console.log("최대값 조회 실패!", err);
  }
};

// 게시글 좋아요, 조회수 관련 ---------------------------------------------------------------------------------------------------------
// 게시글 좋아요 여부 조회
router.post("/getIsLiked", async (req, res) => {
  let { mem_id, bd_idx } = req.body;
  let getIsLikedSql = `select likes.*,board.bd_likes
                         from t_board_likes as likes left join t_board as board
                           on likes.bd_idx = board.bd_idx
                        where likes.mem_id=?
                          and likes.bd_idx=?`;

  try {
    const [rows] = await pool.query(getIsLikedSql, [mem_id, bd_idx]);
    if (rows.length != 0) {
      res.json({ getIsLikedResult: rows[0].bd_likes });
    }
  } catch (err) {
    console.log("게시글 좋아요 조회 실패!", err);
    res.json({ getIsLikedResult: false });
  }
});

// 게시글 좋아요 활성화
router.post("/likesAdd", async (req, res) => {
  let { mem_id, bd_idx } = req.body;
  let likesAddSql = "insert into t_board_likes(mem_id, bd_idx) values (?,?)";
  try {
    await pool.query(likesAddSql, [mem_id, bd_idx]);
    res.json({ likesAddResult: true });
    await updateBoardLikes(bd_idx);
  } catch (err) {
    console.log("게시글 좋아요 추가 실패!", err);
    res.json({ likesAddResult: false });
  }
});

// 게시글 좋아요 비활성화
router.post("/likesPop", async (req, res) => {
  let { mem_id, bd_idx } = req.body;
  let likesPopSql = "delete from t_board_likes where mem_id=? and bd_idx=?";
  try {
    await pool.query(likesPopSql, [mem_id, bd_idx]);
    res.json({ likesPopResult: true });
    await updateBoardLikes(bd_idx);
  } catch (err) {
    console.log("게시글 좋아요 조회 실패!", err);
    res.json({ likesPopResult: false });
  }
});

// 좋아요 수 업데이트
const updateBoardLikes = async (bd_idx) => {
  let updateBoardLikesSql = `update t_board 
                                 set bd_likes=(select count(*) 
                                                 from t_board_likes
                                                where bd_idx=${bd_idx}) 
                               where bd_idx=${bd_idx}`;
  try {
    await pool.query(updateBoardLikesSql);
  } catch (err) {
    console.log("게시글 좋아요수 업데이트 실패!", err);
  }
};

// 조회수 증가
router.post("/viewsAdd", async (req, res) => {
  let { bd_idx } = req.body;
  let viewsAddSql = `UPDATE t_board 
                          SET bd_views = bd_views + 1
                        WHERE bd_idx = ${bd_idx}`;
  let selectViewsSql = `select bd_views from t_board where bd_idx = ${bd_idx}`;
  try {
    await pool.query(viewsAddSql);
    try {
      const [rows] = await pool.query(selectViewsSql);
      res.json({ viewsAddResult: rows[0].bd_views });
    } catch (error) {
      console.log("조회수 전송 실패!", err);
    }
  } catch (err) {
    console.log("조회수 증가 실패!", err);
    res.json({ viewsAddResult: false });
  }
});

module.exports = router;
