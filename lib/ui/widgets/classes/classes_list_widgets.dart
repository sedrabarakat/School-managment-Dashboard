import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/class_profile/class_profile_cubit.dart';
import 'package:school_dashboard/cubit/classes/classes_list_cubit.dart';
import 'package:school_dashboard/models/Tables/classes_table.dart';
import 'package:collection/collection.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/screens/classes/class_profile.dart';

import '../class_widgets.dart';

 int ?class_id;


List<DataColumn2> getClassesColumns(ClassesListCubit cubit) => cubit.ClassesColumns.map(
      (String column) => DataColumn2(label: Text(column), onSort: cubit.onSort),
).toList();

List<DataRow> getClassesRows(
    List<ClassData> allClasses, width, heigth, context ,ClassesListCubit cubit) =>
    allClasses
        .mapIndexed(
          (
          index,
          ClassData cl,
          ) =>
          DataRow2(
            selected: cubit.selectedClasses.contains(cl),
            onSelectChanged: (isSelected){
              cubit.isSelected(isSelected, cl);
            },
            onTap: () {},
            cells: [
              //st is object
              DataCell(Text('${index + 1}')),
              DataCell(Text(cl.grade.toString())),
              DataCell(Text(cl.sections.toString())),
              DataCell(Text(cl.students.toString())),
              DataCell(Text(cl.teachers.toString())),
              DataCell(Text(cl.subjects.toString())),
              DataCell(Row(
                children: [
                  IconButton(
                    onPressed: () {
                      awsDialogDeleteForOne(context, width, cubit, 3, cl.class_id!);
                    },
                    icon: Icon(
                      Icons.delete,
                      size: width * 0.015,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      class_id=cl.class_id!.toInt();
                      Basic_Cubit.get(context).change_Route('/class_profile');


                    },
                    icon: Icon(
                      Icons.edit,
                      size: width * 0.015,
                    ),
                  ),
                ],
              )),
            ],
          ),
    )
        .toList();

Widget dataTableClasses(context,width,height,ClassesListCubit cubit, ClassesModel model){
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: DataTable(
      onSelectAll: (isSelectedAll){
        cubit.onSelectAll(isSelectedAll!);
      },
      sortAscending: cubit.isAscending,
      sortColumnIndex: cubit.sortColumnIndex,
      dividerThickness: 2,
      columnSpacing: width*0.055,
      headingRowHeight: height * 0.06,
      showCheckboxColumn: true,
      headingRowColor:
      MaterialStateProperty.all(Colors.white54),
      headingTextStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold),
      dataTextStyle: TextStyle(
        fontSize: 15,
      ),
      horizontalMargin: 12,
      //minWidth: 600,
      columns: getClassesColumns(cubit),
      rows: getClassesRows(model!.classesList!,width,heightSize,context,cubit),),
  );
}




//BUTTON

Widget AddClassButton(context,width,height){
  return Container(
    width: width * 0.12,
    height: height * 0.05,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
    ),
    child: ElevatedButton(
      onPressed: (){
        Add_class(context:context,height: MediaQuery.sizeOf(context).height,width: width);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        textStyle: TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Class  +',
              style: TextStyle(fontSize: width * 0.01,color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}
