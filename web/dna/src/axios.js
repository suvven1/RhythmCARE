import axios from "axios";

const instance = axios.create({
  // baseURL: "http://3.34.97.212:3333",
  baseURL: "http://115.95.222.206:80",
  // baseURL: "http://192.168.70.180:3333",
  // baseURL: "http://39.114.134.184:80",
});

export default instance;
