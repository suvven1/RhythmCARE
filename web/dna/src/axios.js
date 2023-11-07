import axios from "axios";

const instance = axios.create({
  baseURL: "http://172.31.47.175:3333",
});

export default instance;
