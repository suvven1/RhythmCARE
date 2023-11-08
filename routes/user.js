const express = require("express");
const router = express.Router();
const conn = require("../config/database");
const multer = require("multer");

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

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
  let joinSql = "insert into user values (?,?,?,?,?,?,?,?,?,?,?,null)";
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
  let idDupCheckSql = "select * from user where manager_id=?";
  conn.query(idDupCheckSql, [id], (err, rows) => {
    if (rows.length != 0) {
      console.log("ID 중복");
      res.json({ idDupResult: false });
    } else {
      console.log("사용 가능한 ID");
      res.json({ idDupResult: true });
    }
  });
});

// 닉네임 중복체크
router.post("/join/nickDupCheck", (req, res) => {
  console.log("user join nickDupCheck", req.body);
  let { nick } = req.body;
  let nickDupCheckSql = "select * from user where manager_nick=?";
  conn.query(nickDupCheckSql, [nick], (err, rows) => {
    if (rows.length != 0) {
      console.log("Nick 중복");
      res.json({ nickDupResult: false });
    } else {
      console.log("사용 가능한 Nick");
      res.json({ nickDupResult: true });
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
            data: rows[0],
          },
        });
      } else {
        res.json({
          loginResult: {
            nick: rows[0].manager_nick,
            name: rows[0].user_name,
            data: rows[0],
          },
        });
      }
    } else {
      console.log("로그인 실패!");
      res.json({ loginResult: false });
    }
  });
});
// 로그인 끝 ---------------------------------------------------------------------------------

// 비밀번호 변경 시작 -------------------------------------------------------------------------------
router.post("/changePw", (req, res) => {
  console.log("changePw", req.body);
  let { id, changePw } = req.body;
  let changePwSql = "update user set password=? where manager_id=?";
  conn.query(changePwSql, [changePw, id], (err, rows) => {
    if (rows) {
      console.log("비밀번호 변경 성공!");
      res.json({ changePwResult: true });
    } else {
      console.log("비밀번호 변경 실패!");
      res.json({ changePwResult: false });
    }
  });
});
// 비밀번호 변경 끝 ---------------------------------------------------------------------------------

// 닉네임 변경 시작 -------------------------------------------------------------------------------
router.post("/changeNick", (req, res) => {
  console.log("changeNick", req.body);
  let { id, nick } = req.body;
  let changeNickSql = "update user set manager_nick=? where manager_id=?";
  conn.query(changeNickSql, [nick, id], (err, rows) => {
    if (rows) {
      console.log("닉네임 변경 성공!");
      res.json({ changeNickResult: true });
    } else {
      console.log("닉네임 변경 실패!");
      res.json({ changeNickResult: false });
    }
  });
});
// 닉네임 변경 끝 ---------------------------------------------------------------------------------

// 회원탈퇴 변경 시작 -------------------------------------------------------------------------------
router.post("/delete", (req, res) => {
  console.log("delete", req.body);
  let { id } = req.body;
  let deleteSql = "delete from user where manager_id=?";
  conn.query(deleteSql, [id], (err, rows) => {
    if (rows) {
      console.log("[탈퇴] 회원탈퇴 성공!");
      res.json({ deleteResult: true });
    } else {
      console.log("[탈퇴] 회원탈퇴 실패!");
      res.json({ deleteResult: false });
    }
  });
});
// 회원탈퇴 변경 끝 ---------------------------------------------------------------------------------

// 이미지 변경 시작 ---------------------------------------------------------------------------------
router.post("/changeImg", upload.single("image"), (req, res) => {
  console.log("changeImg", req.file);
  console.log("userID", req.body);
  if (req.file != undefined) {
    console.log("try setImg");
    let img = req.file.buffer;
    let id = req.body.id;
    let imgSql = "update user set img=? where manager_id=?";
    conn.query(imgSql, [img, id], (err, rows) => {
      if (rows) {
        console.log("이미지 변경 성공!");
        res.json({ chageImgResult: true, img: img });
      } else {
        console.log("이미지 변경 실패!", err);
        res.json({ chageImgResult: false });
      }
    });
  }
});
// 이미지 변경 끝 -----------------------------------------------------------------------------------
module.exports = router;
