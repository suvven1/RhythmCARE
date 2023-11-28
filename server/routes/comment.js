const express = require("express");
const router = express.Router();
const pool = require("../config/database");

// 댓글 목록 조회
router.post("/getComment", async (req, res) => {
  let { bd_idx } = req.body;
  let getCommentSql = `select comment.*,mem.mem_nick, mem.mem_profile_img
                         from t_member as mem left join t_comment as comment
                           on mem.mem_id = comment.mem_id
                        where comment.bd_idx = ?
                        order by cmt_idx desc`;
  try {
    const [rows] = await pool.execute(getCommentSql, [parseInt(bd_idx)]);
    rows.map((comment) => {
      comment.created_at.setHours(comment.created_at.getHours() + 18);
    });
    res.json({
      commentData: rows,
    });
  } catch (err) {
    console.log("[ERROR] 댓글 정보 조회 실패!", err);
    res.json({
      commentData: false,
    });
  }
});

// 게시판 정보 업로드(글작성)
router.post("/uploadComment", async (req, res) => {
  let { bd_idx, cmt_content, mem_id } = req.body;
  let uploadCommentSql =
    "insert into t_comment(bd_idx, cmt_content, mem_id) values (?,?,?)";

  try {
    await pool.query(uploadCommentSql, [bd_idx, cmt_content, mem_id]);
    res.json({
      uploadCommentResult: true,
    });
  } catch (err) {
    console.log("댓글 업로드 실패!", err);
    res.json({
      uploadCommentResult: false,
    });
  }
});

module.exports = router;
