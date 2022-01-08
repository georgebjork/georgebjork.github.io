import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final HexColor color;
  final double width;
  final VoidCallback onPressed;


  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.width,
    required this.text,
    required this.color,

  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextButton(
        onPressed: onPressed,
        child: Center(
            child: Text(text,
                style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold))),
        style: TextButton.styleFrom(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 20.0),
            backgroundColor: color,
            //overlayColor: HexColor("#CFB784"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );
  }
}
