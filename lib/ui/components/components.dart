 import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

Widget Text_Icon_Button({
   required VoidCallback Function,
   required double width,
   required String text,
   Color color= Colors.white70,
   IconData icon=Icons.door_back_door,
 }){
  return TextButton(onPressed: Function, child: Row(children: [
    Text(text,style: TextStyle(color:color,fontSize: 18),),
    SizedBox(width: width/120,),
    Icon(icon,color: Colors.white60,)
  ],));
 }

 Widget Animated_Text({
   required double width,
   required String text,
    int speed=500,
   bool isRepeating=false,
   List<Color>colors_list= const [Colors.blue,Colors.lightBlueAccent,Colors.white]
 }){
  return AnimatedTextKit(
    isRepeatingAnimation: isRepeating,
    animatedTexts: [
      ColorizeAnimatedText(text,
          speed: Duration(milliseconds: speed),
          colors: colors_list,
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width/50
          )
      ),
    ],
  );
 }