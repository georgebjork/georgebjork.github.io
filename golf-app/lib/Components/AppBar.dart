import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final HexColor color;
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: color,
        title: Text(title),
        centerTitle: true,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu_rounded, size: 50.0, ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ));
  }
}
