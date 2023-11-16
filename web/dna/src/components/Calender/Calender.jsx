import React, { useContext, useEffect, useRef, useState } from "react";
import FullCalendar from "@fullcalendar/react";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction";
import styled from "styled-components";
import ScheduleModal from "./Schedule_m";
import DetailModal from "./detail_m";
import axios from "../../axios";
import { UserContext } from "../../context/UserContext";

function Calendar() {
  const userData = useContext(UserContext);
  const calendarRef = useRef(null);
  const [count, setCount] = useState(0);
  const [selectedDate, setSelectedDate] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const [selectedEvent, setSelectedEvent] = useState(null);
  const [showDetailModal, setShowDetailModal] = useState(false);
  const [events, setEvents] = useState([
    {
      key: "",
      title: "",
      start: "",
      end: "",
      backgroundColor: "",
    },
  ]);

  // 일정 정보 불러오기
  useEffect(() => {
    axios
      .post("/calender/getSchedule", { id: userData.data.manager_id })
      .then((res) => {
        if (res.data.scheduleData) {
          setCount(res.data.scheduleCount);
          res.data.scheduleData.map((schedule) => {
            const newEvent = {
              key: schedule.schedule_key,
              title: schedule.schedule_title,
              start: schedule.schedule_start,
              end: schedule.schedule_end,
              backgroundColor: schedule.schedule_color,
            };
            setEvents((prevEvents) => [...prevEvents, newEvent]);
          });
        }
      });
  }, []);

  const handleDateClick = (arg) => {
    setSelectedDate(arg.dateStr); // 선택된 날짜를 상태에 저장
  };

  useEffect(() => {
    // 날짜선택 옵션변경(불가능-> 가능)
    const calendarApi = calendarRef.current.getApi();
    calendarApi.setOption("selectable", true);
    calendarApi.render();

    // 새로고침시 오늘날짜 가져오기
    const today = new Date(); // 오늘 날짜 가져오기
    calendarApi.select(today); // 오늘 날짜 선택
    setSelectedDate(today.toISOString().split("T")[0]);
  }, []);

  // 오늘 일정보기
  const handleTodayClick = () => {
    const today = new Date();
    const calendarApi = calendarRef.current.getApi();
    calendarApi.gotoDate(today);
    calendarApi.select(today);
    setSelectedDate(today.toISOString().split("T")[0]);
  };

  // 일정추가하기 - 열기
  const handleAddSchedule = ({ key, title, start, end, color }) => {
    const newEvent = {
      key,
      title,
      start,
      end,
      backgroundColor: color,
    };
    setEvents((prevEvents) => [...prevEvents, newEvent]);
    setShowModal(true);
  };

  // 일정추가하기 - 닫기
  const closeModal = () => {
    setShowModal(false);
  };

  // 캘린더에 일정 렌더링하기
  const renderSelectedDateEvents = () => {
    if (!selectedDate) return null;

    // 선택된 날짜 이후의 날짜 중 가장 늦은 날짜 구하기
    const endOfSelectedDate = new Date(selectedDate);
    endOfSelectedDate.setDate(endOfSelectedDate.getDate() + 1); // 다음 날짜로 설정

    // 선택된 날짜 범위 내에 포함되는 이벤트 찾기
    const selectedDateEvents = events.filter(
      (event) =>
        event.start <= selectedDate &&
        event.end >= endOfSelectedDate.toISOString().split("T")[0]
    );

    // 선택된 날짜 범위 내의 이벤트를 각 날짜에 대해 표시
    return (
      <div>
        {selectedDateEvents.map((event) => (
          <EventContainer key={event.key}>
            <EventColor
              onClick={() => handleEventClick(event)}
              color={event.backgroundColor}
            />
            <EventTitle
              onClick={() => handleEventClick(event)}
              color={event.backgroundColor}
            >
              {event.title}
            </EventTitle>
          </EventContainer>
        ))}
      </div>
    );
  };

  const handleEventClick = (event) => {
    // 선택된 일정 정보를 상태에 저장하고 모달을 엽니다.
    setSelectedEvent(event);
    setShowDetailModal(true);
  };

  // 일정 삭제하기
  const handleDeleteSchedule = () => {
    // 선택된 이벤트가 없다면 무시
    if (!selectedEvent) return;

    // 선택된 이벤트를 제외한 나머지 이벤트들로 배열을 업데이트
    const updatedEvents = events.filter((event) => event !== selectedEvent);

    // 캘린더 상태 업데이트
    setEvents(updatedEvents);

    // 상세 모달 닫기
    setShowDetailModal(false);
  };

  return (
    <CalendarBox>
      <CalenderBack>
        <FullCalendar
          plugins={[dayGridPlugin, timeGridPlugin, interactionPlugin]}
          initialView="dayGridMonth" // 초기 뷰 설정 (월별)
          events={events}
          ref={calendarRef}
          dateClick={handleDateClick}
          eventClick={handleEventClick}
          headerToolbar={{ start: "prev", center: "title", end: "next" }}
        />
      </CalenderBack>
      <div className="blank" />
      <ScheduleBox>
        <ScheduleBack>
          <div className="schedule_div">
            <button
              className="todaySchedule"
              onClick={() => handleTodayClick(calendarRef.current.getApi())}
            >
              오늘 일정 보기
            </button>
            <p className="select_month">
              {selectedDate ? getMonthName(selectedDate) : ""}
            </p>
            <p className="select_day">
              {selectedDate ? selectedDate.substring(8) : ""}
            </p>
          </div>
          <div className="schedule_div">
            <p className="schedule_title">✨일정 리스트✨</p>
            {renderSelectedDateEvents()}
          </div>
        </ScheduleBack>
        <div>
          <button className="addScheduleBtn" onClick={() => setShowModal(true)}>
            일정 추가하기
          </button>
          {showModal && (
            <ScheduleModal
              onClose={closeModal}
              handleAddSchedule={handleAddSchedule}
              setCount={setCount}
              count={count}
            />
          )}
          {showDetailModal && (
            <DetailModal
              onClose={() => setShowDetailModal(false)}
              event={selectedEvent}
              onDeleteSchedule={handleDeleteSchedule}
            />
          )}
        </div>
      </ScheduleBox>
    </CalendarBox>
  );
}

