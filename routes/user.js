const express = require("express");
const router = express.Router();
const conn = require("../config/database");

// 회원가입
router.post("/join", (req, res) => {
  console.log("user join router", req.body);
  let { id, pw, nick } = req.body;
  let checksql = "select * from member where id=?";
  let sql = "insert into member values (?, ?, ?)";
  conn.query(checksql, [id], (err, rows) => {
    console.log("test", rows);
    if (rows.length === 0) {
      conn.query(sql, [id, pw, nick], (err, rows) => {
        console.log("회원가입 로직", rows);
        if (rows) {
          console.log("회원가입 성공");
          res.json({ joinResult: "success", userID: id });
        } else {
          console.log("회원가입 실패!", err);
          res.json({ joinResult: "failed" });
        }
      });
    } else {
      console.log("ID 중복");
      res.json({ joinResult: "dup" });
    }
  });
});

// 로그인
router.post("/login", (req, res) => {
  let { id, pw } = req.body;
  console.log("req :", id, pw);
  let sql = "select * from member where id=? and pw=?";
  conn.query(sql, [id, pw], (err, rows) => {
    console.log("로그인 로직", rows);
    if (rows.length != 0) {
      console.log("로그인 성공!", rows[0].nick);
      res.json({ loginResult: rows[0].nick });
      // req.session.id = rows[0].id;
      // req.session.save(()=>{
      //     res.json({loginResult : rows[0].id})
      // })
    } else {
      console.log("로그인 실패!");
      res.json({ loginResult: false });
    }
  });
});

module.exports = router;
