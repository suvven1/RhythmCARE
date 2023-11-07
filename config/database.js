const mysql = require("mysql2");

let conn = mysql.createConnection({
  host: "project-db-stu3.smhrd.com", // 주소값
  user: "Insa4_App_final_1", // workbench 가서 확인
  password: "aischool1",
  port: 3307,
  database: "Insa4_App_final_1",
});

conn.connect();

module.exports = conn;
