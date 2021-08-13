import 'package:firebase_database/firebase_database.dart';

import 'event_model.dart';

class EventStreamPublisher {
  final _database = FirebaseDatabase.instance.reference();

  // Stream<List<EventModel>> getEventStream() {
  //   final eventStream = _database.child('events').onValue;
  //   final streamToPublish = eventStream.map((event) {
  //     final eventMap = Map<String, dynamic>.from(event.snapshot.value);
  //     final eventList = eventMap.entries.map((element) {
  //       return EventModel.fromRTDB(Map<String, dynamic>.from(element.value));
  //     }).toList();
  //     return eventList;
  //   });
  //   return streamToPublish;
  // }

  Stream<List<EventModel>> getEventStream() {
    final orderStream = _database.child('events').onValue;
    final streamToPublish = orderStream.map((event) {
      final orderMap = Map<String, dynamic>.from(event.snapshot.value);
      final orderList = orderMap.entries.map((element) {
        return EventModel.fromRTDB(Map<String, dynamic>.from(element.value));
      }).toList();
      return orderList;
    });
    return streamToPublish;
  }

}