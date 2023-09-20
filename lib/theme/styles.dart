

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'colors.dart';

const Circle_BoxDecoration=BoxDecoration(
shape: BoxShape.circle,
color: Colors.white
);

var CircularBorder_decoration=BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20)
);

var BigCircularBorder_decoration=BoxDecoration(
    color: Colors.white10,
    borderRadius: BorderRadius.circular(60)
);

TextStyle Number_TextStyle({
  required width,
  FontWeight fontWeight=FontWeight.w100,
  Color color= Colors.grey
}){
  return TextStyle(
      fontWeight: fontWeight,
      fontSize: width/100,color:color,
  );
}

TextStyle Name_TextStyle({
  required width,
  Color color=Colors.lightBlue
}){
  return TextStyle(
    fontWeight: FontWeight.bold,fontSize: width/70,color:color,
    overflow: TextOverflow.ellipsis,
  );
}

TextStyle email_TextStyle({
  required width,
}){
  return TextStyle(
    fontWeight: FontWeight.w500,fontSize: width/100,color: Colors.grey.shade400,
    overflow: TextOverflow.ellipsis,
  );
}

TextStyle normal_TextStyle({
  required width,
  Color color=Colors.white
}){
  return TextStyle(
    fontWeight: FontWeight.w500,fontSize: width/100,color: color,
    overflow: TextOverflow.ellipsis,
  );
}

//////////////drop_item_sedra
ButtonStyleData drop_button_style({
  required double width
})
{
  return ButtonStyleData(
    height: height/16,
    width: width/7,
    padding: const EdgeInsets.only(left: 14, right: 14),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
          color: Colors.lightBlue,
          width: 2
      ),
      color: basic_background,
    ),
    elevation: 10,
  );
}
IconStyleData drop_icon_style({
   IconData icon=Icons.arrow_drop_down,
   Color icon_color=Colors.lightBlue,
   double size=30
}){
  return IconStyleData(
  icon: Icon(icon,
   color: Colors.lightBlue,
),
iconSize: size,
);}

InputDecoration drop_decoration(){
  return  InputDecoration(
    counterStyle: TextStyle(color: Colors.lightBlue),
    isDense:true,
    contentPadding: EdgeInsets.zero,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );
}


///////////////

/*
var side_text=TextStyle(fontSize: 13,fontWeight: FontWeight.w500,
      color: Colors.grey.shade300);

*/
BoxDecoration three_color_container({
  double borderradius=29,
  Color first_color=Colors.blue,
  Color sec_color=Colors.lightBlue,
  Color third_color=Colors.lightBlueAccent,
  bool with_shadow=true
}){
  return BoxDecoration(
    borderRadius: BorderRadius.circular(borderradius),
    gradient:  LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [first_color,sec_color,third_color]
    ),
    boxShadow: [
      (with_shadow)?BoxShadow(
        color: Colors.grey.shade400,
        blurRadius: 13.0,
        spreadRadius: 3,
        offset: Offset(8, 10,),
      ):const BoxShadow(color: Colors.white,spreadRadius: 0)
    ],
  );
}
var shadow=BoxShadow(
color: Colors.grey.shade400,
blurRadius: 13.0,
spreadRadius: 3,
offset: Offset(8, 10,),
);

var light_gry_shadow= BoxShadow(
    blurRadius: 20,
    spreadRadius: 5,
    color: Colors.grey.shade400,
    offset: Offset(1,1)
);

var light_blue_shadow= BoxShadow(
    blurRadius: 20,
    spreadRadius: 5,
    color: Colors.blue.shade100,
    offset: Offset(1,1)
);


book_style_container(){
  return BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Color.fromARGB(255, 0, 40, 72),
          width: 20.0,
        ),
        left: BorderSide(
          color: Colors.white24,
          width: 28.0,
        ),
      ),
      color: Color.fromARGB(255, 0, 101, 180),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          blurRadius: 5.0,
          spreadRadius: 3,
          offset: Offset(8, 10,),
        ),
        BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 5.0,
            spreadRadius: 4,
            offset: Offset(1, 7)
        )
      ]
  );
}


book_small_style_container(){
  return BoxDecoration(
      border: Border(
        top: BorderSide(
          color: Color.fromARGB(255, 0, 40, 72),
          width: 5.0,
        ),
        left: BorderSide(
          color: Colors.white24,
          width: 8.0,
        ),
      ),
      color: Color.fromARGB(255, 0, 101, 180),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          blurRadius: 3.0,
          spreadRadius: 1,
          offset: Offset(8, 10,),
        ),
        BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 3.0,
            spreadRadius: 1,
            offset: Offset(1, 7)
        )
      ]
  );
}