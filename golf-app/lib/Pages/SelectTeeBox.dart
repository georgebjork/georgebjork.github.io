import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_app/utils/MatchProvider.dart';
import 'package:golf_app/utils/RoundProvider.dart';
import 'package:golf_app/utils/Player.dart';
import 'package:golf_app/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../Components/AppBar.dart';
import '../Components/CustomButton.dart';
import '../utils/Course.dart';
import '../Components/CheckBox.dart';

class SelectTeeBox extends StatefulWidget {
  @override
  SelectTeeBoxState createState() => SelectTeeBoxState();
}

class SelectTeeBoxState extends State<SelectTeeBox> {
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Select Teebox",
                style: GoogleFonts.openSans(fontSize: 26, color: Colors.black)),
            const SizedBox(
              height: 20,
            ),
            Text(context.read<RoundProvider>().course.courseName,
                style: GoogleFonts.openSans(fontSize: 15, color: Colors.grey)),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child:
                  Consumer<RoundProvider>(builder: (context, provider, child) {
                return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                          color: Colors.black,
                        ),
                    itemCount: provider.players.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        trailing: TeePicker(provider.players[
                            index]), // give the tee picker a player to give a teebox;
                        leading: const Icon(
                          Icons.account_circle_outlined,
                          size: 35,
                        ),
                        title: Text(
                            provider.players[index].firstName +
                                ' ' +
                                provider.players[index].lastName,
                            style: GoogleFonts.openSans(
                                fontSize: 14, color: Colors.black)),
                        subtitle: Text('Hdcp: 0.0',
                            style: GoogleFonts.openSans(
                                fontSize: 10, color: Colors.grey)),
                      );
                    });
              }),
            ),
            navButtons(),
            const SizedBox(
              height: 30,
            )
          ]),
        ));
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
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/enterScore', ModalRoute.withName('/home'));
                    dynamic match = context.read<RoundProvider>().createMatch();
                    context.read<MatchProvider>().setMatch(match);
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

class TeePicker extends StatefulWidget {
  Player p;
  TeePicker(this.p, {Key? key}) : super(key: key);
  @override
  TeePickerState createState() => TeePickerState(p);
}

class TeePickerState extends State<TeePicker> {
  Player p;
  TeePickerState(this.p);

  int selectedValue = -1;

  showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: CupertinoPicker(
              backgroundColor: Colors.white,
              onSelectedItemChanged: (index) {
                setState(() {
                  //we will make the selected value to be the id of the tee box as an easy way to tell which tee box is which
                  selectedValue = index;
                });
                p.teeBox = context.read<RoundProvider>().teeBox[index];
                context.read<RoundProvider>().updatePlayer(p);
                print('Selcted item: $index');
              },
              itemExtent: 62.0,
              //This will read from the tee box list in round provider and map each item to a center widget with the following text
              children: context
                  .read<RoundProvider>()
                  .teeBox
                  .map((item) => Center(
                        child: Text(item.name +
                            ': ' +
                            item.rating.toString() +
                            '/' +
                            item.slope.toString() +
                            '/' +
                            item.par.toString()),
                      ))
                  .toList(),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: showPicker,
      child: Text(
          selectedValue == -1
              ? 'TeeBox'
              : context.read<RoundProvider>().teeBox[selectedValue].name,
          style: GoogleFonts.openSans(fontSize: 14, color: Colors.grey)),
    );
  }
}
