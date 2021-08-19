import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/models/skill_model.dart';

class ComboPage extends StatelessWidget {
  const ComboPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final skills =
    ModalRoute.of(context)!.settings.arguments as List<SkillModel>;

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
      body: Combo(
        skills: skills,
      ),
    );
  }
}

class Combo extends StatefulWidget {
  final List<SkillModel> skills;
  const Combo({required this.skills, Key? key}) : super(key: key);

  @override
  _ComboState createState() => _ComboState();
}

class _ComboState extends State<Combo> {
  double currentSliderValue = 2.0;
  List<SkillModel> comboList = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      comboList = getCombo();
    });
  }

  List<SkillModel> getCombo() {
    List<SkillModel> tempSkillList = [...widget.skills];
    List<SkillModel> comboList = [];

    for (var i = 0; i < currentSliderValue; i++) {
      int length = tempSkillList.length - i;
      int result = Random().nextInt(length > 0 ? length : 1);
      comboList.add(tempSkillList[result]);
      tempSkillList.removeAt(result);
    }
    return comboList;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'Enjoy new combo!',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 1.3,
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                'How many elements?',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
      Positioned(
        top: 90.0,
        width: MediaQuery.of(context).size.width,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'min',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  )
              ),
              Slider(
                value: currentSliderValue,
                min: 2.0,
                max: widget.skills.length.toDouble(),
                divisions: widget.skills.length - 2,
                label: currentSliderValue.round().toString(),
                activeColor: Colors.red[600],
                inactiveColor: Colors.red[200],
                onChanged: (double value) {
                  setState(() {
                    currentSliderValue = value;
                  });
                },
              ),
              Text(
                  'max',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                  )
              ),
            ]
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 150.0),
        child: ListView.separated(
          itemCount: comboList.length,
          itemBuilder: (context, index) {
            return Container(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                      backgroundColor: Colors.red[600],
                    ),
                    title: Text(
                      comboList[index].title,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                    trailing: Icon(comboList[index].type == 'statics'
                        ? Icons.timer
                        : comboList[index].type == 'dynamics'
                        ? Icons.air
                        : Icons.local_fire_department)));
          },
          separatorBuilder: (context, index) {
            return Divider(
              height: 0.0,
              thickness: 1.0,
              indent: 30,
              endIndent: 30,
              color: Colors.grey[300],
            );
          },
        ),
      ),
      Positioned(
        bottom: 15.0,
        right: 15.0,
        child: FloatingActionButton(
          onPressed: () {
            List<SkillModel> combo = getCombo();
            setState(() {
              comboList = combo;
            });
          },
          child: Icon(Icons.refresh),
        ),
      )
    ]);
  }
}
