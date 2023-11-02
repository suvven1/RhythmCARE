import axios from "axios";

const instance = axios.create({
  baseURL: "http://115.95.222.206:80",
});

export default instance;
