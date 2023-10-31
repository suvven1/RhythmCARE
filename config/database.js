const mysql = require("mysql2");

let conn = mysql.createConnection({
  host: "192.168.70.100", // 주소값
  user: "DNA", // workbench 가서 확인
  password: "eldpsdpdl12!@",
  port: 3306,
  database: "dna",
});

conn.connect();

module.exports = conn;
