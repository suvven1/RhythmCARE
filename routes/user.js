const express = require("express");
const router = express.Router();
const conn = require("../config/database");

// 회원가입 시작 ------------------------------------------------------------------------------
router.post("/join", (req, res) => {
  console.log("user join", req.body);
  let {
    id,
    pw,
    mName,
    nick,
    mBirth,
    mGender,
    mPhone,
    uName,
    uBirth,
    uGender,
    uPhone,
  } = req.body.joinData;
  let joinSql = "insert into user values (?,?,?,?,?,?,?,?,?,?,?)";
  conn.query(
    joinSql,
    [
      id,
      pw,
      mName,
      nick,
      mBirth,
      mGender,
      mPhone,
      uName,
      uBirth,
      uGender,
      uPhone,
    ],
    (err, rows) => {
      if (rows) {
        console.log("회원가입 성공");
        res.json({ joinResult: true });
      } else {
        console.log("회원가입 실패!", err);
        res.json({ joinResult: false });
      }
    }
  );
});

// 아이디 중복체크
router.post("/join/idDupCheck", (req, res) => {
  console.log("user join idDupCheck", req.body);
  let { id } = req.body;
  let idDupCheckSql = "select * from user where id=?";
  conn.query(checksql, [id], (err, rows) => {
    if (rows.length == 0) {
      console.log("ID 중복");
      res.json({ idDupResult: true });
    } else {
      console.log("사용 가능한 ID");
      res.json({ idDupResult: false });
    }
  });
});

// 닉네임 중복체크
router.post("/join/nickDupCheck", (req, res) => {
  console.log("user join nickDupCheck", req.body);
  let { nick } = req.body;
  let nickDupCheckSql = "select * from user where user_nick=?";
  conn.query(checksql, [id], (err, rows) => {
    if (rows.length == 0) {
      console.log("Nick 중복");
      res.json({ nickDupResult: true });
    } else {
      console.log("사용 가능한 Nick");
      res.json({ nickDupResult: false });
    }
  });
});
// 회원가입 끝 -------------------------------------------------------------------------------

// 로그인 시작 -------------------------------------------------------------------------------
router.post("/login", (req, res) => {
  console.log("user login", req.body);
  let { user, id, pw } = req.body;
  let loginSql = "select * from user where manager_id=? and password=?";
  conn.query(loginSql, [id, pw], (err, rows) => {
    if (rows.length != 0) {
      console.log("로그인 성공!", rows[0].manager_nick);
      if (user == "manager") {
        res.json({
          loginResult: {
            nick: rows[0].manager_nick,
            name: rows[0].manager_name,
          },
        });
      } else {
        res.json({
          loginResult: { nick: rows[0].manager_nick, name: rows[0].user_name },
        });
      }
    } else {
      console.log("로그인 실패!");
      res.json({ loginResult: false });
    }
  });
});
// 로그인 끝 ---------------------------------------------------------------------------------

module.exports = router;
