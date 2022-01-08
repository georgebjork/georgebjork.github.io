import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/utils/RoundProvider.dart';
import 'package:golf_app/utils/Player.dart';
import 'package:golf_app/utils/UserProvider.dart';
import 'package:golf_app/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../Components/AppBar.dart';
import '../Components/CustomButton.dart';
import '../utils/Course.dart';
import '../Components/CheckBox.dart';
import '../utils/RoundProvider.dart';

class AddPlayers extends StatefulWidget {
  @override
  AddPlayersState createState() => AddPlayersState();
}

class AddPlayersState extends State<AddPlayers> {
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
              Text("Select Players",
                  style: GoogleFonts.openSans(fontSize: 26, color: Colors.black)),
              //search bar
              const SizedBox(
                height: 10,
              ),
              SearchBar(),

              //favorites
              const SizedBox(height: 20),
              Text('Friends:',
                  style: GoogleFonts.openSans(fontSize: 16, color: Colors.black)),
              Friends(),

              //bottom group of buttons
              Container(alignment: Alignment.bottomLeft, child: navButtons()),

              const SizedBox(height: 30,)
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

class Friends extends StatefulWidget {
  @override
  FriendsState createState() => FriendsState();
}

class FriendsState extends State<Friends> {
  List<Player> selectedPlayers = [];

  void initState() {
    context.read<RoundProvider>().players.clear();
    //add user to the front of the player list
    context.read<RoundProvider>().players.add(context.read<UserProvider>().user);
    //set selectedPlayers list equal to the provider list becayse we have the user in it
    selectedPlayers = context.read<RoundProvider>().players;
  }

  Widget build(BuildContext context) {
    //this function will check if a player is in the list already
    bool checkFriends(Player p) {
      if(selectedPlayers.contains(p)){
        return true;
      }
      
      return false;
    }

    return Expanded(
        child: Consumer<RoundProvider>(builder: (context, provider, child) {
      return FutureBuilder(
          future: provider.friends.isEmpty ? provider.getFriends() : null,
          builder: (context, snapshot) {
            return ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.black,
                    ),
                shrinkWrap: true,
                itemCount: provider.friends.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        //If in the selected players list. Remove player
                        if (selectedPlayers.contains(provider.friends[index]) == true) {
                          selectedPlayers.remove(provider.friends[index]);
                          //update provider players
                          context.read<RoundProvider>().players = selectedPlayers;
                        }
                        //else add it but first check to make sure we dont exceed the 3 player limit.
                        else {
                          if (selectedPlayers.length != 4) {
                            selectedPlayers.add(provider.friends[index]);
                            //update provider players
                            context.read<RoundProvider>().players =
                                selectedPlayers;
                          }
                        }
                      });
                    },
                    trailing:
                        const Icon(Icons.star, size: 30.0, color: Colors.black),
                    leading: checkFriends(provider.friends[index])
                        ? CheckMarkBox(isChecked: true)
                        : CheckMarkBox(isChecked: false),
                    title: Text(
                        provider.friends[index].firstName +
                            ' ' +
                            provider.friends[index].lastName,
                        style: GoogleFonts.openSans(
                            fontSize: 14, color: Colors.black)),
                    subtitle: Text('Hdcp: 0.0',
                        style: GoogleFonts.openSans(
                            fontSize: 10, color: Colors.grey)),
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

    return Container(
        child: Column(children: [
      SizedBox(height: _height / 30),
      //first 2 buttons
      Row(
        children: <Widget>[
          Expanded(
              child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  width: double.infinity,
                  text: 'Prev',
                  color: HexColor("#CFB784"))),
          SizedBox(width: _width / 10),
          Expanded(
              child: CustomButton(
                  onPressed: () async {
                    for (int i = 0; i < context.read<RoundProvider>().players.length; i++) {
                      print(context.read<RoundProvider>().players[i].firstName);
                    }
                    Navigator.pushNamed(context, '/selectTeeBox');
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
            Navigator.popUntil(context, ModalRoute.withName('/home'));
            context.read<RoundProvider>().course = Course('null', -1);
          },
          width: double.infinity,
          text: 'Cancel',
          color: HexColor("#A13333")),
    ]));
  }
}
