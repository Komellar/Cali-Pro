import 'dart:math';

import 'package:cali_pro/pages/skills_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'motivation_page.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Training App'),
        backgroundColor: Colors.grey[800],
      ),
      body: Stack(
        children: <Widget>[
          // ElevatedButton(
          //     onPressed: () {
          //       final nextTodo = <String, dynamic>{
          //         'description': getRandomTodo(),
          //         'isDone': false,
          //         'timestamp': DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now())
          //       };
          //       _database
          //           .child('post')
          //           .push()
          //           .set(nextTodo)
          //           .then((_) => print('TODO has been added!'))
          //           .catchError((error) => print('You got an error: $error'));
          //
          //     },
          //     child: Text('Add Random TODO')
          // ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  height: constraints.maxHeight / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/workout.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5),
                              BlendMode.dstATop))),
                  child: Center(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            primary: Colors.white,
                          side: BorderSide(color: Colors.white, width: 1.5),
                          backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                          padding: EdgeInsets.all(15.0),
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0
                            )
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SkillsPage()
                            )
                          );
                        },
                        child: Text('Create New Combos')),
                  ),
                );
              },
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: constraints.maxHeight / 2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/motivation.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.5),
                                BlendMode.dstATop))),
                    child: Center(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(color: Colors.white, width: 1.5),
                          backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
                          padding: EdgeInsets.all(15.0),
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0
                            )
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MotivationPage()
                            )
                          );
                        },
                        child: Text('Get Motivation')
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

String getRandomTodo() {
  final todoList = [
    'Wash dishes',
    'Go for a walk with dog',
    'Read a book for 20 min',
    'Do shopping',
    'Eat a vegetable',
    'Eat a fruit'
  ];
  return todoList[Random().nextInt(todoList.length)];
}

