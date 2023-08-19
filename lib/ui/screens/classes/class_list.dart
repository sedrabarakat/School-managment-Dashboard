import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import '../../../constants.dart';
import '../../../cubit/class_profile/class_profile_states.dart';
import '../../../theme/colors.dart';
import '../../components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/cubit/classes/classes_list_cubit.dart';
import 'package:school_dashboard/ui/components/table_components.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';
import 'package:school_dashboard/ui/widgets/classes/classes_list_widgets.dart';
import '../../widgets/class_widgets.dart';
// Add_class(context:context,height: height,width: width);
class Class_List extends StatelessWidget{
  final NumberPaginatorController paginationController = NumberPaginatorController();
  @override
  Widget build(BuildContext context) {
    final height = 753.599975586;

//    final height = heightSize/1.2500000000000000331740987392709;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<ClassesListCubit, ClassesListState>(
        listener: (context, state) {
          var cubit = ClassesListCubit.get(context);
          if(state is Success_Add_Grade_States){showToast(text: 'Added Successfully', state: ToastState.success);cubit.getClassesTableData();}

          if(state is Error_Add_Grade_States){showToast(text: 'Faild in Adding...you have already added that class before', state: ToastState.error);}

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
          if (state is Success_Update_program_State) {
            showToast(text: 'Successfully Updated', state: ToastState.success);
            cubit.getClassesTableData();
          }
          if (state is Error_Update_program_State) {
            showToast(text: 'Error in Update', state: ToastState.error);
          }

        },
        builder: (context, state) {
          var cubit = ClassesListCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.classesModel != null,
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
                    Animated_Text(width: width, text: 'Classes'),
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
                          cubit.classesModel!.classesList!.isNotEmpty ? Container() : Center(child: Text('There are no Classes yet',style: TextStyle(fontSize: width*0.02,fontWeight: FontWeight.w600,color: Colors.blue),)),
                          cubit.classesModel!.classesList!.isNotEmpty ? Container() :SizedBox(
                            height: height * 0.06,
                          ),
                        ],
                      ),
                    ),
                  ],
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




