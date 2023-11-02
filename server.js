const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const indexRouter = require("./routes");
const userRouter = require("./routes/user");
const path = require("path");
const cors = require("cors");

// CORS 오류 해결을 위한 미들웨어
app.use(cors());
app.use(express.json());

app.use(express.static(path.join(__dirname, "web", "dna", "build")));
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "web", "dna", "build", "index.html"));
});
app.use("/", indexRouter);
app.use("/user", userRouter);
app.use(bodyParser.urlencoded({ extended: true }));
app.set("port", process.env.PORT || 3333);
app.listen(app.get("port"), () => {
  console.log(app.get("port"), "port waiting...");
});
