import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/admins/admins_list_cubit.dart';
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
    var cubit = AdminsListCubit.get(context);
    return BlocConsumer<AdminsListCubit, AdminsListState>(
      listener: (context, state) {
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
        return ConditionalBuilder(
          condition: cubit.adminsModel != null,
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
                    title('Admins', width),
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
                          adminPagination(context,width,height,paginationController,cubit),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=> Center(
            child: SpinKitWeb(width),
          ),
        );
      },
    );
  }
}