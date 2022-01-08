import 'package:flutter/cupertino.dart';

import 'Hole.dart';

class Course {
  String courseName;
  int courseID;

  // List<Hole> holes = [];

 
  Course(this.courseName, this.courseID);

  Course.fromCourse({
    required this.courseName,
    required this.courseID,
  });

  factory Course.fromJson(dynamic res) {
    return Course.fromCourse(courseName: res['name'], courseID: res['id']);
  }


}
