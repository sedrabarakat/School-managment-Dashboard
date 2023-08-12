import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/students/students_list_cubit.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/components/table_components.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';
import 'package:school_dashboard/ui/widgets/students/students_list_widgets.dart';

class Students_List extends StatelessWidget {
  Students_List({Key? key}) : super(key: key);

  var nameController = TextEditingController();

  var classController = TextEditingController();

  var sectionController = TextEditingController();

  var nameFocusNode = FocusNode();

  var classFocusNode = FocusNode();

  var sectionFocusNode = FocusNode();



  var titleController = TextEditingController();

  var messageController = TextEditingController();

  var titleFocusNode = FocusNode();

  var messageFocusNode = FocusNode();

  final NumberPaginatorController paginationController =
      NumberPaginatorController();


  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(heightSize);
    final height = 753.599975586;
    //final height = 941.9999694824219;
    //final height = heightSize / 1.2500000000000000331740987392709;
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
  create: (context) => StudentsListCubit()..getStudentsTableData(name: '', grade: '', section: '', paginationNumber: 0),
  child: BlocConsumer<StudentsListCubit, StudentsListState>(
        listener: (context, state) {
          var cubit = StudentsListCubit.get(context);
          if (state is StudentsErrorDataState) {
            showToast(text: state.studentsModel.message!, state: ToastState.error);
          }

          if (state is StudentsDeletingSuccessDataState) {
            showToast(text: 'Deleted Successfully', state: ToastState.success);
            cubit.getStudentsTableData(name: '', grade: '', section: '', paginationNumber: 0);
          }

          if (state is StudentsDeletingErrorDataState) {
            showToast(text: state.studentsModel.message!, state: ToastState.error);
          }

          if (state is StudentsAbsentSuccessState) {
            showToast(text: 'A Notification sent successfully', state: ToastState.success);
          }

          if (state is StudentsSendNoteSuccessState) {
            Navigator.pop(context);
            showToast(text: 'A Notification sent successfully', state: ToastState.success);
          }


        },
        builder: (context, state) {
          var cubit = StudentsListCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.studentsModel != null,
            builder: (context) => SingleChildScrollView(
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
                    Animated_Text(width: width, text: 'Students'),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    routeRow('Students List', width, context),
                    SizedBox(
                      height: height * 0.055,
                    ),
                    // white
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.04, horizontal: width * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              subTitle('All Students Data', width),
                              SizedBox(
                                width: width * 0.15,
                              ),
                              sendNotesButton(context,width,height,cubit,titleController,titleFocusNode,messageController,messageFocusNode,formKey),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              absentButton(context, width, height,cubit),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              clearDataButton(context, width, height,cubit, 1),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              searchByNameStudent(
                                  context,
                                  width,
                                  height,
                                  nameController,
                                  nameFocusNode,
                                  classFocusNode),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              searchByClassStudent(
                                  context,
                                  width,
                                  height,
                                  classController,
                                  classFocusNode,
                                  sectionFocusNode),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              searchBySectionStudent(context, width, height,
                                  sectionController, sectionFocusNode),
                              SizedBox(
                                width: width * 0.08,
                              ),
                              searchButtonStudent(
                                  width,
                                  height,
                                  cubit,
                                  nameController,
                                  classController,
                                  sectionController),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          dataTableStudents(
                            context,
                            width,
                            height,
                            cubit,
                            cubit.studentsModel!,
                          ),
                          SizedBox(height: height*0.05,),
                          cubit.studentsModel!.data!.studentsList!.isNotEmpty ? Container() : Center(child: Text('There are no students yet',style: TextStyle(fontSize: width*0.02,fontWeight: FontWeight.w600,color: Colors.blue),)),
                          cubit.studentsModel!.data!.studentsList!.isNotEmpty ? Container() :SizedBox(
                            height: height * 0.06,
                          ),
                          studentPagination(
                              context,
                              width,
                              height,
                              paginationController,
                              cubit,
                              nameController,
                              classController,
                              sectionController),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context) => Center(
              child: SpinKitWeb(width),
            ),
          );
        }
        ),
);
  }
}
