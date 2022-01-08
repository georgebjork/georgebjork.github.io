


import 'package:golf_app/utils/Scorecard.dart';
import 'package:golf_app/utils/TeeBox.dart';

import 'Hole.dart';

class Player {
  String firstName;
  String lastName;
  String uuid;
  //int ghin;this.ghin
  //double handicap;this.handicap)
  late TeeBox teeBox; 
  late List<Hole> holes;
  late List<Scorecard> scoreCard; 
  

  Player(this.firstName, this.lastName, this.uuid, ) ;


  Player.fromPlayer({
    required this.firstName,
    required this.lastName,
    required this.uuid,
    //required this.ghin,
    //required this.handicap
  });

  factory Player.fromJson(dynamic res) {
    return Player.fromPlayer(
        firstName: res['first_name'],
        lastName: res['last_name'],
        uuid: res['id'],
        //ghin: res['ghin_number'],
        //handicap: res['handicap']
      );
  }

  void setTeeBox(TeeBox t){
    teeBox = t;
  }

  
}
