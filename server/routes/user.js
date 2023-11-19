const express = require("express");
const router = express.Router();
const conn = require("../config/database");
const multer = require("multer");
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

// 회원가입 시작 -----------------------------------------------------------------------------------------------
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

  let joinMemberSql =
    "insert into t_member values (?,SHA2(?,384),?,?,?,?,?,null,NOW())";

  conn.query(
    joinMemberSql,
    [id, pw, mName, nick, mBirth, mGender, mPhone],
    (err, rows) => {
      if (rows) {
        joinUser();
      } else {
        console.log("보호자 회원가입 실패!", err);
        res.json({ joinResult: false });
      }
    }
  );

  // 기기사용자 정보 insert
  const joinUser = () => {
    let joinUserSql = "insert into t_user values (?,?,?,?,?,?)";

    conn.query(
      joinUserSql,
      [id, uName, nick, uBirth, uGender, uPhone],
      (err, rows) => {
        if (rows) {
          setAttend();
        } else {
          console.log("사용자 회원가입 실패!", err);
          deleteMember();
        }
      }
    );
  };

  // 출석 정보 초기값 insert
  const setAttend = () => {
    let attendSql =
      "INSERT INTO t_attendance (attd_time, mem_id, attd_continuous, attd_accumulate) VALUES ('2000-01-01', ?, 0, 0);";

    conn.query(attendSql, [id], (err, rows) => {
      if (rows) {
        console.log("출석 데이터 입력 성공");
        initAttendInx();
      } else {
        console.log("출석 데이터 입력 실패", err);
        deleteMember();
      }
    });
  };

  // 출석정보 인덱스 초기화
  const initAttendInx = () => {
    let setCountSql = "set @count=0;";
    let setAttendIndexSql =
      "update t_attendance set attd_idx=@count:=@count+1;";
    conn.query(setCountSql, [], (err, rows) => {
      if (err) {
        console.log("set @count=0 실패!", err);
        deleteMember();
      } else {
        conn.query(setAttendIndexSql, [], (err, rows) => {
          if (err) {
            console.log("인덱스 초기화 실패!", err);
            deleteMember();
          } else {
            console.log("회원가입 성공");
            res.json({ joinResult: true });
          }
        });
      }
    });
  };

  // 기기사용자 정보 입력 에러시 전 단계에서 insert 된 member 데이터 삭제
  const deleteMember = () => {
    let deleteMemberSql = "delete from t_member where mem_id=?";
    conn.query(deleteMemberSql, [id], (err, rows) => {
      if (err) {
        console.log("보호자 데이터 삭제 실패!", err);
        res.json({ joinResult: false });
      } else {
        console.log("보호자 데이터 삭제 성공!");
        res.json({ joinResult: false });
      }
    });
  };
});

