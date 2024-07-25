import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/Home/Golf%20Clubs%20Components/Events.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatefulWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final void Function(DateTime) onDaySelected;
  final void Function(CalendarFormat) onFormatChanged;

  const MyCalendar({
    Key? key,
    required this.selectedDay,
    required this.focusedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onFormatChanged,
  }) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
  
}

class _MyCalendarState extends State<MyCalendar> {
  // Store events
  Map<DateTime, List<Events>> events = {};

//get docDetails
Future<void> getDeventDetailsFetchingcId() async {
  await FirebaseFirestore.instance.collection('Events').get().then((snapshot1) {
    snapshot1.docs.forEach((document) async {
      DocumentSnapshot docSnapshot = await document.reference.get();
      if (docSnapshot.exists) {
        var clubName = docSnapshot.get('Club Host');
        var entryFee = docSnapshot.get('Entry Fee');
        var eventName = docSnapshot.get('Event Name');
        var format = docSnapshot.get('Formate');
        var moreInfo = docSnapshot.get('More info');
        var due = docSnapshot.get('Sign up due');
        var selectedDay = docSnapshot.get('SelectedDay');
         setState(() {
          events.update(
            (selectedDay as Timestamp).toDate(), // Convert Timestamp to DateTime
            (value) => [...value, Events(eventName, clubName, format, entryFee, due, moreInfo)],
            ifAbsent: () => [Events(eventName, clubName, format, entryFee, due, moreInfo)],
          );
        });
      }
    });
  });
}



  List<String> clubNames = ['Omeya', 'NAGU', 'Windhoek', 'Tsumeb', 'Oshakati'];
  String selectedClubName = 'Omeya';

  late final ValueNotifier<List<Events>> _selectedEvents;

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

 


  TextEditingController titleController = TextEditingController();
  TextEditingController clubNameController = TextEditingController();
  TextEditingController formatController = TextEditingController();
  TextEditingController entryFeeController = TextEditingController();
  TextEditingController dueDateForRegController = TextEditingController();
  TextEditingController moreDetailController = TextEditingController();



  final ValueNotifier<DateTime> _selectedDateNotifier = ValueNotifier<DateTime>(DateTime.now());

@override
void initState() {
  super.initState();
  getDeventDetailsFetchingcId(); // Call method to fetch events
  _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

List<Events> _getEventsForDay(DateTime day){
  return events[day] ?? [];
}

  Future<void> eventDetails(
    TextEditingController titleController,
    String selectedClubName,
    TextEditingController formatController,
    TextEditingController entryFeeController,
    TextEditingController dueDateForRegController,
    TextEditingController moreDetailController,
    DateTime SelectedDayField,
    Map<DateTime, List<Events>> events,
    ValueNotifier<List<Events>> selectedEvents,
  ) async {
    try {
      await FirebaseFirestore.instance.collection("Events").doc().set({
        'Event Name': titleController.text,
        'Club Host': selectedClubName,
        'Formate': formatController.text,
        'Entry Fee': entryFeeController.text,
        'Sign up due': dueDateForRegController.text,
        'More info': moreDetailController.text,
        'SelectedDay': Timestamp.fromDate(SelectedDayField),
      });
    } catch (e) {
      print('Error: $e');
    }
  }


@override
Widget build(BuildContext context) {
  return Column(
    children: [
      ValueListenableBuilder<DateTime>(
        valueListenable: _selectedDateNotifier,
        builder: (context, selectedDate, _) {
           print('Selected date: $selectedDate');
          List<Events>? eventList = events[selectedDate];
          return TableCalendar(
            focusedDay: widget.focusedDay,
            firstDay: DateTime.utc(2022, 3, 14),
            lastDay: DateTime(2030, 11, 11),
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) {
              return isSameDay(widget.selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
  setState(() {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    _selectedDateNotifier.value = selectedDay;
  });
  widget.onDaySelected(selectedDay);

  // Convert selectedDay to local time
  final localSelectedDay = selectedDay.toLocal();

  List<Events>? eventList = events[localSelectedDay];
  if (eventList == null || eventList.isEmpty) {
  } else {
    showDialog(
      context: context,
      builder: (context) {
        eventList.forEach((event) {
          print('Title: ${event.title}');
          print('Host: ${event.host}');
          print('Format: ${event.format}');
          print('Entry Fee: ${event.entryFee}');
          print('Sign-up Due: ${event.signUpDue}');
          print('More Info: ${event.moreInfo}');
          print('----------------------');
        });

        return AlertDialog(
          title: Text(eventList[0].title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Title: ${eventList[0].title}'),
              Text('Host: ${eventList[0].host}'),
              Text('Format: ${eventList[0].format}'),
              Text('Entry Fee: ${eventList[0].entryFee}'),
              Text('Sign-up Due: ${eventList[0].signUpDue}'),
              Text('More Info: ${eventList[0].moreInfo}'),
            ],
          ),
          actions: [
            TextButton(onPressed: (){
              showDialog(
             context: context,
             builder: (context) {
             return AlertDialog(
          title: Text('Success'),
          content: 
              Text('You have successfully, RSVP for ${eventList[0].title} at ${eventList[0].host}, pay the fee of ${eventList[0].entryFee} by  ${eventList[0].signUpDue}, at the club house.'),
        );
      },
    );
            }, child: Text('Reserve'))
          ],
        );
      },
    );
  }
},

            availableCalendarFormats: {
              CalendarFormat.month: 'Month',
            },
            calendarFormat: widget.calendarFormat,
            onFormatChanged: (format) {
              widget.onFormatChanged(format);
            },
            eventLoader: (day) {
  DateTime dayWithTime = Timestamp.fromDate(day).toDate();
  List<Events>? eventList = events[dayWithTime];
  return events[dayWithTime] ?? [];
},
          );
        },
      ),
      SizedBox(height: 8.0),
      FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Add an event.'),
                    content: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            maxLines: null,
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: 'Event Title',
                            ),
                          ),
                          Row(
                            children: [
                              Text('Hosting Club:'),
                              DropdownButton<String>(
                                value: selectedClubName,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedClubName = newValue!;
                                  });
                                },
                                items: clubNames.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                          TextField(
                            maxLines: null,
                            controller: formatController,
                            decoration: InputDecoration(
                              hintText: 'Format',
                            ),
                          ),
                          TextField(
                            maxLines: null,
                            controller: entryFeeController,
                            decoration: InputDecoration(
                              hintText: 'Entry fee',
                            ),
                          ),
                          TextField(
                            maxLines: null,
                            controller: dueDateForRegController,
                            decoration: InputDecoration(
                              hintText: 'Due for Entry',
                            ),
                          ),
                          TextField(
                            maxLines: null,
                            controller: moreDetailController,
                            decoration: InputDecoration(
                              hintText: 'More Detail & info',
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          events.addAll({
                            _selectedDateNotifier.value: [
                              Events(
                                titleController.text,
                                selectedClubName,
                                formatController.text,
                                entryFeeController.text,
                                dueDateForRegController.text,
                                moreDetailController.text,
                              )
                            ]
                          });
                          eventDetails(
                            titleController,
                            selectedClubName,
                            formatController,
                            entryFeeController,
                            dueDateForRegController,
                            moreDetailController,
                            _selectedDateNotifier.value,
                            events,
                            _selectedEvents
                          );
                          Navigator.of(context).pop();
                        },
                        child: Text('Create'),
                      )
                    ],
                  );
                },
              );
            },
          );
        },
        child: Icon(Icons.event_note),
      ),
      SizedBox(height: 10,)
    ],
  );
}
}
