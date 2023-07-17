import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';

import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/students/students_list_cubit.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/screens/home/dashboard_home.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';

//Tables

Widget title(String s, width) {
  return Text(
    s,
    style: TextStyle(
        fontSize: width * 0.022,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5),
  );
}

Widget subTitle(String s, width) {
  return Text(
    s,
    style: TextStyle(
      fontSize: width * 0.018,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget routeRow(String s, width, context) {
  return Row(
    children: [
      TextButton(
          onPressed: () {
            Basic_Cubit.get(context).change_Route('/dashboard_home');
          },
          child: Text(
            'Home',
            style: TextStyle(color: Colors.blue, fontSize: width * 0.012),
          )),
      SizedBox(
        width: width * 0.01,
      ),
      Text(
        '->     ' + s,
        style: TextStyle(color: Colors.grey, fontSize: width * 0.012),
      ),
    ],
  );
}


Widget clearDataButton(context, width, height, cubit , typeCall) {
  return Container(
    width: width<600 ? width*0.18 :width * 0.14,
    height: height * 0.05,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        textStyle: TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        awsDialogDeleteForAll(context, width, cubit, typeCall);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Clear Selected Data',
            style: TextStyle(fontSize: width * 0.01, color: Colors.white),
          ),
          //SizedBox(width: width*0.01,),
          Icon(
            Icons.delete,
            color: Colors.white,
            size: width * 0.01,
          ),
        ],
      ),
    ),
  );
}

Widget pagination(
    width,
    height,
    typeCall,
    paginationController,
    StudentsListCubit cubit,
    TextEditingController nameController,
    TextEditingController classController,
    TextEditingController sectionController) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
        width: width * 0.31,
        height: height * 0.08,
        //height: 100,
        child: NumberPaginator(
          initialPage: 0,
          controller: paginationController,
          numberPages: 5,
          onPageChange: (int index) {
            cubit.getStudentsTableData(
                name: nameController.text,
                grade: classController.text,
                section: sectionController.text,
                paginationNumber: index,
            );
          },
        ),
      ),
      SizedBox(
        width: width * 0.05,
      ),
    ],
  );
}
