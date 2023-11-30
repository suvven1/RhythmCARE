const express = require("express");
const router = express.Router();
const pool = require("../config/database");

// 캘린더 정보 조회
router.post("/getSchedule", async (req, res) => {
  console.log("getSchedule", req.body);
  let { id } = req.body;
  let getScheduleSql =
    "select * from t_schedule where mem_id=? order by sche_idx";

  try {
    const [rows] = await pool.query(getScheduleSql, [id]);
    console.log("캘린더 정보 조회 성공!");
    rows.map((schedule) => {
      schedule.sche_idx = schedule.sche_idx.toString();
      schedule.started_at.setHours(schedule.started_at.getHours() + 9);
      schedule.ended_at.setHours(schedule.ended_at.getHours() + 33);
    });
    res.json({
      scheduleData: rows,
    });
  } catch (err) {
    console.log("[ERROR] 캘린더 정보 조회 실패!", err);
    res.json({
      scheduleData: false,
    });
  }
});

// 캘린더 업로드
router.post("/updateSchedule", async (req, res) => {
  console.log("updateSchedule", req.body);
  let { id, title, start, end, color } = req.body;
  let updateScheduleSql =
    "insert into t_schedule(mem_id, sche_title, started_at, ended_at, sche_color) values (?,?,?,?,?)";

  try {
    await pool.query(updateScheduleSql, [id, title, start, end, color]);
    console.log("캘린더 정보 저장 성공!");
    await initScheduleInx();
    res.json({
      updateScheduleResult: true,
    });
  } catch (err) {
    console.log("캘린더 정보 저장 실패!", err);
    res.json({
      updateScheduleResult: false,
      key: false,
    });
  }
});

// 일정 삭제
router.post("/deleteSchedule", async (req, res) => {
  console.log("deleteSchedule", req.body);
  let { id, key } = req.body;
  let deleteScheduleSql =
    "delete from t_schedule where mem_id=? and sche_idx=?";

  try {
    await pool.query(deleteScheduleSql, [id, key]);
    console.log("일정 삭제 성공");
    res.json({ deleteScheduleResult: true });
    await initScheduleInx();
  } catch (err) {
    console.log("일정 삭제 실패!", err);
    res.json({ deleteScheduleResult: false });
  }
});

// 켈린더 인덱스 초기화
const initScheduleInx = async () => {
  let setCountSql = "set @count=0;";
  let setScheduleIndexSql = "update t_schedule set sche_idx=@count:=@count+1;";

  try {
    await pool.query(setCountSql);
    try {
      await pool.query(setScheduleIndexSql);
      console.log("인덱스 초기화 성공");
    } catch (err) {
      console.log("인덱스 초기화 실패!", err);
    }
  } catch (err) {
    console.log("set @count=0 실패!", err);
  }
};
module.exports = router;
