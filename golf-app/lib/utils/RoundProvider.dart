

import 'package:flutter/cupertino.dart';
import 'package:golf_app/utils/Matches/Skins.dart';

import 'Course.dart';
import 'Hole.dart';
import 'Player.dart';
import 'TeeBox.dart';
import 'constants.dart';

class RoundProvider with ChangeNotifier {
  
  //Create a default course
  Course course = Course('null', -1); 

  //A list of all teeboxs for a course
  List<TeeBox> teeBox = []; 

  //Get players with the current user as the default 
  List<Player> players = [];

  //All of the friends for the user
  List<Player> friends = [];

  //This will hold in memory already access hole data to prevent too many requests 
  List<List<Hole>> recentHoles = [];


  // This will set the course to be played
  void setCourse(Course c){
    course = c; 
    print('Match course is: ' + c.courseName);
  }


  //Get the user and add them to the front of the players list
  void getUserPlayer() async {
    Player p = await service.getPlayer(supabase.auth.currentUser!.id);
    players.add(p);
  }


  //This will get all of the tee boxs for a course 
  void getTeeBox() async {
    teeBox = await service.getTeeBox(course.courseID);
  }

  //Get all of the friends for the user
  Future<void> getFriends() async {
    friends = await service.getFriends();
  }



  //this will update a player in the player list
  void updatePlayer(Player p) async {
    
    for(int i = 0; i < players.length; i++){
      //if the ids match, then replace with p
      if(players[i].uuid == p.uuid){
        p = await getHoles(p);
        players[i] = p;
        break;
      }
    }
  }


  //Given a player id, this will get all of the necessary hole data for them
  Future<Player> getHoles(Player p) async {
   
    //We will checkt to see if we already have the data we need stored in memory
    if(recentHoles.isEmpty == false) {
      //Go through all the hole data
      for(int i = 0; i < recentHoles.length; i++) {
        //If the teebox id match then set it to the player
        if(recentHoles[i][0].teeBoxId == p.teeBox.id){
          p.holes = recentHoles[i];
          return p;
        }
      }
    }

    //else we will make an api request
    p.holes = await service.getHoles(p.teeBox.id);
    //Add to memory 
    recentHoles.add(p.holes);

    return p;
  }

  
  //Create a match 
  Skins createMatch() {

    Skins skins = Skins(course, players);

    return skins; 
  }
}