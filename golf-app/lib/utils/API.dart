import 'package:golf_app/utils/Hole.dart';
import 'package:golf_app/utils/TeeBox.dart';
import 'package:golf_app/utils/constants.dart';

import 'Course.dart';
import 'Player.dart';

class Api {

  final user = supabase.auth.currentUser;
  final String userid = supabase.auth.currentUser!.id;

  Future<String> getName() async {

     final res = await supabase
        .from('users')
        .select('first_name')
        .eq('id', userid)
        .execute();

    return res.data[0]['first_name'];
  }

  Future<double> getHandicap() async{
    return 0.0;
  }

  Future<Course> getCourse(String name) async {
    
    final res = await supabase
      .from('Course')
      .select()
      .eq('name', name)
      .execute();
    
    Course course = Course.fromJson(res.data[0]);

    return course;
  }


  Future<List<Course>> getFavoriteCourses() async {
    List<Course> courses = [];

    final res = await supabase
      .rpc('getfavorites',  params: { 'u_id' : userid }).execute();
    
    List<dynamic> body = res.data;

    courses = body.map((dynamic c) => Course.fromJson(c)).toList();
    
    return courses;
  }

  Future<Player> getPlayer(String uuid) async {
    
    //run query
    final res = await supabase
      .from('users')
      .select()
      .eq('id', uuid)
      .execute();
    
    Player player = Player.fromJson(res.data[0]);

    return player;

  }

  Future<List<Player>> getFriends() async {
    List<Player> friends = [];

    final res = await supabase
      .rpc('getfriends',  params: { 'u_id' : userid }).execute();
    
    List<dynamic> body = res.data;

    friends = body.map((dynamic c) => Player.fromJson(c)).toList();
    
    return friends;

  }

  Future<List<TeeBox>> getTeeBox(int c_id) async {
    List<TeeBox> teebox = [];

    final res = await supabase
      .from('tee_box')
      .select()
      .eq('course_id', c_id)
      //.order('id', ascending: true)
      .execute();

    List<dynamic> body = res.data;

    teebox = body.map((dynamic c) => TeeBox.fromJson(c)).toList();

    return teebox;
  }

  Future<List<Hole>> getHoles(int teeBoxId) async {
    List<Hole> holes = [];

    final res = await supabase 
      .from('hole')
      .select()
      .eq('tee_box_id', teeBoxId)
      .execute();

      List<dynamic> body = res.data;

    holes = body.map((dynamic c) => Hole.fromJson(c)).toList();

    return holes;
  }
  

}
