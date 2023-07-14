import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/students/students_list_cubit.dart';
import 'package:school_dashboard/models/Tables/students_table.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';

Widget searchByNameStudent(
    context, width, height, nameController, nameFocusNode, classFocusNode) {
  return Container(
    width: width * 0.18,
    height: height * 0.06,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
    child: def_TextFromField2(
      onFieldSubmitted: (val) {
        FocusScope.of(context).requestFocus(classFocusNode);
      },
      keyboardType: TextInputType.text,
      controller: nameController,
      focusNode: nameFocusNode,
      hintText: 'Search by Name ...',
    ),
  );
}

Widget searchByClassStudent(
    context, width, height, classController, classFocusNode, sectionFocusNode) {
  return Container(
    width: width * 0.18,
    height: height * 0.06,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.symmetric(horizontal: width * 0.02),
    child: def_TextFromField2(
      onFieldSubmitted: (val) {
        FocusScope.of(context).requestFocus(sectionFocusNode);
      },
      keyboardType: TextInputType.text,
      controller: classController,
      focusNode: classFocusNode,
      hintText: 'Search by Class ...',
    ),
  );
}

Widget searchBySectionStudent(
    context, width, height, sectionController, sectionFocusNode) {
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
      controller: sectionController,
      focusNode: sectionFocusNode,
      hintText: 'Search by Section ...',
      labelStyle: TextStyle(fontSize: width * 0.01, color: Colors.black),
    ),
  );
}

Widget searchButtonStudent(
  width,
  height,
  StudentsListCubit cubit,
  TextEditingController nameController,
  TextEditingController classController,
  TextEditingController sectionController,
) {
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
        textStyle: const TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        cubit.getStudentsTableData(
          name: nameController.text,
          grade: classController.text,
          section: sectionController.text,
          paginationNumber: 0,
        );
      },
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

List<DataColumn2> getStudentsColumns(StudentsListCubit cubit) =>
    cubit.StudentsColumns.map(
      (String column) => DataColumn2(label: Text(column), onSort: cubit.onSort),
    ).toList();

