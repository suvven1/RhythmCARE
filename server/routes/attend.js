const express = require("express");
const router = express.Router();
const conn = require("../config/database");

router.post("/dateCal", async (req, res) => {
  console.log("attend", req.body);
  let { id, today } = req.body;
  let login_dt;
  let total_attend;
  let continue_attend;

  let attendCheckSql = "select * from t_attendance where mem_id=?";
  conn.query(attendCheckSql, [id], (err, rows) => {
    if (err) {
      console.log(`${id} : 출석 정보 조회 실패!`);
    } else {
      login_dt = rows[0].attd_time;
      login_dt.setDate(login_dt.getDate() + 1);
      login_dt = login_dt.toISOString().split("T")[0];
      total_attend = rows[0].attd_accumulate;
      continue_attend = rows[0].attd_continuous;

      if (login_dt == today) {
        res.json({ attendResult: false });
      } else {
        attendCal();
      }
    }
  });

  // 출석 수 계산 함수
  const attendCal = () => {
    const todate = new Date(today).getTime();
    const login = new Date(login_dt).getTime();
    if (todate - login == 86400000) {
      console.log(`${id} : 연속출석 성공!`);
      total_attend++;
      continue_attend++;
      attendInsert();
    } else {
      console.log(`${id} : 연속출석 실패!`);
      total_attend++;
      continue_attend = 1;
      attendInsert();
    }
  };

  // 출석 수 DB 업로드 함수
  const attendInsert = () => {
    let attendInsertSql =
      "update t_attendance set attd_accumulate=?, attd_continuous=?, attd_time=? where mem_id=?";
    conn.query(
      attendInsertSql,
      [total_attend, continue_attend, today, id],
      (err, rows) => {
        if (rows) {
          console.log(`${id} : 출석 정보 업데이트 성공!`);
          res.json({
            attendResult: {
              total: total_attend,
              continue: continue_attend,
            },
          });
        } else {
          console.log(`${id} : 출석 정보 업데이트 실패!`, err);
        }
      }
    );
  };
});

module.exports = router;
