import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/utils/MatchProvider.dart';
import 'package:golf_app/utils/Matches/Skins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../Components/CustomButton.dart';

class EnterScore extends StatefulWidget {

  EnterScoreState createState() => EnterScoreState();
}

class EnterScoreState extends State<EnterScore> {

  Widget build(context){
    Skins match = context.read<MatchProvider>().match;
    return Scaffold(
      backgroundColor: HexColor("#EEEEEE") ,
      appBar: AppBar(
        backgroundColor: HexColor("#EEEEEE"),
        elevation: 0,
        leading: const Icon(null),
      ),
      body: Container(
         padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Title
            Header(),
            //Enter Scores 
            Expanded(child: Center(child: match.displayTextAgain(context))),
            //Scoreboard 

            //NavButtons
            navButtons(),

            const SizedBox(
              height: 30,
            )
          ],
        ) 
      ),
    );
  }
}

class Header extends StatelessWidget {


  Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    //This is temporary for displaying data purposes
    Skins s = context.read<MatchProvider>().match;
    return Container(
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(s.course.courseName, style: GoogleFonts.openSans(fontSize: 16, color: Colors.black)),
          SizedBox(height: 15,),
          Text(s.getCurrentHole(), style: GoogleFonts.openSans(fontSize: 26, color: Colors.black)),
          Text(s.getCurrentHoleDetails(), style: GoogleFonts.openSans(fontSize: 14, color: Colors.black)),
          s.displayText(context)
        ],
      ),
    );
  }
}


class navButtons extends StatelessWidget {
  

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    const double topBottomPadding = 10.0;

    return Container(
        child: Column(children: [
      SizedBox(height: _height / 30),
      //first 2 buttons
      Row(
        children: <Widget>[
          Expanded(
              child: CustomButton(
                  onPressed: () {
                   
                  },
                  width: double.infinity,
                  text: 'Prev',
                  color: HexColor("#CFB784"))),
          SizedBox(width: _width / 10),
          Expanded(
              child: CustomButton(
                  onPressed: () {
                    
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
           
          },
          width: double.infinity,
          text: 'Cancel',
          color: HexColor("#A13333")),
    ]));
  }
}