// 아이디 중복체크
router.post("/join/idDupCheck", (req, res) => {
  console.log("user join idDupCheck", req.body);
  let { id } = req.body;
  let idDupCheckSql = "select * from t_member where mem_id=?";
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
  let nickDupCheckSql = "select * from t_member where mem_nick=?";
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
// 회원가입 끝 -------------------------------------------------------------------------------------------------
//
//
//
//
//
//
// 로그인 시작 -----------------------------------------------------------------------------------------------

// 로그인
router.post("/login", (req, res) => {
  console.log("login", req.body);
  let { user, id, pw } = req.body;
  let loginSql = `select ${user}.${user}_name,mem.mem_nick 
                    from t_member as mem left join t_user as user
                      on mem.mem_id = user.mem_id
                   where mem.mem_id = ? and mem.mem_pw =sha2(?,384)`;
  conn.query(loginSql, [id, pw], (err, loginRows) => {
    console.log(loginRows);
    if (err) {
      console.log("[LOGIN ERROR] : ", err);
      res.json({ loginResult: false });
    } else if (loginRows.length != 0) {
      console.log("Success Login!", loginRows[0]);
      res.json({
        loginResult: {
          name: loginRows[0][`${user}_name`],
          nick: loginRows[0].mem_nick,
        },
      });
    } else {
      console.log("Fail Login!");
      res.json({ loginResult: true });
    }
  });
});

// 로그인 끝 -------------------------------------------------------------------------------------------------
//
//
//
//
//
//
// 회원정보 조회 시작 -------------------------------------------------------------------------------------------------

// 뱃지 데이터 조회
let badgeData = [];
const getbadgeData = (id) => {
  let badgeSql = "select badge_id from t_reward where mem_id =?";
  conn.query(badgeSql, [id], (err, badgeRows) => {
    if (badgeRows.length != 0) {
      badgeData = badgeRows.map((item) => item.badge_id);
    }
  });
};

// 회원정보 조회
router.post("/getUserData", (req, res) => {
  console.log("getUserData", req.body);
  let { id } = req.body;
  getbadgeData(id);
  let getUserDataSql = `select mem.mem_id,
            mem.mem_name,
            mem.mem_nick,
            mem.mem_birthdate,
            mem.mem_phone,
            mem.mem_profile_img,
            user.mem_id,
            user.user_name,
            user.user_birthdate,
            user.user_phone 
       from t_member as mem left join t_user as user
         on mem.mem_id = user.mem_id
      where mem.mem_id = ?`;
  conn.query(getUserDataSql, [id], (err, userDataRows) => {
    if (err) {
      console.log("Fail getUserData!", err);
      res.json({ userData: false });
    } else {
      console.log("Success getUserData!");
      console.log("Success getBadgeData!");
      // 뱃지 데이터 초기화
      userDataRows[0].badge = badgeData;

      // 보호자 생년월일 전처리
      mem_birth = userDataRows[0].mem_birthdate;
      mem_birth.setDate(mem_birth.getDate() + 1);
      userDataRows[0].mem_birthdate = mem_birth.toISOString().split("T")[0];

      // 사용자 생년월일 전처리
      user_birth = userDataRows[0].user_birthdate;
      user_birth.setDate(user_birth.getDate() + 1);
      userDataRows[0].user_birthdate = user_birth.toISOString().split("T")[0];

      res.json({ userData: userDataRows[0] });

      // 전송 후 뱃지 데이터 삭제
      badgeData = [];
    }
  });
});
// 회원정보 조회 끝 ---------------------------------------------------------------------------------------------------
//
//
//
//
//
//
// 내 정보 수정 시작--------------------------------------------------------------------------------------------
// 닉네임 변경
router.post("/changeNick", (req, res) => {
  console.log("changeNick", req.body);
  let { id, nick } = req.body;
  let changeNickSql = "update t_member set mem_nick=? where mem_id=?";
  conn.query(changeNickSql, [nick, id], (err, rows) => {
    if (!err) {
      console.log("닉네임 변경 성공!");
      res.json({ changeNickResult: true });
    } else {
      console.log("닉네임 변경 실패!", err);
      res.json({ changeNickResult: false });
    }
  });
});

// 비밀번호 변경
router.post("/changePw", (req, res) => {
  console.log("changePw", req.body);
  let { id, changePw } = req.body;
  let changePwSql = "update t_member set mem_pw=SHA2(?,384) where mem_id=?";
  conn.query(changePwSql, [changePw, id], (err, rows) => {
    if (rows) {
      console.log("비밀번호 변경 성공!");
      res.json({ changePwResult: true });
    } else {
      console.log("비밀번호 변경 실패!", err);
      res.json({ changePwResult: false });
    }
  });
});

// 이미지 변경
router.post("/changeImg", upload.single("image"), (req, res) => {
  console.log("changeImg", req.file);
  console.log("userID", req.body);
  if (req.file != undefined) {
    console.log("try setImg");
    let img = req.file.buffer;
    let id = req.body.id;
    let imgSql = "update t_member set mem_profile_img=? where mem_id=?";
    conn.query(imgSql, [img, id], (err, rows) => {
      if (rows) {
        console.log("이미지 변경 성공!");
        res.json({ chageImgResult: true });
      } else {
        console.log("이미지 변경 실패!", err);
        res.json({ chageImgResult: false });
      }
    });
  }
});
// 내 정보 수정 끝----------------------------------------------------------------------------------------------
//
//
//
//
//
//
// 회원탈퇴 변경 시작 ------------------------------------------------------------------------------------------
router.post("/delete", (req, res) => {
  console.log("delete", req.body);
  let { id, pw } = req.body;
  let deleteSql = "delete from t_member where mem_id=? and mem_pw=SHA2(?,384)";
  conn.query(deleteSql, [id, pw], (err, rows) => {
    if (rows.affectedRows == 1) {
      console.log("[탈퇴] 회원탈퇴 성공!", rows);
      res.json({ deleteResult: true });
    } else {
      console.log("[탈퇴] 회원탈퇴 실패!", err);
      res.json({ deleteResult: false });
    }
  });
});
// 회원탈퇴 변경 끝 --------------------------------------------------------------------------------------------

module.exports = router;
