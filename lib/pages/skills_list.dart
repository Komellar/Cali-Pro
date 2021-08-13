import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/models/skill_model.dart';
import 'combo_page.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({Key? key}) : super(key: key);

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<SkillModel> skillsList = SkillModel.getSkills();
  late List<SkillModel> checkedSkillsList;
  late List<SkillModel> filteredList;

  String filter = 'all';

  void filterSkills(filter) {
    if (filter != 'statics' && filter != 'dynamics' && filter != 'power') {
      setState(() {
        filteredList = [...skillsList];
      });
      print('No Filter');
    } else {
      print('FILTER: $filter !!!');
      List<SkillModel> tempFilteredList = List<SkillModel>.from(
          skillsList.where((element) => element.type == filter).toList());
      setState(() {
        filteredList = [...tempFilteredList];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    filterSkills(filter);
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
        actions: <Widget>[
          PopupMenuButton(
            padding: EdgeInsets.only(right: 15.0),
            icon: Icon(Icons.tune),
            tooltip: 'Filter',
            itemBuilder: (BuildContext bc) => [
              PopupMenuItem(
                  child: Row(
                    children: [
                      Icon( Icons.emoji_events, color: Colors.grey),
                      SizedBox( width: 10.0),
                      Text("All"),
                    ],
                  ), value: "all"),
              PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.timer, color: Colors.grey),
                      SizedBox( width: 10.0),
                      Text("Statics"),
                    ],
                  ), value: "statics"),
              PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.air, color: Colors.grey),
                      SizedBox( width: 10.0),
                      Text("Dynamics"),
                    ],
                  ), value: "dynamics"),
              PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(Icons.local_fire_department, color: Colors.grey),
                      SizedBox( width: 10.0),
                      Text("Power"),
                    ],
                  ), value: "power"),
            ],
            onSelected: (newFilter) {
              print(newFilter);
              setState(() {
                filter = newFilter.toString();
              });
              filterSkills(filter);
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  'Choose your skills',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 1.3,
                  ),
                ),
              ),
            ],
          ),
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: constraints.maxHeight - 70,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        itemCount: filteredList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 1.5,
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: Column(
                                children: <Widget>[
                                  CheckboxListTile(
                                      activeColor: Colors.red[600],
                                      dense: true,
                                      title: Text(
                                        filteredList[index].title,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5),
                                      ),
                                      value: filteredList[index].isCheck,
                                      secondary: Icon(filteredList[index].type ==
                                          'statics'
                                          ? Icons.timer
                                          : filteredList[index].type == 'dynamics'
                                          ? Icons.air
                                          : Icons.local_fire_department),
                                      onChanged: (bool? val) {
                                        itemChange(val!, index);
                                      })
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                );
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          List<SkillModel> tempCheckedSkillsList =
          filteredList.where((i) => i.isCheck).toList();

          if (tempCheckedSkillsList.length < 3) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                action: SnackBarAction(
                  label: 'OK',
                  onPressed: () { }, // Code to execute.
                ),
                content: const Text('Choose at least 3 skills'),
                duration: const Duration(milliseconds: 2500),
                width: 280.0,
                padding: const EdgeInsets.only(left: 20.0),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            );
          } else {
            var checkedSkillsList =
            new List<SkillModel>.from(tempCheckedSkillsList);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComboPage(),
                settings: RouteSettings(arguments: checkedSkillsList),
              ),
            );
          }
        },
      ),
    );
  }

  void itemChange(bool val, int index) {
    setState(() {
      filteredList[index].isCheck = val;
    });
  }
}
