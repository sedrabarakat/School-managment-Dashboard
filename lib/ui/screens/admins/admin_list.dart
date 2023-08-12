import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/admins/admins_list_cubit.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/components/table_components.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';
import 'package:school_dashboard/ui/widgets/admins/admins_list_widgets.dart';

class Admin_List extends StatelessWidget{
  Admin_List({Key? key}) : super(key: key);

  final NumberPaginatorController paginationController = NumberPaginatorController();

  @override
  Widget build(BuildContext context) {
    final height = 753.599975586;
 //   final height = heightSize/1.2500000000000000331740987392709;
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
  create: (context) => AdminsListCubit()..getAdminsTableData(paginationNumber: 0),
  child: BlocConsumer<AdminsListCubit, AdminsListState>(
      listener: (context, state) {
        var cubit = AdminsListCubit.get(context);
        if (state is AdminsErrorDataState) {
          showToast(text: state.adminsModel.message!, state: ToastState.error);
        }

        if (state is AdminsDeletingSuccessDataState) {
          showToast(text: 'Deleted Successfully', state: ToastState.success);
          cubit.getAdminsTableData(paginationNumber: 0);
        }

        if (state is AdminsDeletingErrorDataState) {
          showToast(text: state.adminsModel.message!, state: ToastState.error);
        }
      },
      builder: (context, state) {
        var cubit = AdminsListCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.adminsModel != null,
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
                  Animated_Text(width: width, text: 'Admins'),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  routeRow('Admins List', width, context),
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
                            subTitle('All Admins Data', width),
                            SizedBox(
                              width: width * 0.355,
                            ),
                            clearDataButton(context,width,height,cubit,5),
                          ],

                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        dataTableAdmins(context, width, height, cubit, cubit.adminsModel!),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        cubit.adminsModel!.data!.adminsList!.isNotEmpty ? Container() : Center(child: Text('There are no admin yet',style: TextStyle(fontSize: width*0.02,fontWeight: FontWeight.w600,color: Colors.blue),)),
                        cubit.adminsModel!.data!.adminsList!.isNotEmpty ? Container() :SizedBox(
                          height: height * 0.06,
                        ),
                        adminPagination(context,width,height,paginationController,cubit),
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