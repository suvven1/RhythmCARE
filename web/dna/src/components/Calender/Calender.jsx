import React, { useEffect, useRef, useState } from 'react';
import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';
import styled from 'styled-components';
import ScheduleModal from './Schedule_m';

function Calendar() {
  const calendarRef = useRef(null);
  const [selectedDate, setSelectedDate] = useState(null);
  const [showModal, setShowModal] = useState(false);
  const [events, setEvents] = useState([
    {
      title: '',
      start: '',
      end: '',
      backgroundColor: '',
    }
  ])

  const handleDateClick = (arg) => {
    setSelectedDate(arg.dateStr); // 선택된 날짜를 상태에 저장
  };

  useEffect(() => {
    // 날짜선택 옵션변경(불가능-> 가능)
    const calendarApi = calendarRef.current.getApi();
    calendarApi.setOption('selectable', true);
    calendarApi.render();

    // 새로고침시 오늘날짜 가져오기
    const today = new Date(); // 오늘 날짜 가져오기
    calendarApi.select(today); // 오늘 날짜 선택
    setSelectedDate(today.toISOString().split('T')[0]);
  }, [])

  // 오늘 일정보기
  const handleTodayClick = () => {
    const today = new Date();
    const calendarApi = calendarRef.current.getApi();
    calendarApi.gotoDate(today);
    calendarApi.select(today);
    setSelectedDate(today.toISOString().split('T')[0]);
  }

  // 일정추가하기 - 열기
  const handleAddSchedule = ({ title, start, end, color }) => {

    const newEvent = {
      title,
      start,
      end,
      backgroundColor: color,
    };
    setEvents((prevEvents) => [...prevEvents, newEvent])
    setShowModal(true);
  }

  // 일정추가하기 - 닫기
  const closeModal = () => {
    setShowModal(false)
  }

  const renderSelectedDateEvents = () => {
    if (!selectedDate) return null;

    // 선택된 날짜 이후의 날짜 중 가장 늦은 날짜 구하기
    const endOfSelectedDate = new Date(selectedDate);
    endOfSelectedDate.setDate(endOfSelectedDate.getDate() + 1); // 다음 날짜로 설정

    // 선택된 날짜 범위 내에 포함되는 이벤트 찾기
    const selectedDateEvents = events.filter(
      (event) => event.start <= selectedDate && event.end >= endOfSelectedDate.toISOString().split('T')[0]
    );

    // 선택된 날짜 범위 내의 이벤트를 각 날짜에 대해 표시
    return (
      <div>
        {selectedDateEvents.map((event) => (
          <p key={event.title}>{event.title}</p>
        ))}
      </div>
    );
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
          headerToolbar={{ start: 'prev', center: 'title', end: 'next' }}
        />
      </CalenderBack>
      <div className='blank' />
      <ScheduleBox>
        <ScheduleBack>
          <button className="todaySchedule" onClick={() => handleTodayClick(calendarRef.current.getApi())}>오늘 일정 보기</button>
          <p className='select_month'>{selectedDate ? getMonthName(selectedDate) : ''}</p>
          <p className='select_day'>{selectedDate ? selectedDate.substring(8) : ''}</p>
          <p className='schedule_title'>✨일정 리스트✨</p>
          {renderSelectedDateEvents()}
        </ScheduleBack>
        <div>
          <button className='addScheduleBtn' onClick={() => setShowModal(true)}>일정 추가하기</button>
          {showModal && <ScheduleModal onClose={closeModal} handleAddSchedule={handleAddSchedule} />}
        </div>
      </ScheduleBox>
    </CalendarBox>
  );
}

// 월표시 영어 약자 코드
function getMonthName(date) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  const monthIndex = parseInt(date.substring(5, 7), 10) - 1;
  return months[monthIndex];
}


export default Calendar;

const CalendarBox = styled.div`
background-color: #F5F5F5;
height : 855px;
display: flex;
justify-content: center;

  & .blank{
    width: 30px;
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

/* calendar css ------------- */
  // fullCalendar 전체
  
  & .fc{
      width: 100%;
      height: 95%;
  };

  .fc-dayGridMonth-view .fc-day-today {
  background-color: #4e3e9530 !important;
  }

  .fc-dayGridMonth-view .fc-day-selected-date {
  background-color: #cae6ef !important;
  }

  // 일요일 - 빨간색
  & .fc-day-sun a{
    color: #e05151;
  }
  
  // 토요일 - 파란색
  & .fc-day-sat a{
    color: #347dc1;
  }

  // 주말 제외 요일
  & .fc-day{
    color: #8092a3;
  }

  & .fc-button{
    padding: 5px 5px;
    margin: 5px 20px 0px 20px;
    background-color: #2e2288;
    border: none;
  }

  // 일정 border 지우기
  .fc-event, .fc-event-container {
  border: none !important;
}


`;

// 일정-----------------------
const ScheduleBox = styled.div`
  background-color: #F5F5F5;
  width: 17%;
  height: 700px;
  margin-right: 300px;
  
  & .addScheduleBtn {
    background-color: #2e2288;
    width: 100%;
    color: white;
    border-radius:20px ;
    font-size: 20px;
    border: none;
    padding: 25px 0px;
    margin-top: 30px;
    cursor: pointer;
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
    padding: 15px 0px;
    font-size: 15px;
    border-radius: 40px;
    border: none;
    margin-top : 40px;
    cursor: pointer;
    width: 50%;
  }

  & p {
    text-align: center;
    
  }

  & .select_month{
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
  
  & .schedule_title{
    font-weight: bold;
    font-size: 20px;
    margin-top: -40px;
  }
`;