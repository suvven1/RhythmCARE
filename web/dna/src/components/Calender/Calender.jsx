import React, {useState} from "react";
import Calendar from "react-calendar";
import 'react-calendar/dist/Calendar.css' ; 
import styled from "styled-components";

const Calender = () => {
  const [date, setDate] = useState(new Date());

  const onChange = (date) => {
    setDate(date)
  }
  return (
  <CalendarWrapper >
    <Calendar onChange={onChange} value={date} />
    <SelectedDate>Selected date: {date.toDateString()}</SelectedDate>
  </CalendarWrapper>
    );
};

export default Calender;

// 캘린더를 감싸는 스타일드 컴포넌트
const CalendarWrapper = styled.div`
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 8px;
`;



// 선택된 날짜를 표시하는 스타일드 컴포넌트
const SelectedDate = styled.p`
  margin-top: 20px;
  font-size: 18px;
  color: #333;
`;