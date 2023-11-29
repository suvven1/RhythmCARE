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

// 댓글 업로드
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

// 댓글 좋아요 여부 조회
router.post("/getIsCmtLiked", async (req, res) => {
  let { mem_id, cmt_idx } = req.body;
  let getIsLikedSql = `select likes.*,comment.cmt_likes
                           from t_comment_likes as likes left join t_comment as comment
                             on likes.cmt_idx = comment.cmt_idx
                          where likes.mem_id=?
                            and likes.cmt_idx=?`;

  try {
    const [rows] = await pool.query(getIsLikedSql, [mem_id, cmt_idx]);
    if (rows.length != 0) {
      res.json({ getIsLikedResult: rows[0].cmt_likes });
    } else {
      res.json({ getIsLikedResult: false });
    }
  } catch (err) {
    console.log("댓글 좋아요 조회 실패!", err);
    res.json({ getIsLikedResult: false });
  }
});

// 댓글 좋아요 활성화
router.post("/cmtLikesAdd", async (req, res) => {
  console.log("likesAdd", req.body);
  let { mem_id, cmt_idx } = req.body;
  let likesAddSql = "insert into t_comment_likes(mem_id, cmt_idx) values (?,?)";
  try {
    await pool.query(likesAddSql, [mem_id, cmt_idx]);
    res.json({ result: true });
    await updateCmtLikes(cmt_idx);
  } catch (err) {
    console.log("댓글 좋아요 추가 실패!", err);
    res.json({ result: false });
  }
});

// 댓글 좋아요 비활성화
router.post("/cmtLikesPop", async (req, res) => {
  let { mem_id, cmt_idx } = req.body;
  let likesPopSql = "delete from t_comment_likes where mem_id=? and cmt_idx=?";
  try {
    await pool.query(likesPopSql, [mem_id, cmt_idx]);
    res.json({ result: true });
    await updateCmtLikes(cmt_idx);
  } catch (err) {
    console.log("댓글 좋아요 조회 실패!", err);
    res.json({ result: false });
  }
});

// 좋아요 수 업데이트
const updateCmtLikes = async (cmt_idx) => {
  let updateCmtLikesSql = `update t_comment 
                                   set cmt_likes=(select count(*) 
                                                    from t_comment_likes
                                                   where cmt_idx=${cmt_idx}) 
                                 where cmt_idx=${cmt_idx}`;
  try {
    await pool.query(updateCmtLikesSql);
  } catch (err) {
    console.log("댓글 좋아요수 업데이트 실패!", err);
  }
};

module.exports = router;
