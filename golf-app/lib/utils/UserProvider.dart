
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:provider/provider.dart';

import 'Course.dart';
import 'Player.dart';
import 'API.dart';
import 'TeeBox.dart';
import 'constants.dart';


 //All this provider will have is the user to provide easy access around the application 
class UserProvider with ChangeNotifier {
 
  late Player user; 

}