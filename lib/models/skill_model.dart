class SkillModel {
  int skillId;
  String title;
  String type;
  bool isCheck;

  SkillModel(
      {required this.skillId,
        required this.title,
        required this.type,
        required this.isCheck});

  static List<SkillModel> getSkills() {
    return <SkillModel>[
      SkillModel(
          skillId: 1,
          title: "Planche",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 2,
          title: "Swing 360",
          type: 'dynamics',
          isCheck: false
      ),
      SkillModel(
          skillId: 3,
          title: "Hefesto",
          type: 'power',
          isCheck: false
      ),
      SkillModel(
          skillId: 4,
          title: "Shrimp Flip",
          type: 'dynamics',
          isCheck: false
      ),
      SkillModel(
          skillId: 5,
          title: "One Arm Pull Up",
          type: 'power',
          isCheck: false
      ),
      SkillModel(
          skillId: 6,
          title: "Front Lever",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 7,
          title: "Swing 540",
          type: 'dynamics',
          isCheck: false
      ),
      SkillModel(
          skillId: 8,
          title: "Alley Hoop",
          type: 'dynamics',
          isCheck: false
      ),
      SkillModel(
          skillId: 9,
          title: "Handstand",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 10,
          title: "One Arm Handstand",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 11,
          title: "Planche Push Up",
          type: 'power',
          isCheck: false
      ),
      SkillModel(
          skillId: 12,
          title: "Dislocate 360",
          type: 'dynamics',
          isCheck: false
      ),
      SkillModel(
          skillId: 13,
          title: "Front Flip Regrab",
          type: 'dynamics',
          isCheck: false
      ),
      SkillModel(
          skillId: 14,
          title: "Front Pull Up",
          type: 'Power',
          isCheck: false
      ),
      SkillModel(
          skillId: 15,
          title: "Human Flag",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 16,
          title: "Back Lever",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 17,
          title: "Swing 180",
          type: 'dynamics',
          isCheck: false
      ),
      SkillModel(
          skillId: 18,
          title: "X grip 360",
          type: 'dynamics',
          isCheck: false
      ),
      SkillModel(
          skillId: 19,
          title: "Iguana Handstand",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 20,
          title: "Planche Press",
          type: 'power',
          isCheck: false
      ),
      SkillModel(
          skillId: 21,
          title: "Touch Front lever",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 22,
          title: "Impossible dip",
          type: 'power',
          isCheck: false
      ),
      SkillModel(
          skillId: 23,
          title: "Single Bar Handstand",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 24,
          title: "Victorian",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 25,
          title: "Geinger",
          type: 'dynamics',
          isCheck: false
      ),
      SkillModel(
          skillId: 26,
          title: "V-sit",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 27,
          title: "90 Deg Push Up",
          type: 'power',
          isCheck: false
      ),
      SkillModel(
          skillId: 28,
          title: "Entrada De Angel",
          type: 'power',
          isCheck: false
      ),
      SkillModel(
          skillId: 29,
          title: "Maltese",
          type: 'statics',
          isCheck: false
      ),
      SkillModel(
          skillId: 30,
          title: "Giant",
          type: 'dynamics',
          isCheck: false
      ),
    ];
  }
}