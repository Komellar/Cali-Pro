import 'package:intl/intl.dart';

class EventModel {
  final String description;
  final String place;
  final String date;
  final String authorID;
  final String author;
  final String image;
  final String attendees;

  EventModel({
    required this.description,
    required this.place,
    required this.date,
    required this.authorID,
    required this.author,
    required this.image,
    required this.attendees
  });

  factory EventModel.fromRTDB(Map<String, dynamic> data) {
    return EventModel(
      description: data['description'] ?? 'Workout',
      place: data['place'] ?? 'Unknown',
      date: data['date'] ?? DateFormat('EEEE dd.MM\nkk:mm').format(DateTime.now()),
      authorID: data['authorID'] ?? 'Anonymous',
      author: data['author'] ?? 'Anonymous',
      image: data['image'] ?? 'assets/workout1.jpg',
      attendees: data['attendees/'.length.toString()] ?? '0'
    );
  }

}