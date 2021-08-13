import 'dart:math';

import 'package:cali_pro/models/event_model.dart';
import 'package:cali_pro/models/event_stream_publisher.dart';
import 'package:cali_pro/pages/event_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'motivation_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Column(
          children: [
            Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage('assets/motivation.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.dstATop
                  )
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 15,),
                  // Text(
                  //   "CaliPro",
                  //   style: GoogleFonts.lobster(
                  //     fontSize: 80,
                  //     fontWeight: FontWeight.w500,
                  //     // color: Colors.grey[50],
                  //     // color: Colors.orange[500],
                  //     color: Colors.amber[800],
                  //     letterSpacing: 1.8,
                  //   ),
                  // ),
                  // SizedBox(height: 30,),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(color: Colors.white60, width: 1.8),
                        backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                        padding: EdgeInsets.all(15.0),
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2.0,
                            // color: Colors.amber[800]
                        )
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                              builder: (context) => MotivationPage()
                          )
                      );
                    },
                    child: Text('Get Motivation', style:TextStyle(color: Colors.amber[800])),
                    ),
                ],
              ),
            ),

            SizedBox(height: 15.0,),
            Text(
              "UPCOMING EVENTS",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 5.0),
            StreamBuilder(
              stream: EventStreamPublisher().getEventStream(),
              builder: (context, snapshot) {
                final tilesList = <GestureDetector> [];
                if (snapshot.hasData) {
                  print("YYEEESS We have data");
                  final myEvents = snapshot.data as List<EventModel>;
                  tilesList.addAll(
                    myEvents.map((nextEvent) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => EventPage(event: nextEvent,))
                          );
                        },
                        child: Card(
                            margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 100.0,
                                  width: 90.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover, image: AssetImage(nextEvent.image)
                                    ),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0)),
                                  ),
                                ),
                                Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(nextEvent.description, textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.grey[800], fontWeight: FontWeight.w600)),
                                        SizedBox(height: 15.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                              Text(nextEvent.date, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                                              SizedBox(width: 25.0,),
                                              Text(nextEvent.place, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                                          ],
                                        )
                                      ],
                                  ),
                                )
                              ],
                            )
                        ),
                      );
                    }),
                  );
                } else {
                  print('ERROR or No Data');
                }
                return Expanded(
                  child: ListView(
                      children: tilesList
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  String randomImg() {
    String img = (Random().nextInt(12) + 1).toString();
    return 'assets/workout$img.jpg';
  }

}

class EventsView extends StatefulWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  _EventsViewState createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  final _database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: EventStreamPublisher().getEventStream(),
        builder: (context, snapshot) {
          final tilesList = <ListTile> [];
          if (snapshot.hasData) {
            final myTodos = snapshot.data as List<EventModel>;
            tilesList.addAll(
              myTodos.map((nextEvent) {
                return ListTile(
                  title: Text(nextEvent.description),
                  subtitle: Text(nextEvent.place),
                  // trailing: Text(DateFormat('EEE d MMM').format(nextEvent.date)),
                );
              }),
            );
          }
          return Expanded(
            child: ListView(
                children: tilesList
            ),
          );
        },
      )
    );
  }
}
