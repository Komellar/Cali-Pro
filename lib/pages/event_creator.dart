import 'dart:math';

import 'package:cali_pro/services/event_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../widgets/PickeDateTime.dart';

class EventCreator extends StatefulWidget {
  const EventCreator({Key? key}) : super(key: key);

  @override
  _EventCreatorState createState() => _EventCreatorState();
}

class _EventCreatorState extends State<EventCreator> {
  final _database = FirebaseDatabase.instance.reference();

  final _formKey = GlobalKey<FormState>();
  final _descriptionTextController = TextEditingController();
  final _placeTextController = TextEditingController();

  final _focusDescription = FocusNode();
  final _focusPlace = FocusNode();

  bool _isProcessing = false;

  DateTime _date = DateTime.now();
  set date(DateTime value) => setState(() => _date = value);

  User? user = FirebaseAuth.instance.currentUser;
  late User _currentUser;

  @override
  void initState() {
    if (user != null) {
      _currentUser = user!;
    } else {
      return;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _focusDescription.unfocus();
          _focusPlace.unfocus();
        },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
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
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Event Creator',
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 15.0,),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _descriptionTextController,
                      focusNode: _focusDescription,
                      validator: (value) => EventValidator.validateDesc(description: value),
                      decoration: InputDecoration(
                        hintText: "Description",
                        errorBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                          )
                        )
                      )
                    ),
                    SizedBox(height: 20.0,),
                    TextFormField(
                      controller: _placeTextController,
                      focusNode: _focusPlace,
                      validator: (value) => EventValidator.validatePlace(place: value),
                        decoration: InputDecoration(
                            hintText: "Place",
                            errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                )
                            )
                        )
                    ),
                    SizedBox(height: 25.0,),
                    PickDateTimeWidget(callback: (val) => setState(() => _date = val)),
                    SizedBox(height: 45.0,),
                    _isProcessing
                        ? CircularProgressIndicator()
                        : Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                  _focusDescription.unfocus();
                                  _focusPlace.unfocus();

                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isProcessing = true;
                                    });

                                    final nextEvent = <String, dynamic>{
                                      'description': _descriptionTextController.text,
                                      'place': _placeTextController.text,
                                      'date': DateFormat('EEEE dd.MM\nkk:mm').format(_date),
                                      'authorID': _currentUser.uid,
                                      'author': _currentUser.displayName,
                                      'image': randomImg(),
                                      'attendees': [_currentUser.uid.toString()]
                                    };

                                    _database
                                        .child('events')
                                        .push()
                                        .set(nextEvent)
                                        .then((_) => print('Event has been written!'))
                                        .catchError((error) => print('You got an error: $error'));

                                    setState(() {
                                      _isProcessing = false;
                                    });

                                    Navigator.pop(context);
                                  }
                              },
                            style: ElevatedButton.styleFrom(
                              elevation: 5.0
                            ),
                            child: Text(
                                'Post Event',
                                style: TextStyle(
                                  fontSize: 30.0
                                ),
                            ),
                          ),
                        )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  String randomImg() {
    String img = (Random().nextInt(12) + 1).toString();
    return 'assets/workout$img.jpg';
  }
}


