import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/teachers/teachers_list_cubit.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/components/table_components.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';
import 'package:school_dashboard/ui/widgets/teachers/teachers_list_widgets.dart';

class Teachers_List extends StatelessWidget{

  var nameController = TextEditingController();
  
  var nameFocusNode = FocusNode();
  
  final NumberPaginatorController paginationController = NumberPaginatorController();
  
  @override
  Widget build(BuildContext context) {
    final height = 753.599975586;
    //final height = heightSize/1.2500000000000000331740987392709;
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
  create: (context) => TeachersListCubit()..getTeachersTableData(name: '', paginationNumber: 0),
  child: BlocConsumer<TeachersListCubit, TeachersListState>(
      listener: (context, state) {
        var cubit = TeachersListCubit.get(context);
        if (state is TeachersErrorDataState) {
          showToast(text: state.teachersModel.message!, state: ToastState.error);
        }

        if (state is TeachersDeletingSuccessDataState) {
          showToast(text: 'Deleted Successfully', state: ToastState.success);
          cubit.getTeachersTableData(name: '', paginationNumber: 0);
        }

        if (state is TeachersErrorDataState) {
          showToast(text: state.teachersModel.message!, state: ToastState.error);
        }
      },
      builder: (context, state) {
        var cubit = TeachersListCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.teachersModel != null,
          builder:(context)=> SingleChildScrollView(
            controller: Basic_Cubit.get(context).scrollController,
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.02, vertical: height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Animated_Text(width: width, text: 'Teachers'),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  routeRow('Teachers List', width, context),
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
                            subTitle('All Teachers Data', width),
                            SizedBox(
                              width: width * 0.47,
                            ),
                            clearDataButton(context,width,height,cubit,2),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            searchByNameTeacher(context, width, height, nameController, nameFocusNode),
                            SizedBox(
                              width: width * 0.08,
                            ),
                            searchButtonTeacher(width, height, cubit, nameController),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        dataTableTeachers(context, width, height, cubit, cubit.teachersModel!),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        cubit.teachersModel!.data!.teachersList!.isNotEmpty ? Container() : Center(child: Text('There are no teachers yet',style: TextStyle(fontSize: width*0.02,fontWeight: FontWeight.w600,color: Colors.blue),)),
                        cubit.teachersModel!.data!.teachersList!.isNotEmpty ? Container() :SizedBox(
                          height: height * 0.06,
                        ),
                        teacherPagination(width,height,paginationController,cubit,nameController),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (context)=> Center(
            child: SpinKitWeb(width),
          ),
        );
      },
    ),
);
  }
}