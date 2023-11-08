import axios from "axios";

const instance = axios.create({
  // baseURL: "http://3.34.97.212:3333",
  baseURL: "http://192.168.70.134:3333",
});

export default instance;
