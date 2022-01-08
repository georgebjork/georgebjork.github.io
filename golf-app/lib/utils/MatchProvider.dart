import 'package:flutter/cupertino.dart';
import 'package:golf_app/utils/Matches/Skins.dart';

class MatchProvider with ChangeNotifier {

  //This will be our match, we just dont know what kind of match it will be
  late dynamic match;
  
  void setMatch(dynamic m){
    match = m; 
  }

}