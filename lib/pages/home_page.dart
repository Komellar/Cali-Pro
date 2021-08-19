import 'package:cali_pro/models/event_model.dart';
import 'package:cali_pro/models/event_stream_publisher.dart';
import 'package:cali_pro/pages/event_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  final myEvents = snapshot.data as List<EventModel>;
                  tilesList.addAll(
                    myEvents.map((nextEvent) {
                      double descFontSize = nextEvent.description.length < 40? 20.0 : 15.0;
                      double placeFontSize = nextEvent.place.length < 10? 14.0 : 12.0;
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
                                        Text(nextEvent.description, textAlign: TextAlign.center, style: TextStyle(fontSize: descFontSize, color: Colors.grey[800], fontWeight: FontWeight.w600)),
                                        SizedBox(height: 15.0),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                              Text(nextEvent.date, textAlign: TextAlign.center, style: TextStyle(fontSize: placeFontSize, color: Colors.grey[600], fontWeight: FontWeight.w600)),
                                              SizedBox(width: 25.0,),
                                              Text(nextEvent.place, style: TextStyle(fontSize: placeFontSize, color: Colors.grey[600], fontWeight: FontWeight.w600)),
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
}
