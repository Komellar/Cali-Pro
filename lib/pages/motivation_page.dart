import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class MotivationPage extends StatelessWidget {
  const MotivationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.dstATop),
              image: AssetImage('assets/lion.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Quote(),
        ));
  }
}

class Quote extends StatefulWidget {
  const Quote({Key? key}) : super(key: key);

  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  String quote = 'Loading...';

  Future<void> getQuote() async {
    try {
      Response response = await get(Uri.parse('https://www.affirmations.dev/'));
      Map data = jsonDecode(response.body);

      // get property from data
      setState(() {
        this.quote = data['affirmation'];
      });
    } catch (e) {
      print('caught error: $e');
      this.quote = 'No pain No gain';
    }
  }

  @override
  void initState() {
    super.initState();
    getQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 170.0,
        ),
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(this.quote,
              style: TextStyle(color: Colors.grey[200], fontSize: 33.0, fontWeight: FontWeight.w600 ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 160.0,
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: BorderSide(color: Colors.white, width: 1.5),
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                padding: EdgeInsets.all(15.0),
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0)),
            onPressed: () async {
              getQuote();
            },
            child: Text(
              'New Quote',
              style: TextStyle(fontSize: 20.0, color: Colors.grey[500]),
            ),
          ),
        )
      ],
    );
  }
}
