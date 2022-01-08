import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/utils/RoundProvider.dart';
import 'package:golf_app/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../Components/AppBar.dart';
import '../Components/CustomButton.dart';
import '../utils/Course.dart';
import '../Components/CheckBox.dart';

class PickCourse extends StatefulWidget {
  @override
  PickCourseState createState() => PickCourseState();
}

class PickCourseState extends State<PickCourse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: HexColor("#EEEEEE"),
            elevation: 0,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  size: 50.0,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            )),
        drawer: const Drawer(),
        backgroundColor: HexColor("#EEEEEE"),
        body: Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text("Select Course",
                  style:
                      GoogleFonts.openSans(fontSize: 26, color: Colors.black)),
              //search bar
              const SizedBox(
                height: 10,
              ),
              SearchBar(),

              //favorites
              const SizedBox(height: 20),
              Text('Favorites:',
                  style:
                      GoogleFonts.openSans(fontSize: 16, color: Colors.black)),
              favoriteCourses(),

              //bottom group of buttons
              Container(alignment: Alignment.bottomLeft, child: navButtons()),

              const SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          context.showSnackBar(
              message: 'Search Pressed', backgroundColor: Colors.red);
        },
        child: const Text(
          "Search",
        ),
        style: TextButton.styleFrom(
          backgroundColor: HexColor('#D9D9D9'),
        ),
      ),
    );
  }
}

class favoriteCourses extends StatefulWidget {
  @override
  favoriteCoursesState createState() => favoriteCoursesState();
}

class favoriteCoursesState extends State<favoriteCourses> {

  
  List<Course> courses = [];
  late Course selectedCourse;

  void initState(){
    selectedCourse = context.read<RoundProvider>().course; 
  }

  Widget build(BuildContext context) {  
    
    

    Future<void> getFavorites() async {
      courses = await service.getFavoriteCourses();
    }

    return Expanded(
        child: Consumer<RoundProvider>(builder: (context, provider, child) {
          return FutureBuilder(
              future: courses.isEmpty? getFavorites() : null,
              builder: (context, snapshot) {
                return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                          color: Colors.black,
                        ),
                    shrinkWrap: true,
                    itemCount: courses.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        onTap:() {
                          setState(() {
                            provider.setCourse(courses[index]);
                            selectedCourse = courses[index];
                          });
                        },
                        trailing: const Icon(Icons.star,
                            size: 30.0, color: Colors.black),
                        leading: courses[index] == selectedCourse ? const CheckMarkBox(isChecked: true,) : const CheckMarkBox(isChecked: false,),
                        title: Text(courses[index].courseName,
                            style: GoogleFonts.openSans(
                                fontSize: 14, color: Colors.black)),
                      );
                    });
              });
        }));
  }
}

class navButtons extends StatelessWidget {
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    const double topBottomPadding = 10.0;

    void message() {
    context.showSnackBar(
        message: 'You must select a course', backgroundColor: Colors.red);
  }

    return Container(
        child: Column(children: [
      SizedBox(height: _height / 30),
      //first 2 buttons
      Row(
        children: <Widget>[
          Expanded(
              child: CustomButton(
                  onPressed: () {
                    context.read<RoundProvider>().course = Course('null', -1);
                    Navigator.pop(context);
                  },
                  width: double.infinity,
                  text: 'Prev',
                  color: HexColor("#CFB784"))),
          SizedBox(width: _width / 10),
          Expanded(
              child: CustomButton(
                  onPressed: () {
                    if(context.read<RoundProvider>().course.courseName == 'null'){
                      message();
                    } else{
                      Navigator.pushNamed(context, '/addPlayers');
                      //once course is set we will pull the teebox information
                      context.read<RoundProvider>().getTeeBox();
                    }
                  },
                  width: double.infinity,
                  text: 'Next',
                  color: HexColor("#C56824"))),
        ],
      ),

      SizedBox(
        height: _height / 30,
      ),

      CustomButton(
          onPressed: () {
            context.read<RoundProvider>().course = Course('null', -1);
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          },
          width: double.infinity,
          text: 'Cancel',
          color: HexColor("#A13333")),
    ]));
  }
}
