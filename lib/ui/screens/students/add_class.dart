

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/classes/classes_list_cubit.dart';
import 'package:school_dashboard/models/Tables/classes_table.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/components/table_components.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';
import 'package:school_dashboard/ui/widgets/classes/classes_list_widgets.dart';
import 'package:school_dashboard/ui/widgets/students/students_list_widgets.dart';

class ClassesList extends StatelessWidget {
   ClassesList({Key? key}) : super(key: key);


  final NumberPaginatorController paginationController = NumberPaginatorController();


  @override
  Widget build(BuildContext context) {
    final height = 753.599975586;

//    final height = heightSize/1.2500000000000000331740987392709;
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var cubit = ClassesListCubit.get(context);
    return BlocConsumer<ClassesListCubit, ClassesListState>(
      listener: (context, state) {
        if (state is ClassesErrorDataState) {
          showToast(text: state.classesModel.message!, state: ToastState.error);
        }

        if (state is ClassesDeletingSuccessDataState) {
          showToast(text: 'Deleted Successfully', state: ToastState.success);
          cubit.getClassesTableData();
        }

        if (state is ClassesDeletingErrorDataState) {
          showToast(text: state.classesModel.message!, state: ToastState.error);
        }

      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.classesModel != null,
          builder:(context)=> SingleChildScrollView(
            controller: scroll,
            scrollDirection: Axis.vertical,
            child: Container(
              color: basic_background,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.02, vertical: height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    title('Classes', width),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    routeRow('Classes List', width, context),
                    SizedBox(
                      height: height * 0.055,
                    ),
                    // white
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.04, horizontal: width * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              subTitle('All Classes Data', width),
                              SizedBox(
                                width: width * 0.312,
                              ),
                              AddClassButton(context,width,height),
                              SizedBox(
                                width: width * 0.04,
                              ),
                              clearDataButton(context,width,height,cubit,3),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          dataTableClasses(context, width, height, cubit, cubit.classesModel!),
                          SizedBox(
                            height: height * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>  Center(
            child: SpinKitWeb(width),
          ),
        );
      },
    );
  }
}
