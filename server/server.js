const express = require("express");
const app = express();
const cluster = require("cluster");
const bodyParser = require("body-parser");
const boardRouter = require("./routes/board");
const commentRouter = require("./routes/comment");
const userRouter = require("./routes/user");
const attendRouter = require("./routes/attend");
const calenderRouter = require("./routes/calender");
const webSocketRouter = require("./routes/webSocket");
const path = require("path");
const cors = require("cors");

if (cluster.isMaster) {
  cluster.fork();
  cluster.fork();
  cluster.fork();
  cluster.fork();
} else {
  app.use(cors());
  app.use(express.json());
  app.set("port", process.env.PORT || 80);
  app.use("/board", boardRouter);
  app.use("/comment", commentRouter);
  app.use("/user", userRouter);
  app.use("/attend", attendRouter);
  app.use("/calender", calenderRouter);
  app.use("/webSocket", webSocketRouter);
  app.use(bodyParser.urlencoded({ extended: true }));
  app.use(express.static(path.join(__dirname, "..", "web", "dna", "build")));
  app.get("/*", (req, res) => {
    res.sendFile(
      path.join(__dirname, "..", "web", "dna", "build", "index.html")
    );
  });
  app.listen(app.get("port"), () => {
    console.log(app.get("port"), "port waiting...");
  });
}