// 월표시 영어 약자 코드
function getMonthName(date) {
  const months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  const monthIndex = parseInt(date.substring(5, 7), 10) - 1;
  return months[monthIndex];
}

export default Calendar;

const CalendarBox = styled.div`
  background-color: #f5f5f5;
  height: 855px;
  display: flex;
  justify-content: center;

  & .blank {
    width: 30px;
  }

  @media only screen and (max-width: 1040px) {
    height: 1200px;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
`;

// 캘린더 ----------------
const CalenderBack = styled.div`
  width: 50%;
  height: 700px;
  margin-top: 60px;
  margin-left: 300px;
  margin-bottom: 70px;
  background-color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 20px;

  @media only screen and (max-width: 1040px) {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-top: -500px;
    margin-left: 0px;
    width: 80%;
    height: 600px;
  }

  /* calendar css ------------- */
  // fullCalendar 전체

  & .fc {
    width: 100%;
    height: 95%;
  }

  .fc-dayGridMonth-view .fc-day-today {
    background-color: #4e3e9530 !important;
  }

  .fc-dayGridMonth-view .fc-day-selected-date {
    background-color: #cae6ef !important;
  }

  // 일요일 - 빨간색
  & .fc-day-sun a {
    color: #e05151;
  }

  // 토요일 - 파란색
  & .fc-day-sat a {
    color: #347dc1;
  }

  // 주말 제외 요일
  & .fc-day {
    color: #8092a3;
  }

  & .fc-button {
    padding: 5px 5px;
    margin: 5px 20px 0px 20px;
    background-color: #2e2288;
    border: none;
  }

  // 일정 border 지우기
  .fc-event,
  .fc-event-container {
    border: none !important;
  }

  .fc-event-title:hover {
    cursor: default;
  }
`;

// 일정-----------------------
const ScheduleBox = styled.div`
  background-color: #f5f5f5;
  width: 17%;
  height: 700px;
  margin-right: 300px;

  & .addScheduleBtn {
    background-color: #2e2288;
    width: 100%;
    color: white;
    border-radius: 20px;
    font-size: 20px;
    border: none;
    padding: 25px 0px;
    margin-top: 30px;
    cursor: pointer;
  }

  @media only screen and (max-width: 1040px) {
    width: 80%;
    margin-top: -50px;
    margin-right: 0px;
    height: 0px;

    & .addScheduleBtn {
      padding: 15px 0px;
    }
  }
`;

const ScheduleBack = styled.div`
  background-color: white;
  width: 100%;
  height: 85%;
  margin-top: 60px;
  border-radius: 20px;
  display: flex;
  align-items: center;
  flex-direction: column;
  & .todaySchedule {
    background-color: #2e2288;
    color: white;
    padding: 15px 50px;
    font-size: 15px;
    border-radius: 40px;
    border: none;
    margin-top: 40px;
    cursor: pointer;
    width: 100%;
  }

  & p {
    text-align: center;
  }

  & .select_month {
    font-size: 25px;
    font-weight: bold;
    color: #2e2288;
  }

  & .select_day {
    font-size: 90px;
    font-weight: bold;
    color: #2e2288;
    margin-top: -40px;
  }

  & .schedule_title {
    font-weight: bold;
    font-size: 20px;
    margin-top: -40px;
  }

  @media only screen and (max-width: 1040px) {
    display: flex;
    flex-direction: row;
    justify-content: center;
    height: 300px;

    & .schedule_div {
      width: 100%;
      display: flex;
      margin-top: 50px;
      justify-content: center;
      align-items: center;
      flex-direction: column;
    }

    & .todaySchedule {
      padding: 10px 0px;
      font-size: 13px;
      width: 80%;
    }

    & .schedule_title {
      font-weight: bold;
      font-size: 20px;
      margin-top: -90px;
    }
  }
`;

const EventContainer = styled.div`
  display: flex;
  align-items: center;
  justify-content: start;
  gap: 10px;

  @media only screen and (max-width: 1040px) {
    align-items: center;
    display: flex;
    align-items: center;
  }
`;

const EventColor = styled.div`
  background-color: ${({ color }) => color};
  width: 15px;
  height: 15px;
`;

const EventTitle = styled.p`
  cursor: pointer;
`;
