import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homemedica_patient/models/reservation_model.dart';
import 'package:homemedica_patient/utils/utils.dart';
import 'package:homemedica_patient/widgets/loading_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookedHomeWidget extends StatefulWidget {
  const BookedHomeWidget({Key? key}) : super(key: key);

  @override
  State<BookedHomeWidget> createState() => _BookedHomeWidgetState();
}

class _BookedHomeWidgetState extends State<BookedHomeWidget> {

  bool loading = false;
  List<ReservationModel> reservationsListOffline=[];
  List<ReservationModel> reservationsListOnline=[];
  bool isOnline = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    Utils().getBookingsListOffline().then((value) {
      loading=false;
      reservationsListOffline = value;
      setState((){
      });
      Utils().getBookingsListOnline().then((value) {
        reservationsListOnline=value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(right: 0,left:8),
      child: Center(
          child: loading? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoadingWidget(),
              SizedBox(height: 20,),
              Text("Please Wait...",style: GoogleFonts.lato(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.blue
              ),)
            ],
          ):Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
                  child: SfCalendar(
                    appointmentTextStyle: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue
                    ),
                    showNavigationArrow: true,
                    showWeekNumber: true,
                    showCurrentTimeIndicator: true,
                    view: CalendarView.schedule,
                    dataSource: MeetingDataSource(_getDataSource(isOnline?reservationsListOnline: reservationsListOffline)),
                    monthViewSettings: const MonthViewSettings(
                        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                  ),

              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  child: FlutterSwitch(
                    width: 120.0,
                    height: 50.0,
                    inactiveColor: Colors.pinkAccent,
                    valueFontSize: 20.0,
                    toggleSize: 45.0,
                    value: isOnline,
                    borderRadius: 30.0,
                    padding: 5.0,
                    showOnOff: true,
                    inactiveText: "Offline",
                    activeText: "Online",
                    activeTextFontWeight: FontWeight.w300,
                    inactiveTextFontWeight: FontWeight.w400,
                    onToggle: (val) {
                      setState(() {
                        isOnline = val;
                      });
                      print("Value: ${isOnline}");
                    },
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  List<Meeting> _getDataSource(List<ReservationModel> list){

    final List<Meeting> meetings = <Meeting>[];

    list.forEach((element) {
      final DateTime startTime = DateTime.fromMillisecondsSinceEpoch((DateTime.parse(element.endTime).subtract(Duration(minutes: 15))).millisecondsSinceEpoch);
      final DateTime endTime = DateTime.fromMillisecondsSinceEpoch((DateTime.parse(element.endTime)).millisecondsSinceEpoch);

      print('Start Time: $startTime');

      meetings.add(Meeting(
          element.speciality,
          startTime,
          endTime,
          const Color(0xFF0F8644), false));

    });

    print('length of meetings: ${meetings.length}');
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
