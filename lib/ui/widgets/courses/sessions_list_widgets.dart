import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/courses/course_cubit.dart';
import 'package:school_dashboard/models/course_model.dart';
import 'package:school_dashboard/ui/components/components.dart';

int? Sessions_id;

List<DataColumn2> getSessionsColumns(Courses_cubit cubit) =>
    cubit.SessionsColumns.map(
      (String column) => DataColumn2(label: Text(column), onSort: cubit.onSort),
    ).toList();

List<DataRow> getSessionsRows(
  List<SessionData> allSessions,
  width,
  heigth,
  context,
  Courses_cubit cubit,
) =>
    allSessions
        .mapIndexed(
          (
            index,
            SessionData se,
          ) =>
              DataRow2(
            onTap: () {},
            cells: [
              //se is object
              DataCell(Text('${index + 1}')),
              DataCell(Text(se.teacherName!)),
              DataCell(Text(se.subjectName!)),
              DataCell(Text('${se.currentBooked!}/${se.maximumStudents}')),
              DataCell(Text(se.price.toString())),
              DataCell(Text(se.date!)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        awsDialogDeleteForOne(
                            context, width, cubit, 0, se.sessionId!);
                      },
                      icon: Icon(
                        Icons.delete,
                        size: width * 0.015,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Sessions_id = se.sessionId;
                        Basic_Cubit.get(context)
                            .change_Route('/course_students_list');
                      },
                      icon: Icon(
                        Icons.edit,
                        size: width * 0.015,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
        .toList();

Widget dataTableSessions(
    context, width, height, Courses_cubit cubit, GetSessionsModel model) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: DataTable(
      sortAscending: cubit.isAscending,
      sortColumnIndex: cubit.sortColumnIndex,
      dividerThickness: 2,
      columnSpacing: width * 0.06,
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
      columns: getSessionsColumns(cubit),
      rows: getSessionsRows(model.data!, width, heightSize, context, cubit),
    ),
  );
}
