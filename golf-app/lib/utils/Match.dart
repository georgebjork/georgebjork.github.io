

import 'package:golf_app/utils/Course.dart';
import 'package:golf_app/utils/Player.dart';

abstract class Match {

  List<Player> players = [];

  Course course; 

  int currentHole = 0;

  Match(this.course, this.players);

  String getCurrentHole(){
    int hole = currentHole+1;
    return "Hole " + hole.toString();
  }

  //This will return the par and the hole handicap in this format Par | Handicap
  String getCurrentHoleDetails(){
    String par = players[0].holes[currentHole].par.toString();
    String handicap = players[0].holes[currentHole].strokeIndex.toString();
    return 'Par: ' + par + ' | ' + 'Hdcp: ' + handicap;
  }

}