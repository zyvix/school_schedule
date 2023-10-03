import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_schedule_app/models/room_model.dart';

import '../models/class_model.dart';

class DBase {
  static final _firestore = FirebaseFirestore.instance;
  static String getCurrentWeekday() {
    DateTime now = DateTime.now();
    int dayOfWeek = now.weekday;
    String day = '';
    switch (dayOfWeek) {
      case DateTime.monday:
        day = 'monday';
        break;
      case DateTime.tuesday:
        day = 'tuesday';
        break;
      case DateTime.wednesday:
        day = 'wednesday';
        break;
      case DateTime.thursday:
        day = 'thursday';
        break;
      case DateTime.friday:
        day = 'friday';
        break;
    }
    return day;
  }

  static Future<List> loadRooms() async {
    List<RoomModel> rooms = [];
    var querySnapshot = await _firestore.collection("rooms").get();
    querySnapshot.docs.forEach((result) {
      RoomModel room = RoomModel.fromJSON(result.data());
      rooms.add(room);
    });
    return rooms;
  }

  static Future<List> loadClasses({RoomModel? room}) async {
    List<ClassModel> groups = [];
    String day = getCurrentWeekday();
    var querySnapshot = await _firestore.collection("rooms").doc(room?.id).collection(day).get();
    querySnapshot.docs.forEach((result) {
      ClassModel group = ClassModel.fromJSON(result.data());
      groups.add(group);
    });
    return groups;
  }
}
