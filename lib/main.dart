import 'package:cali_pro/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/navigation.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Authentication',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          // primarySwatch: Colors.red,
          primarySwatch: Colors.orange,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                fontSize: 24.0,
              ),
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            ),
          ),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        // TextTheme(
        //     headline1: TextStyle(
        //       fontSize: 46.0,
        //       color: Colors.blue.shade700,
        //       fontWeight: FontWeight.w500,
        //     ),
        //     bodyText1: TextStyle(fontSize: 18.0),
        //   ),
        ),
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('You have an error! ${snapshot.error.toString()}');
              return Text('Something went wrong!');
            } else if (snapshot.hasData) {
              print('DataBase is ok.');
              return LoginPage();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
    );
  }
}