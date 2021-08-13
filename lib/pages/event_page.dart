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
    _database
        .child('events')
        .orderByChild('date')
        .equalTo(widget.event.date)
        .onChildAdded.listen((Event event) {
          setState(() {
            eventRoute = event.snapshot.key.toString();
          });
    });
  }
  String eventRoute = '';

  @override
  Widget build(BuildContext context) {
    // String eventRoute = '';
    _database
      .child('events')
      .orderByChild('date')
      .equalTo(widget.event.date)
      .onChildAdded.listen((Event event) {
        eventRoute = event.snapshot.key.toString();
      });

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
      body: Column(
        children: [
          Container(
            height: 360,
            width: MediaQuery.of(context).size.width,
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // padding: EdgeInsets.all(15.0),
                          elevation: 8.0
                      ),
                      onPressed: () {
                        print('join event clicked');

                        final attend = <String, dynamic>{
                          'attendees': 1
                        };

                        print(eventRoute);

                        _database
                            .child('events')
                            .child(eventRoute)
                            // .push()
                            .update(attend)
                            .then((_) => print('Event has been written!'))
                            .catchError((error) => print('You got an error: $error'));
                      },
                      child: Text(
                          'Join Event',
                          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400)
                      )
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
                      stream: _database.child('events').child(eventRoute).onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print("Its ok");
                          final myEvent = EventModel.fromRTDB(
                              Map<String, dynamic>.from(
                                  (snapshot.data as Event).snapshot.value));
                          return Text(
                            myEvent.attendees.toString(),
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.white
                            ),
                          );
                        } else {
                          print("WTF Problem");
                          return Text(
                            '3',
                            style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w800,
                                color: Colors.white
                            ),
                          );
                        }
                      }
                    ),
                    // Text(
                    //   '${widget.event.attendees}',
                    //   style: TextStyle(
                    //       fontSize: 22.0,
                    //       fontWeight: FontWeight.w800,
                    //       color: Colors.white
                    //   ),
                    // )
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
                    fontSize: 35.0,
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
                SizedBox(height: 40.0),
                Text(
                  'Place: ${widget.event.place}', textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Created by: ${widget.event.author}',
                        style: TextStyle(
                            fontSize: 16.0,
                            // fontWeight: FontWeight.w500,
                            // color: Colors.grey[800],
                            fontStyle: FontStyle.italic
                        )
                    ),
                    SizedBox(height: 15.0),

                  ],
                ),
                // SizedBox(height: 40.0,),
              ],
            ),
          )
        ],
      )
    );
  }
}
