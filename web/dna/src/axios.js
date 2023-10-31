import axios from "axios";

const instance = axios.create({
  baseURL: "http://192.168.137.1:3333",
});

export default instance;
