import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../theme/styles.dart';
import '../components/components.dart';

Widget Inbox_Presentation({
  required double height,
  required double width,
}){
  return Padding(
    padding:  EdgeInsets.only(top: height/12),
    child: Container(
        padding: EdgeInsets.only(top: height/20,left:height/2.7),
        height: height/5,width: width/1.2,
        decoration: CircularBorder_decoration,
        child: Animated_Text(width: width*1.2, text: 'Complaints')),
  );
}

Widget Init_Inbox({
  required double width
}){
  return Padding(
    padding: EdgeInsets.only(left: width/25,top: height/15,bottom: height/25),
    child: Text('All Complaints',style: TextStyle(fontSize: width/80,
        fontWeight: FontWeight.w600,
        color: Colors.lightBlue),),
  );
}

Widget inbox_cell({
  required double width,
  required dynamic item
}){
  return Padding(
    padding:  EdgeInsets.only(left: height/15,bottom: height/40,right: height/15),
    child: Container(
      padding: EdgeInsets.all(height/30),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 126, 208, 246).withOpacity(.4),
          borderRadius: BorderRadius.circular(25)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${item['name']}',style: Name_TextStyle(width: width/1.2),),
          SizedBox(height: height/100,),
          Text('${item['message']}')
        ],
      ),
    ),
  );

}