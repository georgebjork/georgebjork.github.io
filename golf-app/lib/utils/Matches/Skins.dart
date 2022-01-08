import 'package:flutter/cupertino.dart';

import '../Player.dart';
import '../Course.dart';
import '../Match.dart';

class Skins extends Match{


  //Constructor
  Skins(Course course, List<Player> players) : super(course, players);


  

  Widget displayText(BuildContext context){
    return Container(
      child: Text('Hello from skins class'),
    );
  }  

  Widget displayTextAgain(BuildContext context){
    return Container(
      child: Text('Hello from skins class again'),
    );
  }  


  

}
