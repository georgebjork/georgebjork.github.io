import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hexcolor/hexcolor.dart';



class CheckMarkBox extends StatelessWidget {

  
  const CheckMarkBox({
    Key? key,
    required this.isChecked
  }) : super(key: key);

  final bool isChecked;
  
  

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      //An animated contatiner makes to color change with an animation
      duration: const Duration(milliseconds: 3000), //how long the animation is
      curve: Curves.fastLinearToSlowEaseIn,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0), //Makes the box a circle
          border: isChecked
              ? null
              : Border.all(
                  color: Colors.grey,
                  width:
                      2.0), //If the it is not selected then we will have a see through circle with a grey border
          color: isChecked
              ? HexColor('#89A057')
              : Colors.transparent), //If it is selected then it will be red
      width: 25,
      height: 25,
      child: isChecked
          ? const Icon(
              //Sets an icon to the check box
              Icons.check,
              color: Colors.white,
              size: 15)
          : null,
    );
  }
}
