const express = require("express");
const router = express.Router();
const conn = require("../config/database");

router.post("/dateCal", async (req, res) => {
  console.log("attend", req.body);
  let { id, today } = req.body;

  // 출석 정보 조회 함수
  const attendCheck = (id, today) => {
    let attendCheckSql = "select * from user_attend where manager_id=?";
    conn.query(attendCheckSql, [id], (err, rows) => {
      if (rows[0].login_dt != today) {
        if (today == 0) {
          res.json({
            total: rows[0].total_attend,
            con: rows[0].continue_attend,
          });
        } else {
          console.log(`${id} : 출석 정보 조회 성공!`);
          attendCal(rows[0], today);
        }
      } else {
        console.log(`${id} : 출석 정보 조회 실패!`);
      }
    });
  };

  // 출석 수 계산 함수
  const attendCal = (data, today) => {
    let { manager_id, total_attend, continue_attend, login_dt } = data;
    const todate = new Date(today).getTime();
    const login = new Date(login_dt).getTime();
    if (todate - login == 86400000) {
      console.log(`${manager_id} : 연속출석 성공!`);
      total_attend++;
      continue_attend++;
      attendInsert(manager_id, total_attend, continue_attend, today);
    } else {
      console.log(`${manager_id} : 연속출석 실패!`);
      total_attend++;
      continue_attend = 1;
      attendInsert(manager_id, total_attend, continue_attend, today);
    }
  };

  // 출석 수 DB 업로드 함수
  const attendInsert = (id, total, con, dt) => {
    let attendInsertSql =
      "update user_attend set total_attend=?, continue_attend=?, login_dt=? where manager_id=?";
    conn.query(attendInsertSql, [total, con, dt, id], (err, rows) => {
      if (rows) {
        console.log(`${id} : 출석 정보 업데이트 성공!`);
        attendCheck(id, 0);
      } else {
        console.log(`${id} : 출석 정보 업데이트 실패!`, err);
      }
    });
  };

  // 함수 실행
  attendCheck(id, today);
});

module.exports = router;
