import 'package:dna/calendar/widget/event.dart';
import 'package:dna/calendar/widget/style.dart';
import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class calendarPage extends StatefulWidget {
  const calendarPage({super.key});

  @override
  State<calendarPage> createState() => _calendarPageState();
}

class _calendarPageState extends State<calendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  // // 범위 선택 날짜 변수/함수
  // DateTime? startDay;
  // DateTime? endDay;
  // void _onRangeSelected(DateTime? start, DateTime? end, DateTime focuseDay){
  //   setState(() {
  //     selectedDay = null;
  //     focusedDay = focuseDay;
  //     startDay = start;
  //     endDay = end;
  //   });
  // }

  // 일정추가
  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventCon = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<Event> _getEventsForDay(DateTime day) {
    // 선택된 날(day)의 events를 가져오는 메소드
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 일정 추가 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  // scrollable: true,
                  title: Text("일정 등록"),
                  content: TextField(
                    controller: _eventCon,
                  ),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        events.addAll({
                          _selectedDay: [Event(_eventCon.text)]
                        });
                        Navigator.of(context, rootNavigator: true).pop();
                        _selectedEvents.value = _getEventsForDay(_selectedDay);
                      },
                      child: Text("일정 추가하기"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff2e2288))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Text("취소"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2020),
            // 달력 범위
            lastDay: DateTime.utc(2030),
            // 달력 범위
            focusedDay: DateTime.now(),
            // 달력 표기시점

            // 헤더 스타일
            headerStyle: headerStyle,
            // 캘린더 스타일
            calendarStyle: calendarStyle,

            // 날짜 선택 속성
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              // 선택된 날짜의 상태를 갱신합니다.
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                _selectedEvents.value = _getEventsForDay(selectedDay);
              });
            },
            selectedDayPredicate: (DateTime day) {
              // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.
              return isSameDay(_selectedDay, day);
            },

            // // 범위 날짜 선택 속성
            // rangeStartDay: startDay,
            // rangeEndDay: endDay,
            // onRangeSelected: _onRangeSelected,
            // rangeSelectionMode: RangeSelectionMode.toggledOn,

            // 일정 추가
            eventLoader: _getEventsForDay,
          ),
          SizeBoxH30,
          horisonLine,
          SizeBoxH30,
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Row(
                              children: [
                                Text('${_selectedDay.day}',style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),),
                                Column(
                                  children: [
                                    Text('${value[index]}'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                  }
                ),
          )
        ],
      ),
    );
  }
}
