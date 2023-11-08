import React from 'react';
import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';
import styled from 'styled-components';

function Calendar() {
  const events = [
    {
      title: '이벤트 1',
      start: '2023-11-08',
      end: '2023-11-10',
      backgroundColor: 'blue', // 이벤트 색상 지정 가능
    },
    // 다른 이벤트들을 추가할 수 있습니다.
  ];

  return (
    <CalendarBox>
      <CalenderBack>
        <FullCalendar
          plugins={[ dayGridPlugin, timeGridPlugin, interactionPlugin ]}
          initialView="dayGridMonth" // 초기 뷰 설정 (월별)
          events={events}
        />
      </CalenderBack>
      <ScheduleBack>
        <button>오늘</button>
        <p className='select_month'>Nov</p>
        <p className='select_day'>08</p>
      </ScheduleBack>
    </CalendarBox>
  );
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
background-color: pink;
display: flex;
align-items: center;
justify-content: center;
border-radius: 20px;

/* calendar css ------------- */
  // fullCalendar 전체
  & .fc{
      width: 100%;
      height: 100%;
      background-color: white;
  };

  // 일요일 - 빨간색
  & .fc-day-sun a{
    color: #e05151;
  }
  
  // 토요일 - 파란색
  & .fc-day-sat a{
    color: #347dc1;
  }

  & .fc-day{
    color: #212e3d;
  }



`;

const ScheduleBack = styled.div`
  background-color: white;
  width: 17%;
  height: 700px;
  margin-top: 60px;
  margin-right: 300px;
  border-radius: 10px;
  display: block;

  & button {
    background-color: #2e2288;
    color: white;
    padding: 10px 30px;
    font-size: 15px;
    border-radius: 40px;
    border: none;
    display: block;
    margin: 0 auto;
    text-align: center;
    margin-top: 30px;
  }

  & p {
    text-align: center;
    
  }

  & .select_month{
    font-size: 20px;
    font-weight: bold;
    color: #2e2288;
    
  }
  
  & .select_day {
    font-size: 100px;
    font-weight: bold;
    color: #2e2288;
    margin-top: -40px;
  }
`;


// -----------------------------------------------------------------------

// react-calendar 라이브러리 사용
// import React, { useState } from 'react';
// import Calendar from 'react-calendar';
// import 'react-calendar/dist/Calendar.css';
// import styled from 'styled-components';
// import moment from "momnet";

// function Calender() {
//   const [date, setDate] = useState(new Date());

//   const onChange = (date) => {
//     setDate(date);
//     // 선택된 날짜에 대한 작업 추가
//   };

//   const handleTodayClick =()=>{
//     setDate(new Date());
//   }

//   return (
//     <CalendarBox>
//       <CalenderBack>
//         <MyCalendar 
//           onChange={onChange} 
//           value={date} 
//           calendarType="US" 
//           formatDay={(locale, date) => moment(date).format("D")}/>

//       </CalenderBack>
//       <ScheduleBack>
//           <button onClick={handleTodayClick}>오늘 일정 보기</button>
//           <p>선택한 일자</p>
//           <p className='select_month'>{moment(date).format("MMM")}</p>
//           <p className='select_day'>{moment(date).format("DD")}</p>
//       </ScheduleBack>
      
//     </CalendarBox>
      
//   );
// }

// export default Calender;

// const CalendarBox = styled.div`
// background-color: #F5F5F5;
// display: flex;
// justify-content: space-between;
// `;

// const CalenderBack = styled.div`
// width: 50%;
// height: 700px;
// margin-top: 60px;
// margin-left: 300px;
// margin-bottom: 70px;
// display: flex;
// align-items: center;
// justify-content: center;
// `;

// const ScheduleBack = styled.div`
//   background-color: white;
//   width: 17%;
//   height: 700px;
//   margin-top: 60px;
//   margin-right: 300px;
//   border-radius: 10px;
//   display: block;

//   & button {
//     background-color: #2e2288;
//     color: white;
//     padding: 10px 30px;
//     font-size: 15px;
//     border-radius: 40px;
//     border: none;
//     display: block;
//     margin: 0 auto;
//     text-align: center;
//     margin-top: 30px;
//   }

//   & p {
//     text-align: center;
    
//   }

//   & .select_month{
//     font-size: 20px;
//     font-weight: bold;
//     color: #2e2288;
    
//   }
  
//   & .select_day {
//     font-size: 100px;
//     font-weight: bold;
//     color: #2e2288;
//     margin-top: -40px;
//   }


// `;

// // calender css-----------------
// const MyCalendar = styled(Calendar)`
//   width: 100%;
//   height: 100%;
//   background-color: #fff;
//   color: #222;
//   border-radius: 8px;
//   line-height: 1.125em;

// // 상단 년도, 월, 버튼(년, 월 변경)
// .react-calendar__navigation button {
//  color: #2e2288;
//  min-width: 44px;
//  background: none;
//  font-size: 20px;
//  font-weight: bold;
//  margin-top: 10px;
// }

// // 상단 년도, 월 버튼 hover & focus
// .react-calendar__navigation button:enabled:hover,
// .react-calendar__navigation button:enabled:focus {
//  background-color: #f8f8fa;
// }

// /* 상단 요일 */
// .react-calendar__month-view__weekdays__weekday{
//   background-color: #5c95d0;
  
//   color : white;
//   font-weight : normal;
// }

// // ?
// .react-calendar__navigation button[disabled] {
//  background-color: #f0f0f0;
// }

// // 상단 요일 text-decoration
// abbr[title] {
//  text-decoration: none;
// }

// /* 토요일 파란색 */
// .react-calendar__month-view__days__day--weekend:nth-child(7),
// .react-calendar__month-view__days__day--weekend:nth-child(14),
// .react-calendar__month-view__days__day--weekend:nth-child(21),
// .react-calendar__month-view__days__day--weekend:nth-child(28),
// .react-calendar__month-view__days__day--weekend:nth-child(35),
// .react-calendar__month-view__days__day--weekend:nth-child(42){
//   color: #347dc1;
// }

// /* 일요일 빨간색 */
// .react-calendar__month-view__days__day--weekend:nth-child(1),
// .react-calendar__month-view__days__day--weekend:nth-child(8),
// .react-calendar__month-view__days__day--weekend:nth-child(15),
// .react-calendar__month-view__days__day--weekend:nth-child(22),
// .react-calendar__month-view__days__day--weekend:nth-child(29),
// .react-calendar__month-view__days__day--weekend:nth-child(36){
//   color: #e05151; 
// }

// /* 날짜 hover & focus 컬러 */
// .react-calendar__tile:enabled:hover,
// .react-calendar__tile:enabled:focus {
//  background: #f8f8fa;
//  color: #6f48eb;
//  border-radius: 6px;
// }

// /* 오늘 날짜 */
// .react-calendar__tile--now {
//  background: #6f48eb33;
//  border-radius: 6px;
//  font-weight: bold;
//  color: #6f48eb;
// }

// /* 오늘날짜 hover & focus */
// .react-calendar__tile--now:enabled:hover,
// .react-calendar__tile--now:enabled:focus {
//  background: #6f48eb33;
//  border-radius: 6px;
//  font-weight: bold;
//  color: #6f48eb;
// }

// /* ? */
// .react-calendar__tile--hasActive:enabled:hover,
// .react-calendar__tile--hasActive:enabled:focus {
//  background: #f8f8fa;
 
// }
// .react-calendar__tile--active {
//  background: #6f48eb;
//  border-radius: 6px;
//  font-weight: bold;
//  color: white;
// }
// .react-calendar__tile--active:enabled:hover,
// .react-calendar__tile--active:enabled:focus {
//  background: #6f48eb;
//  color: white;
// }
// .react-calendar--selectRange .react-calendar__tile--hover {
//  background-color: #f8f8fa;
// }
// .react-calendar__tile--range {
//  background: #f8f8fa;
//  color: #6f48eb;
//  border-radius: 0;
// }
// .react-calendar__tile--rangeStart {
//  border-top-right-radius: 0;
//  border-bottom-right-radius: 0;
//  border-top-left-radius: 6px;
//  border-bottom-left-radius: 6px;
//  background: #6f48eb;
//  color: white;
// }
// .react-calendar__tile--rangeEnd {
//  border-top-left-radius: 0;
//  border-bottom-left-radius: 0;
//  border-top-right-radius: 6px;
//  border-bottom-right-radius: 6px;
//  background: #6f48eb;
//  color: white;
// }

// // 하경 추가
// .react-calendar__month-view__days__day abbr {
//   display: flex;
//   align-items: start;
//   justify-content: flex-start;
//   height: 100%;
//   margin: 0;
//   padding: 0 4px; 
// }

// .react-calendar__month-view__days{
//   width: auto;
//   height: 610px;
//   border : 1px solid black;
//   text-align: left;
// }

// `;

// -------------------------------------------------------------------------------------------------

// 라이브러리 없이 만들기 - 중간에 그만둠
// import React, { useCallback, useState } from "react";
// import classNames from "classnames/bind";

// const Calender = () => {
//   const toDay = {
//     year : new Date().getFullYear(),  // 오늘 연도
//     month : new Date().getMonth()+1,  // 오늘 월
//     date : new Date().getDate(),      // 오늘 날짜
//     day : new Date().getDay()         // 오늘 요일
//   }
//   const week = ["일", "월", "화", "수", "목", "금", "토"]
//   const [selectedYear, setSelectedYear] = useState(toDay.year);     // 현재 선택된 연도
//   const [selectedMonth, setSelectedMonth] = useState(toDay.month);  // 현재 선택된 달
//   const dateTotalCount = new Date(selectedYear, selectedMonth, 0).getDate();  // 선택된 연도, 달의 마자막날짜

//   // 이전 달 버튼
//   const preMonth = useCallback(()=>{
//     if(selectedMonth === 1){
//       setSelectedMonth(12)
//       setSelectedYear(selectedYear-1)
//     } else {
//       setSelectedMonth(selectedMonth-1)
//     }
//   }, [selectedMonth])

//   // 다음 달 버튼
//   const nextMonth = useCallback(()=>{
//     if(selectedMonth === 12){
//       setSelectedMonth(1)
//       setSelectedYear(selectedYear+1)
//     } else {
//       setSelectedMonth(selectedMonth+1)
//     }
//   }, [selectedMonth])

//   // 요일 반환
//   const returnWeek = useCallback(()=>{
//     let weekArr = []
//     week.forEach((v) => {
//       weekArr.push(
//         <div>
//         </div>
//       )
//     })
//   })


// };

// export default Calender;
