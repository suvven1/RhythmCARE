import React, { useEffect, useRef, useState } from 'react';
import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';
import styled from 'styled-components';

function Calendar() {
  const calendarRef = useRef(null);
  const [selectedDate, setSelectedDate] = useState(null);

  const events = [
    {
      title: '이벤트 1',
      start: '2023-11-08',
      end: '2023-11-10',
      backgroundColor: 'blue', // 이벤트 색상 지정 가능
    },
    // 다른 이벤트들을 추가할 수 있습니다.
  ];

  const handleDateClick = (arg) => {
    setSelectedDate(arg.dateStr); // 선택된 날짜를 상태에 저장
  };

  useEffect(()=> {
    // 날짜선택 옵션변경(불가능-> 가능)
    const calendarApi = calendarRef.current.getApi();
    calendarApi.setOption('selectable', true);
    calendarApi.render();

    // 새로고침시 오늘날짜 가져오기
    const today = new Date(); // 오늘 날짜 가져오기
    calendarApi.select(today); // 오늘 날짜 선택
    setSelectedDate(today.toISOString().split('T')[0]);
  }, [])

  const handleTodayClick = () => {
    const today = new Date();
    const calendarApi = calendarRef.current.getApi();
    calendarApi.gotoDate(today);
    calendarApi.select(today);
    setSelectedDate(today.toISOString().split('T')[0]);
  }

  return (
    <CalendarBox>
      <CalenderBack>
        <FullCalendar
          plugins={[ dayGridPlugin, timeGridPlugin, interactionPlugin ]}
          initialView="dayGridMonth" // 초기 뷰 설정 (월별)
          events={events}
          ref={calendarRef}
          dateClick={handleDateClick}
          headerToolbar = {{start:'prev', center:'title', end:'next'}}
        />
      </CalenderBack>
      <ScheduleBox>
        <ScheduleBack>
          <button className="todaySchedule" onClick={() => handleTodayClick(calendarRef.current.getApi())}>오늘 일정 보기</button>
          <p className='select_month'>{selectedDate ? getMonthName(selectedDate) : ''}</p>
          <p className='select_day'>{selectedDate ? selectedDate.substring(8) : ''}</p>
        </ScheduleBack>
        <div>
          <button className='addScheduleBtn'>일정 추가하기</button>

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
display: flex;
justify-content: space-between;
`;

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

  & .fc-header-toolbar-title{
    color : white !important;
    margin-top : 10px
  }


`;

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
`;