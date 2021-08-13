import 'package:cali_pro/pages/home_page.dart';
import 'package:cali_pro/pages/motivation_page.dart';
import 'package:cali_pro/pages/profile_page.dart';
import 'package:cali_pro/pages/skills_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Navigation extends StatefulWidget {
  // final User user;
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {

  int _selectedIndex = 0;
  // late User _currentUser;

  // @override
  // void initState() {
  //   _currentUser = widget.user;
  //   super.initState();
  // }

  List<Widget> _navigationOptions = <Widget>[
    HomePage(),
    SkillsPage(),
    MotivationPage(),
    ProfilePage(),
    // ProfilePage(uer: _currentUser),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _navigationOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Combos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Motivation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey[300],
        backgroundColor: Colors.grey[800],
        onTap: _onItemTapped,
      ),
    );
  }
}