import axios from "axios";

const instance = axios.create({
  // baseURL: "http://3.34.97.212:3333",
  baseURL: "http://115.95.222.206:80",
  // baseURL: "http://192.168.70.180:3333",
  // baseURL: "http://192.168.1.106:3333",
});

export default instance;
