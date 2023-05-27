

import 'package:flutter/material.dart';

const Circle_BoxDecoration=BoxDecoration(
shape: BoxShape.circle,
color: Colors.white
);

var CircularBorder_decoration=BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20)
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

/*
var side_text=TextStyle(fontSize: 13,fontWeight: FontWeight.w500,
      color: Colors.grey.shade300);

*/