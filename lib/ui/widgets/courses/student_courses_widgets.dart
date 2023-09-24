import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_dashboard/theme/styles.dart';

import '../../../constants.dart';
import '../../../cubit/courses/course_cubit.dart';
import '../../components/components.dart';

Widget Init_student_course_cell({
  required double width
}){
  return Padding(
    padding: EdgeInsets.only(left: width/15,right: width/20,top: height/15,),
    child: Row(
      children: [
        Text('Name',style: TextStyle(fontSize: width/80,
            fontWeight: FontWeight.w600,
            color: Colors.lightBlue),),
        SizedBox(width: width/3.5,),
        Text('Reserve',style: TextStyle(fontSize: width/80,fontWeight: FontWeight.w600,color: Colors.lightBlue),),
        SizedBox(width: width/6.5,),
        Text('Taken',style: TextStyle(fontSize: width/80,fontWeight: FontWeight.w600,color: Colors.lightBlue),),
      ],
    ),
  );
}



Widget student_course_cell({
  required double width,
  required String name,
  required String status,
  required int stuid,
  required Courses_cubit cubit
}){
  return Padding(
    padding: EdgeInsets.only(left: width/15,right: width/20),
    child: Row(
      children: [
        SizedBox(
          width: width/8,
          child: Text('$name',overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.w600,fontSize: width/110)
          ,),
        ),
        SizedBox(width: width/5,),
        SizedBox(
          width: width/10,
          child: Text('${(status=='0')?'Not Paid':'Paid'}',style:normal_TextStyle(width: width,
          color: (status=='0')?Colors.red.shade500:Colors.lightBlue.shade500),),
        ),
        SizedBox(width: width/13,),
        elevatedbutton(
            backgroundColor: (status=='0')?Colors.red.shade700:Colors.lightBlue,
            Function: (){
              if(status=='0')
              cubit.confirm_booking(session_id: 4, student_id: stuid);
            },
            widthSize: width/15,
            heightSize: height/20, text:(status=='0')?'Tap if paid':'has Paid')
      ],
    ),
  );
}