import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar_Screen extends StatefulWidget {
  @override
  _Calendar_ScreenState createState() => _Calendar_ScreenState();
}

class _Calendar_ScreenState extends State<Calendar_Screen>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;

  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      _selectedDay.subtract(Duration(days: 27)): ['Roy'],
      _selectedDay.subtract(Duration(days: 20)): [
        'Roy',
        'Joy',
      ],
      _selectedDay.subtract(Duration(days: 16)): ['Raj', 'Mahesh'],
      _selectedDay.subtract(Duration(days: 10)): ['Mahesh'],
      _selectedDay: ['Jonny', 'Scout'],
      _selectedDay.add(Duration(days: 3)): Set.from(['Joy']).toList(),
      _selectedDay.add(Duration(days: 7)): [
        'Roy',
      ],
      _selectedDay.add(Duration(days: 11)): ['Abhay', 'Devil'],
      _selectedDay.add(Duration(days: 17)): ['Joy', 'Jonny'],
    };

    _selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {}

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          _showCalendar(),
          SizedBox(height: 20.0),
          Divider(color: Colors.black,thickness: 2,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left:15.0),
              child: _buildEventList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showCalendar() {
    return TableCalendar(
      locale: 'en_US',
      calendarController: _calendarController,
      events: _events,
      weekendDays: [DateTime.sunday],
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      rowHeight: 43,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableGestures: AvailableGestures.all,
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        markersColor: Colors.yellow.withOpacity(0.4),
        markersMaxAmount: 1,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(fontSize: 14, color: Colors.white),
        weekendStyle: TextStyle(fontSize: 14, color: Colors.white),
      ),
      headerStyle: HeaderStyle(
          centerHeaderTitle: true,
          formatButtonVisible: false,
          titleTextStyle: TextStyle(fontSize: 22, color: Colors.white),
          leftChevronIcon: Icon(
            Icons.arrow_back_ios,
            color: Colors.transparent,
          ),
          rightChevronIcon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.transparent,
          )),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return CircleAvatar(
            radius: 28,
            backgroundColor: Colors.yellow.withOpacity(0.02),
            child: Text(
              '${date.day}',
              style:
                  TextStyle().copyWith(fontSize: 14.0, color: Colors.yellow),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return CircleAvatar(
            radius: 28,
            backgroundColor: Colors.yellow.withOpacity(0.017),
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 14.0, color: Colors.yellow),
            ),
          );
        },
      ),
      onDaySelected: (date, events) {
        _onDaySelected(date, events);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Padding(
                padding: const EdgeInsets.only(bottom:20.0),
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            '10:20',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.end,
                          ),
                          SizedBox(height: 7,),
                          Text(
                            '11:40',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 16),
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.yellow,
                        child: CircleAvatar(
                          radius: 27.5,
                          backgroundColor: Colors.black,
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('images/profiles.jpg',),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        event.toString(),
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