List<DataRow> getStudentsRows(
  List<StudentData> allStudents,
  width,
  heigth,
  context,
  StudentsListCubit cubit,
) =>
    allStudents
        .mapIndexed(
          (
            index,
            StudentData st,
          ) =>
              DataRow2(
            selected: cubit.selectedStudents.contains(st),
            onSelectChanged: (isSelected) {
              cubit.isSelected(isSelected, st);
            },
            onTap: () {},
            cells: [
              //st is object
              DataCell(Text('${index + 1}')),
              DataCell(Text(st.name!)),
              DataCell(Text(st.gender!)),
              DataCell(Text(st.grade!.toString())),
              DataCell(Text(st.section!.toString())),
              DataCell(Text(st.parent_name!)),
              /*DataCell(
                Container(
                  width: width * 0.06,
                  height: heigth * 0.03,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      textStyle: TextStyle(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      AwsDialog(context, 1, width);
                    },
                    child: Center(
                      child: Text(
                        'Absent',
                        style: TextStyle(
                            fontSize: width * 0.01,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/
              DataCell(Row(
                children: [
                  IconButton(
                    onPressed: () {
                      awsDialogDeleteForOne(
                          context, width, cubit, 1, st.student_id!);
                      //AwsDialogwithbuttons(context, 4, width, 1);
                    },
                    icon: Icon(
                      Icons.delete,
                      size: width * 0.015,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
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

Widget dataTableStudents(
    context, width, height, StudentsListCubit cubit, StudentsModel model) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: DataTable(
      sortAscending: cubit.isAscending,
      sortColumnIndex: cubit.sortColumnIndex,
      onSelectAll: (isSelectedAll) {
        cubit.onSelectAll(isSelectedAll!);
      },
      dividerThickness: 2,
      columnSpacing: width * 0.07,
      headingRowHeight: height * 0.06,
      showCheckboxColumn: true,
      headingRowColor: MaterialStateProperty.all(Colors.white54),
      headingTextStyle:
          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      dataTextStyle: const TextStyle(
        fontSize: 15,
      ),
      horizontalMargin: 12,
      //minWidth: 600,
      columns: getStudentsColumns(cubit),
      rows: getStudentsRows(
          model.data!.studentsList!, width, heightSize, context, cubit),
    ),
  );
}

Widget studentPagination(
    context,
    width,
    height,
    paginationController,
    StudentsListCubit cubit,
    TextEditingController nameController,
    TextEditingController classController,
    TextEditingController sectionController) {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    SizedBox(
      width: width < 1100 ? width * 0.7 : width * 0.33,
      height: width < 1100 ? height * 0.06 : height * 0.08,
      child: NumberPaginator(
        initialPage: cubit.currentIndex,
        numberPages: cubit.paginationNumberSave!,
        onPageChange: (int index) async {
          cubit.getStudentsTableData(
              name: nameController.text,
              grade: classController.text,
              section: sectionController.text,
              paginationNumber: index);
        },
      ),
    ),
    SizedBox(
      width: width < 1100 ? width * 0.01 : width * 0.04,
    ),
  ]);
}

Widget sendNotesButton(context, width, height, StudentsListCubit cubit,
    titleController, titleFocusNode, messageController, messageFocusNode,formKey) {
  return Container(
    width: width < 600 ? width * 0.16 : width * 0.14,
    height: height * 0.05,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        textStyle: const TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        openDialog(context, width, height, cubit, titleController,
            titleFocusNode, messageController, messageFocusNode,formKey
        );
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Send a Notification',
          style: TextStyle(
            fontSize: width * 0.009,
            color: Colors.white,
          ),
        ),
        Icon(
          Icons.person,
          color: Colors.white,
          size: width * 0.009,
        ),
      ]),
    ),
  );
}

Widget absentButton(context, width, height, cubit) {
  return Container(
    width: width < 600 ? width * 0.16 : width * 0.14,
    height: height * 0.05,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        textStyle: const TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        awsDialogNote(context, width, cubit, 1, TextEditingController(),
            TextEditingController());
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Absent Students',
          style: TextStyle(
            fontSize: width * 0.009,
            color: Colors.white,
          ),
        ),
        Icon(
          Icons.person,
          color: Colors.white,
          size: width * 0.009,
        ),
      ]),
    ),
  );
}

Future<String?> openDialog(
        context,
        width,
        height,
        StudentsListCubit cubit,
        TextEditingController titleController,
        titleFocusNode,
        TextEditingController messageController,
        messageFocusNode,
        formKey,
    ) =>
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Sending a Notification:',
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: width * 0.02,
        ),
        content: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.02, vertical: height * 0.02),
          child: Container(
            height: height * 0.28,
            width: width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: TextStyle(
                        fontSize: width * 0.012, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: height * 0.012,
                  ),
                  def_TextFromField(
                      onFieldSubmitted: (value){
                        FocusScope.of(context)
                            .requestFocus(messageFocusNode);
                      },
                      fillColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller: titleController,
                      focusNode: titleFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Text(
                    'Message',
                    style: TextStyle(
                        fontSize: width * 0.012, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: height * 0.012,
                  ),
                  def_TextFromField(
                    maxLines: 2,
                    fillColor: Colors.white,
                    keyboardType: TextInputType.text,
                    controller: messageController,
                    focusNode: messageFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter message';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: width * 0.01),
            ),
          ),
          SizedBox(
            width: width * 0.05,
          ),
          TextButton(
            onPressed: () {
              awsDialogNote(
                  context, width, cubit, 2, titleController, messageController);
            },
            child: Text(
              'Send',
              style: TextStyle(
                  fontWeight: FontWeight.w400, fontSize: width * 0.01),
            ),
          ),
        ],
      ),
    );
