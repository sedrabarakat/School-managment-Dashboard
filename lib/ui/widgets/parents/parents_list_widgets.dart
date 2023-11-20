import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/parents/parents_list_cubit.dart';
import 'package:school_dashboard/models/Tables/parents_table.dart';
import 'package:collection/collection.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';

import '../../../routes/web_router.dart';


Widget searchByNameParent(context,width,height,nameController,nameFocusNode,phoneFocusNode){
  return Container(
    width: width * 0.18,
    height: height * 0.06,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.symmetric(
        horizontal: width * 0.02),
    child: def_TextFromField2(
      onFieldSubmitted: (val) {
        FocusScope.of(context)
            .requestFocus(phoneFocusNode);
      },
      keyboardType: TextInputType.text,
      controller: nameController,
      focusNode: nameFocusNode,
      hintText: 'Search by Name ...',
    ),
  );
}

Widget searchByPhoneParent(context,width,height,phoneController,phoneFocusNode){
  return Container(
    width: width * 0.18,
    height: height * 0.06,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.symmetric(
        horizontal: width * 0.02),
    child: def_TextFromField2(
      keyboardType: TextInputType.text,
      controller: phoneController,
      focusNode: phoneFocusNode,
      hintText: 'Search by Phone ...',
      labelStyle: TextStyle(
          fontSize: width * 0.01,
          color: Colors.black),
    ),
  );
}

Widget searchButtonParent(width,height, ParentsListCubit cubit,
    TextEditingController nameController,
    TextEditingController phoneController,){
  return Container(
    width: width * 0.11,
    height: height * 0.06,
    decoration: BoxDecoration(
      color: Colors.blue.shade800,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade800,
        textStyle: TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        cubit.getParentsTableData(
          name: nameController.text,
          phoneNumber: phoneController.text,
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
        ),),
    ),
  );
}


List<DataColumn2> getParentsColumns(ParentsListCubit cubit) => cubit.ParentsColumns.map(
      (String column) => DataColumn2(label: Text(column), onSort: cubit.onSort),
).toList();

List<DataRow> getParentsRows(
    List<ParentData> allParents, width, heigth, context ,ParentsListCubit cubit) =>
    allParents
        .mapIndexed(
          (
          index,
          ParentData pa,
          ) =>
          DataRow2(
            selected: cubit.selectedParents.contains(pa),
            onSelectChanged: (isSelected){
              cubit.isSelected(isSelected, pa);
            },
            onTap: () {},
            cells: [
              //st is object
              DataCell(Text('${index + 1}')),
              DataCell(Text(pa.name!)),
              DataCell(Text(pa.gender!)),
              DataCell(Text(pa.phone_number!)),
              DataCell(IconButton(
                onPressed: () {
                    awsDialogDeleteForOne(context, width, cubit, 4, pa.parent_id!);
                },
                icon: Icon(
                  Icons.delete,
                  size: width * 0.015,
                ),
              )),
              DataCell(
                IconButton(
                  onPressed: () {
                    parent_id=pa.parent_id!.toInt();
                    print(parent_id);
                 //   Basic_Cubit.get(context).routing(route: '/add_student',context: context);
                    W_Router.router.go('/parents_list/$parent_id/add_student');
                  },
                  icon: Icon(
                    Icons.add,
                    size: width * 0.015,
                  ),
                ),
              ),
            ],
          ),
    )
        .toList();

Widget dataTableParents(context,width,height,ParentsListCubit cubit, ParentsModel model){
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
        columnSpacing: width*0.08,
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
        columns: getParentsColumns(cubit),
        rows: getParentsRows(model.data!.parentsList!,width,heightSize,context,cubit),),
    ),
  );
}

Widget parentPagination(
    width,
    height,
    paginationController,
    ParentsListCubit cubit,
    TextEditingController nameController,
    TextEditingController phoneNumber,

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
            cubit.getParentsTableData(
                name: nameController.text,
                phoneNumber: phoneNumber.text,
                paginationNumber: index);
          },
        ),
      ),
        SizedBox(width: width<1100 ?width*0.01 : width*0.04,),
      ]
  );
}