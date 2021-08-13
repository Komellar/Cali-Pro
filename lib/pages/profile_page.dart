import 'package:cali_pro/pages/event_creator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'login_page.dart';
import 'motivation_page.dart';

class ProfilePage extends StatefulWidget {
  // final User user;

  // const ProfilePage({required this.user});
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;
  late User _currentUser;
  bool _isSigningOut = false;

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
  final _database = FirebaseDatabase.instance.reference();

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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                'Name: ${_currentUser.displayName}',
              ),
              SizedBox(height: 16.0),
              _isSigningOut
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isSigningOut = true;
                  });
                  await FirebaseAuth.instance.signOut();
                  setState(() {
                    _isSigningOut = false;
                  });
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text('Sign out'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 50.0,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EventCreator())
                    );
                  },
                  child: Text('Add New Event')
              ),
              SizedBox(height: 20),
              // OutlinedButton(
              //   style: OutlinedButton.styleFrom(
              //       primary: Colors.white,
              //       side: BorderSide(color: Colors.black, width: 1.5),
              //       backgroundColor: Color.fromRGBO(0, 0, 0, 0.6),
              //       padding: EdgeInsets.all(15.0),
              //       textStyle: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w600,
              //           letterSpacing: 2.0
              //       )
              //   ),
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(
              //         builder: (context) => MotivationPage()
              //     )
              //     );
              //   },
              //   child: Text('Get Motivation'),
              // ),
            ],
          ),
        ),
      ),

    );
  }
}
