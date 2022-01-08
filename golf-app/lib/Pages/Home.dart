// ignore_for_file: prefer_const_constructors

import 'package:golf_app/Components/CustomButton.dart';
import 'package:golf_app/utils/Player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:golf_app/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Components/AppBar.dart';
import '../utils/UserProvider.dart';
import '../utils/constants.dart';
import '../utils/API.dart';
import '../components/auth_state.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends AuthState<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        color: HexColor('#89A057'),
        title: '',
      ),
      backgroundColor: HexColor("#EEEEEE"),
      drawer: Drawer(),
      body: Container(
          child: Column(
        children: [
          //top half with name and handicap
          playerDetails(),
          //Buttons
          navButtons(),
          //Future builder of prev rounds
        ],
      )),
    );
  }
}

class playerDetails extends StatefulWidget {
  @override
  playerDetailsState createState() => playerDetailsState();
}

class playerDetailsState extends State<playerDetails> {

  

  @override
  void initState() {
    super.initState();

    getUser();

  }

  Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? s = prefs.getString('name');

    s ??= await setName();
    return s; 
  }

  setName() async {
    String name = await getUser();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);

    return name; 
  }

  Future<String> getUser() async {

    Player p = await service.getPlayer(supabase.auth.currentUser!.id);
    //set our user in the provider
    context.read<UserProvider>().user = p; 

    return p.firstName;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height / 2.5;

    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      width: double.infinity,
      height: _height,
      decoration: BoxDecoration(
          color: HexColor("#89A057"),
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(35),
              bottomLeft: Radius.circular(35))),
      child: FutureBuilder(
          future: getName(),
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome,',
                    style: GoogleFonts.openSans(
                        fontSize: 26, color: Colors.white)),
                Text(snapshot.data == null ? '---' : snapshot.data.toString(),
                    style: GoogleFonts.openSans(
                        fontSize: 26, color: Colors.white)),
                Center(
                    child: FutureBuilder(
                        future: service.getHandicap(),
                        builder: (context, snapshot) {
                          return Column(children: [
                            SizedBox(height: _height / 9),
                            Text('Handicap',
                                style: GoogleFonts.openSans(
                                    fontSize: 16, color: Colors.white)),
                            Text(snapshot.data.toString(),
                                style: GoogleFonts.openSans(
                                    fontSize: 40, color: Colors.white)),
                            Text('Low: 0.0',
                                style: GoogleFonts.openSans(
                                    fontSize: 16, color: Colors.white))
                          ]);
                        }))
              ],
            );
          }),
    );
  }
}

class navButtons extends StatefulWidget {
  navButtonsState createState() => navButtonsState();
}

class navButtonsState extends State<navButtons> {
  void message() {
    context.showSnackBar(
        message: 'Button Pressed', backgroundColor: Colors.red);
  }

  Future<void> logout() async {
    final response = supabase.auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    const double topBottomPadding = 10.0;

    return Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(children: [
          SizedBox(height: _height / 30),
          //first 2 buttons
          Row(
            children: <Widget>[
              Expanded(
                  child: CustomButton(
                      onPressed: () {
                        logout();
                      },
                      width: double.infinity,
                      text: 'Stats',
                      color: HexColor("#CFB784"))),
              SizedBox(width: _width / 10),
              Expanded(
                  child: CustomButton(
                      onPressed: () {
                        message();
                      },
                      width: double.infinity,
                      text: 'Friends',
                      color: HexColor("#CFB784")))
            ],
          ),

          SizedBox(
            height: _height / 30,
          ),
          CustomButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pickCourse');
              },
              width: double.infinity,
              text: 'Start a new round',
              color: HexColor("#C56824"))
        ]));
  }
}
