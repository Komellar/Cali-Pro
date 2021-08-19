import 'package:cali_pro/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventPage extends StatefulWidget {
  final EventModel event;
  const EventPage({Key? key, required this.event}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  User? user = FirebaseAuth.instance.currentUser;
  late User _currentUser;

  final _database = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    if (user != null) {
      _currentUser = user!;
    } else {
      return;
    }
  }

  String eventRoute = '';

  final Future<String> _timer = Future<String>.delayed(
    const Duration(milliseconds: 50),
        () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    _database
      .child('events')
      .orderByChild('date')
      .equalTo(widget.event.date)
      .onChildAdded.listen((Event event) {
        eventRoute = event.snapshot.key.toString();
      });

    double descSize = (widget.event.description.length<30)? 35.0 : 30.0;
    double spaceSize = (widget.event.description.length<30)? 40.0 : 20.0;

      return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text(
              "CaliPro",
              style: GoogleFonts.lobster(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.amber[800],
                letterSpacing: 1.8,
              ),
            ),
            backgroundColor: Colors.grey[800],
          ),
          body: FutureBuilder(
            future: _timer,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: CircularProgressIndicator(),
                        width: 60,
                        height: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ]),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Error: ${snapshot.error}'),
                      )
                    ]
                  ),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      height: 360,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          image: DecorationImage(
                              image: AssetImage(widget.event.image),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.4),
                                  BlendMode.dstATop
                              )
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child:
                            StreamBuilder(
                                stream: _database
                                    .child('events')
                                    .child(eventRoute)
                                    .onValue,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final currentEvent = snapshot.data as Event;

                                    if(currentEvent.snapshot.value['attendees'] != null) {
                                      List<Object?> attendeesList = currentEvent.snapshot.value['attendees'];
                                      if (attendeesList.contains(_currentUser.uid)) {
                                        return ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 8.0
                                            ),
                                            child: Text(
                                                'Leave Event',
                                                style: TextStyle(
                                                    fontSize: 30.0,
                                                    fontWeight: FontWeight.w400)
                                            ),
                                            onPressed: () {
                                              List<Object?> _newAttendeesList = attendeesList.where((i) => i != _currentUser.uid).toList();

                                              _database
                                                  .child('events')
                                                  .child(eventRoute)
                                                  .child('attendees')
                                                  .set(_newAttendeesList)
                                                  .then((_) =>
                                                  print('User removed from event!'))
                                                  .catchError((error) =>
                                                  print('You got an error: $error'));
                                            }
                                        );
                                      } else {
                                        return ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                elevation: 8.0
                                            ),
                                            child: Text(
                                                'Join Event',
                                                style: TextStyle(
                                                    fontSize: 30.0,
                                                    fontWeight: FontWeight.w400)
                                            ),
                                            onPressed: () {
                                              _database
                                                  .child('events')
                                                  .child(eventRoute)
                                                  .child('attendees')
                                                  .update({widget.event.attendees.length.toString():_currentUser.uid})
                                                  .then((_) =>
                                                  print('User added to event!'))
                                                  .catchError((error) =>
                                                  print('You got an error: $error'));
                                            }
                                        );
                                      }
                                    } else {
                                      return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 8.0
                                          ),
                                          child: Text(
                                              'Join Event',
                                              style: TextStyle(
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.w400)
                                          ),
                                          onPressed: () {
                                            _database
                                                .child('events')
                                                .child(eventRoute)
                                                .child('attendees')
                                                .update({'0':_currentUser.uid})
                                                .then((_) =>
                                                print('User added to event!'))
                                                .catchError((error) =>
                                                print('You got an error: $error'));
                                          }
                                      );
                                    }
                                  } else {
                                    return Text(
                                      'Error',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w800,
                                          color: Colors.white
                                      ),
                                    );
                                  }
                                }
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'People taking part: ',
                                style: TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white
                                ),
                              ),
                              StreamBuilder(
                                  stream: _database
                                      .child('events')
                                      .child(eventRoute)
                                      .onValue,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final currentEvent = snapshot.data as Event;

                                      if(currentEvent.snapshot.value['attendees'] != null) {
                                        print('Attendees list: ${currentEvent.snapshot.value['attendees']}');
                                        List<Object?> attendeesList = currentEvent.snapshot.value['attendees'];
                                        return Text(
                                          attendeesList.length.toString(),
                                          style: TextStyle(
                                            fontSize: 22.0,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          '0',
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white
                                          ),
                                        );
                                      }
                                    } else {
                                      return Text(
                                        'Error',
                                        style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white
                                        ),
                                      );
                                    }
                                  }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.event.description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: descSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                              widget.event.date,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800]
                              )
                          ),
                          SizedBox(height: spaceSize),
                          Text(
                            'Place: ${widget.event.place}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Column(
                            children: [
                              Text(
                                  'Created by: ${widget.event.author}',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontStyle: FontStyle.italic
                                  )
                              ),
                              SizedBox(height: 15.0),

                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            }
          )
      );
    }
  }

