import axios from "axios";

const instance = axios.create({
  baseURL: "http://ec2-3-34-97-212.ap-northeast-2.compute.amazonaws.com:3333",
});

export default instance;
