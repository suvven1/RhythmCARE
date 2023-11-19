const express = require("express");
const router = express.Router();
const conn = require("../config/database");

// 캘린더 정보 조회
router.post("/getSchedule", (req, res) => {
  console.log("getSchedule", req.body);
  let { id } = req.body;
  let getScheduleSql =
    "select * from t_schedule where mem_id=? order by sche_idx";
  conn.query(getScheduleSql, [id], (err, rows) => {
    if (err) {
      console.log("캘린더 정보 조회 실패!");
      res.json({
        scheduleData: false,
      });
    } else {
      console.log("캘린더 정보 조회 성공!");
      rows.map((schedule) => {
        schedule.sche_idx = schedule.sche_idx.toString();
        schedule.started_at.setDate(schedule.started_at.getDate() + 1);
        schedule.ended_at.setDate(schedule.ended_at.getDate() + 2);
      });
      res.json({
        scheduleData: rows,
      });
    }
  });
});

// 캘린더 업로드
router.post("/updateSchedule", (req, res) => {
  console.log("updateSchedule", req.body);
  let { id, title, start, end, color } = req.body;
  let updateScheduleSql =
    "insert into t_schedule(mem_id, sche_title, started_at, ended_at, sche_color) values (?,?,?,?,?)";
  conn.query(updateScheduleSql, [id, title, start, end, color], (err, rows) => {
    if (err) {
      console.log("캘린더 정보 저장 실패!", err);
      res.json({
        updateScheduleResult: false,
        key: false,
      });
    } else {
      console.log("캘린더 정보 저장 성공!");
      initScheduleInx();
      res.json({
        updateScheduleResult: true,
      });
    }
  });
});

// 일정 삭제
router.post("/deleteSchedule", (req, res) => {
  console.log("deleteSchedule", req.body);
  let { id, key } = req.body;
  let deleteSchedule = "delete from t_schedule where mem_id=? and sche_idx=?";
  conn.query(deleteSchedule, [id, key], (err, rows) => {
    if (rows) {
      console.log("일정 삭제 성공");
      res.json({ deleteScheduleResult: true });
      initScheduleInx();
    } else {
      console.log("일정 삭제 실패!", err);
      res.json({ deleteScheduleResult: false });
    }
  });
});

// 켈린더 인덱스 초기화
const initScheduleInx = () => {
  let setCountSql = "set @count=0;";
  let setScheduleIndexSql = "update t_schedule set sche_idx=@count:=@count+1;";
  conn.query(setCountSql, [], (err, rows) => {
    if (err) {
      console.log("set @count=0 실패!", err);
    } else {
      conn.query(setScheduleIndexSql, [], (err, rows) => {
        if (err) {
          console.log("인덱스 초기화 실패!", err);
        } else {
          console.log("인덱스 초기화 성공");
        }
      });
    }
  });
};
module.exports = router;
