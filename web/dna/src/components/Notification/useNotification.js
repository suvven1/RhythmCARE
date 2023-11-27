// useNotification.js 파일

import { useState } from "react";

const useNotification = (title, options) => {
  const [permission, setPermission] = useState("default");

  const fireNotif = () => {
    if (!("Notification" in window)) {
      console.error("This browser does not support desktop notification");
      return;
    }

    if (Notification.permission === "granted") {
      // options 객체에 icon 속성 추가
      new Notification(title, options);
    } else if (Notification.permission !== "denied") {
      Notification.requestPermission().then((result) => {
        setPermission(result);
        if (result === "granted") {
          // options 객체에 icon 속성 추가
          new Notification(title, options);
        } else {
          console.error("User denied notification permission");
        }
      });
    }
  };

  return fireNotif;
};

export default useNotification;
