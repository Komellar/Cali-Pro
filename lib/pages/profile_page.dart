import 'package:cali_pro/pages/event_creator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';

class ProfilePage extends StatefulWidget {
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Username: ${_currentUser.displayName}',
                style: TextStyle(
                  fontSize: 20.0
                ),
              ),
              SizedBox(height: 46.0),
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
                  elevation: 2.0,
                  primary: Colors.red[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 150.0,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EventCreator())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
                  ),
                  child: Text(
                      'Add New Event',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                  )
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),

    );
  }
}
