import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/admins/admins_list_cubit.dart';
import 'package:school_dashboard/models/Tables/admins_table.dart';
import 'package:collection/collection.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';

Widget searchByRoleAdmin(
    context, width, height, roleController, roleFocusNode) {
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
      controller: roleController,
      focusNode: roleFocusNode,
      hintText: 'Search by Role ...',
    ),
  );
}

Widget searchButtonStudent(
    width,
    height,
    AdminsListCubit cubit,
    TextEditingController nameController,
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
        cubit.getAdminsTableData(
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

List<DataColumn2> getAdminsColumns(AdminsListCubit cubit) => cubit.adminsColumns.map(
      (String column) => DataColumn2(label: Text(column), onSort: cubit.onSort),
).toList();

List<DataRow> getAdminsRows(
    List<AdminData> allAdmins, width, heigth, context ,AdminsListCubit cubit) =>
    allAdmins
        .mapIndexed(
          (
          index,
          AdminData ad,
          ) =>
          DataRow2(
            selected: cubit.selectedAdmins.contains(ad),
            onSelectChanged: (isSelected){
              cubit.isSelected(isSelected, ad);
            },
            onTap: () {},
            cells: [
              //st is object
              DataCell(Text('${index + 1}' ?? "")),
              DataCell(Text(ad.name! ?? "")),
              DataCell(Text(ad.role! ?? "")),
              DataCell(Text(ad.email! ?? "")),
              DataCell(Row(
                children: [
                  IconButton(
                    onPressed: () {
                      awsDialogDeleteForOne(context, width, cubit, 5, ad.admin_id!);
                    },
                    icon: Icon(
                      Icons.delete,
                      size: width * 0.015,
                    ),
                  ),
                ],
              )),
            ],
          ),
    )
        .toList();

Widget dataTableAdmins(context,width,height,AdminsListCubit cubit, AdminsModel model){
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    child: Container(
      child: DataTable(
        sortAscending: cubit.isAscending,
        sortColumnIndex: cubit.sortColumnIndex,
        onSelectAll: (isSelectedAll){
          cubit.onSelectAll(isSelectedAll!);
        },
        dividerThickness: 2,
        columnSpacing: width*0.11,
        headingRowHeight: height * 0.06,
        showCheckboxColumn: true,
        headingRowColor:
        MaterialStateProperty.all(Colors.white54),
        headingTextStyle: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold),
        dataTextStyle: const TextStyle(
          fontSize: 15,
        ),
        horizontalMargin: 12,
        //minWidth: 600,
        columns: getAdminsColumns(cubit),
        rows: getAdminsRows(model.data!.adminsList!,width,heightSize,context,cubit),),
    ),
  );
}


Widget adminPagination(
    context,
    width,
    height,
    paginationController,
    AdminsListCubit cubit,) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children:[ SizedBox(
        width: width<1100 ? width * 0.7: width*0.33,
        height: width<1100 ? height * 0.06:height * 0.08,
        child: NumberPaginator(
          initialPage: cubit.currentIndex,
          numberPages: cubit.paginationNumberSave ?? 1,
          onPageChange: (int index) async {
            cubit.getAdminsTableData(
                paginationNumber: index,
            );
          },
        ),
      ),
        SizedBox(width: width<1100 ?width*0.01 : width*0.04,),
      ]
  );
}