const express = require("express");
const router = express.Router();
const conn = require("../config/database");

// 캘린더 정보 조회
router.post("/getSchedule", (req, res) => {
  console.log("getSchedule", req.body);
  let { id } = req.body;
  let getScheduleSql = "select * from schedule where manager_id=?";
  conn.query(getScheduleSql, [id], (err, rows) => {
    if (err) {
      console.log("캘린더 정보 조회 실패!");
      res.json({
        scheduleData: false,
        scheduleCount: false,
      });
    } else {
      console.log("캘린더 정보 조회 성공!");
      res.json({
        scheduleData: rows,
        scheduleCount: rows.length,
      });
    }
  });
});

// 캘린더 업로드
router.post("/updateSchedule", (req, res) => {
  console.log("updateSchedule", req.body);
  let { key, id, title, start, end, color } = req.body;
  let updateScheduleSql = "insert into schedule values (?,?,?,?,?,?)";
  conn.query(
    updateScheduleSql,
    [key, id, title, start, end, color],
    (err, rows) => {
      if (err) {
        console.log("캘린더 정보 저장 실패!", err);
        res.json({
          updateScheduleResult: false,
        });
      } else {
        console.log("캘린더 정보 저장 성공!");
        res.json({
          updateScheduleResult: true,
        });
      }
    }
  );
});

// 일정 삭제
router.post("/deleteSchedule", (req, res) => {
  console.log("deleteSchedule", req.body);
  let { id, key } = req.body;
  let deleteSchedule =
    "delete from schedule where manager_id=? and schedule_key=?";
  conn.query(deleteSchedule, [id, key], (err, rows) => {
    if (rows) {
      console.log("일정 삭제 성공!");
      res.json({ deleteScheduleResult: true });
    } else {
      console.log("일정 삭제 실패!", err);
      res.json({ deleteScheduleResult: false });
    }
  });
});

module.exports = router;
