
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:school_dashboard/cubit/library/library_cubit.dart';

import '../../constants.dart';
import '../../theme/colors.dart';
import '../../theme/styles.dart';
import '../components/components.dart';
import 'class_widgets.dart';

Widget Book_Container({
  required double width,
  required var ImagePath
}){
  return Transform.rotate(
    angle: -45.0,
    child: Container(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.topCenter,
      height: height/3,width: width/4,
      decoration: book_style_container(),
      child: (ImagePath!=null)?
      Container(
          height: height/3,width: width/4,
          child: RotatedBox(
            quarterTurns: 1,
            child: Image.memory(
              Uint8List.fromList(ImagePath!),
              fit: BoxFit.fill,
            ),
          )
      ):
      Transform.rotate(angle: -4.7,child:Padding(
        padding:  EdgeInsets.only(bottom: width/8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: width/12,),
            Text('School Book',style: Name_TextStyle(width: width,color: Colors.blue.shade100),),
            SizedBox(height: height/12,),
          ],),
      ),),
    ),
  );
}

List<dynamic>Selected_id=[];

Widget multiselect({
  required double width,
  required List<dynamic>books
}){
  return MultiSelectDialog(
    title: Animated_Text(width: width/1.2, text: 'Select Books For Delete 📚',
        colors_list: [Colors.blue,Colors.lightBlueAccent,Colors.white]),//'Select For Delete'
    items: convert(available_list: books, intended: 'name'),
    initialValue: empty,
    searchIcon: Icon(Icons.search,color: Colors.blue,),
    searchable: true,
    onSelectionChanged: (value){
      Selected_id=value;
      print(Selected_id);
    },
    onConfirm: null,
    confirmText: Text(''),
    cancelText: Text(''),
  );
}

Widget Book_with_CoverButton({
  required double width,
  required var ImagePath,
  required Library_cubit cubit
}){
  return Stack(
    children: [
      Book_Container(width:width, ImagePath: ImagePath,),
      Padding(
        padding:  EdgeInsets.only(left: width/10,top: height/3.9),
        child: circle_icon_button(button_Function: (){
          cubit.add_cover();
          },
            icon: Icons.add, hint_message: 'Add Book Cover'),
      )
    ],);
}

Widget Go_Forward_Back({
  required ScrollController Scroll_controller
}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      circle_icon_button(
          button_Function: (){
            Scroll_controller.animateTo(
                1600, duration: Duration(milliseconds: 500),
                curve: Curves.easeInQuad  );},
          icon: Icons.arrow_forward_ios, hint_message: 'To Delete'),
      SizedBox(height: height/15,),
      circle_icon_button(
          button_Function: (){
            Scroll_controller.animateTo(
                -2000, duration: Duration(milliseconds: 500),
                curve: Curves.easeInQuad  );
          },
          icon: Icons.arrow_back_ios_sharp, hint_message: 'To Add'),
    ],);
}

Widget Library_Presentation({
  required double height,
  required double width,
}){
  return Padding(
    padding:  EdgeInsets.only(top: height/12,),
    child: Container(
        padding: EdgeInsets.only(top: height/20,left:height/4),
        height: height/5,width: width/1.2,
        decoration: CircularBorder_decoration,
        child: Animated_Text(width: width*1.2, text: 'School Library')),
  );
}

Widget Init_book_cell({
  required double width
}){
  return Padding(
    padding: EdgeInsets.only(left: width/10,right: width/20,top: height/15,bottom: height/25),
    child: Row(
      children: [
        Text('Name',style: TextStyle(fontSize: width/80,
            fontWeight: FontWeight.w600,
            color: Colors.lightBlue),),
        SizedBox(width: width/7,),
        Text('Available Date',style: TextStyle(fontSize: width/80,
            fontWeight: FontWeight.w600,
            color: Colors.lightBlue),),
        SizedBox(width: width/7.5,),
        Text('Reserve',style: TextStyle(fontSize: width/80,fontWeight: FontWeight.w600,color: Colors.lightBlue),),
        SizedBox(width: width/13,),
        Text('Taken',style: TextStyle(fontSize: width/80,fontWeight: FontWeight.w600,color: Colors.lightBlue),),
      ],
    ),
  );
}

Widget book_cell({
  required double width,
  required Library_cubit cubit,
  required var ImagePath,
  required String book_name,
  required String date,
  required int is_available,
  required int taken,
  required var library_student_id

}){
  return Padding(
    padding:  EdgeInsets.only(top: height/22,bottom: height/30),
    child: Row(
      children: [
        SizedBox(width: width/40,),
        small_book(width: width, ImagePath: ImagePath),
        SizedBox(width: width/40,),
        SizedBox(
          width: width/8,
          child: Text('$book_name',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.w500,fontSize: width/110),),
        ),
        SizedBox(width: width/15,),
        Text('$date',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: width/110),),
        SizedBox(width: width/6.5,),
        Text((is_available==1)?"Available":"Reserved",
          style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: width/105,
              color: (is_available==1)?Color.fromARGB(255, 56, 179, 255):Colors.red.shade700

          ),),
        SizedBox(width: width/15,),
        elevatedbutton(
            backgroundColor: (taken==0)?Colors.lightBlue:Colors.red.shade700,
            Function: (){
              //there si a book without reserve
              //if(is_available==1 && taken==0){}

              //Reserved but not taken
              if(is_available==0 && taken==0){
                cubit.Confirm_Booked(library_student_id: library_student_id);
                cubit.Get_Books();
              }
              //must restored
              if(is_available==0 && taken==1){
                cubit.Disconfirm_Booked(library_student_id: library_student_id);
                cubit.Get_Books();
              }


            },
            widthSize: width/15,
            heightSize: height/20, text: (taken==0)?"Stored":"Taken")
      ],),
  );
}

Widget small_book({
  required double width,
  required var ImagePath
}){
  return Transform.rotate(
    angle: -45.0,
    child: Container(
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.topCenter,
      height: height/15,width: width/20,
      decoration: book_small_style_container(),
      child: (ImagePath!=null)?
      Container(
          height: height/15,width: width/20,
          child: RotatedBox(
            quarterTurns: 1,
            child: ImageNetwork(
              image: "$ImagePath",
              debugPrint: false, height:  width/20,
              width: height/15,
            ),
          )
      ):
      Container(
          height: height/15,width: width/20,
          child: RotatedBox(
            quarterTurns: 1,
            child: Image.asset(
              "assets/images/ForBook.png",
              fit: BoxFit.fill,
            ),
          )
      )
    ),
  );
}