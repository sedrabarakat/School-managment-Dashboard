import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/teachers/teachers_list_cubit.dart';
import 'package:school_dashboard/models/Tables/teachers_table.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';

int ?Teacher_id;
Widget searchByNameTeacher(
    context, width, height, nameController, nameFocusNode) {
  return Container(
    width: width * 0.18,
    height: height * 0.06,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
    child: def_TextFromField2(
      keyboardType: TextInputType.text,
      controller: nameController,
      focusNode: nameFocusNode,
      hintText: 'Search by Name ...',
    ),
  );
}

Widget searchButtonTeacher(width, height, TeachersListCubit cubit, TextEditingController nameController) {
  return Container(
    width: width * 0.11,
    height: height * 0.06,
    decoration: BoxDecoration(
      color: shadow,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: shadow,
        textStyle: TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        cubit.getTeachersTableData(
          name: nameController.text,
          paginationNumber: cubit.paginationNumberSave!,
        );      },
      child: Center(
        child: Text(
          'Search',
          style: TextStyle(
              fontSize: width * 0.012,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    ),
  );
}

List<DataColumn2> getTeachersColumns(TeachersListCubit cubit) =>
    cubit.TeachersColumns.map(
      (String column) => DataColumn2(label: Text(column), onSort: cubit.onSort),
    ).toList();

List<DataRow> getTeachersRows(List<TeacherData> allTeachers, width, heigth,
        context, TeachersListCubit cubit) =>
    allTeachers
        .mapIndexed(
          (
            index,
          TeacherData te,
          ) =>
              DataRow2(
            selected: cubit.selectedTeachers.contains(te),
            onSelectChanged: (isSelected) {
              cubit.isSelected(isSelected, te);
            },
            onTap: () {},
            cells: [
              //st is object
              DataCell(Text('${index + 1}')),
              DataCell(Text(te.name!)),
              DataCell(Text(te.gender!)),
              DataCell(Text(te.salary!.toString())),
              DataCell(Text(te.phone_number!)),
              DataCell(Row(
                children: [
                  IconButton(
                    onPressed: () {
                      awsDialogDeleteForOne(context, width, cubit, 2, te.teacher_id!);
                    },
                    icon: Icon(
                      Icons.delete,
                      size: width * 0.015,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Teacher_id=te.teacher_id;
                      Basic_Cubit.get(context).change_Route('/teacher_profile');
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

Widget dataTableTeachers(context, width, height, TeachersListCubit cubit, TeachersModel model) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Container(
      child: DataTable(
        sortAscending: cubit.isAscending,
        sortColumnIndex: cubit.sortColumnIndex,
        onSelectAll: (isSelectedAll){
          cubit.onSelectAll(isSelectedAll!);
        },
        dividerThickness: 2,
        columnSpacing: width * 0.09,
        headingRowHeight: height * 0.06,
        showCheckboxColumn: true,
        headingRowColor: MaterialStateProperty.all(Colors.white54),
        headingTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        dataTextStyle: TextStyle(
          fontSize: 15,
        ),
        horizontalMargin: 12,
        //minWidth: 600,
        columns: getTeachersColumns(cubit),
        rows: getTeachersRows(model.data!.teachersList!, width, heightSize, context, cubit),
      ),
    ),
  );
}

Widget teacherPagination(
  width,
  height,
  paginationController,
  TeachersListCubit cubit,
  TextEditingController nameController,
) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children:[ SizedBox(
        width: width<1100 ? width * 0.7: width*0.33,
        height: width<1100 ? height * 0.06:height * 0.08,
        child: NumberPaginator(
          initialPage: cubit.currentIndex,
          numberPages: cubit.paginationNumberSave!,
          onPageChange: (int index) async {
            cubit.getTeachersTableData(
                name: nameController.text,
                paginationNumber: index);
          },
        ),
      ),
        SizedBox(width: width<1100 ?width*0.01 : width*0.04,),
      ]
  );
}
