

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/parents/parents_list_cubit.dart';
import 'package:school_dashboard/models/Tables/parents_table.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/components/table_components.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';
import 'package:school_dashboard/ui/widgets/parents/parents_list_widgets.dart';

class Parents_List extends StatelessWidget {
   Parents_List({Key? key}) : super(key: key);

  var nameController = TextEditingController();

  var phoneController = TextEditingController();
  
  var nameFocusNode = FocusNode();

  var phoneFocusNode = FocusNode();
  
  final NumberPaginatorController paginationController = NumberPaginatorController();
  
  @override
  Widget build(BuildContext context) {
    final height = 753.599975586;

    //final height = heightSize/1.2500000000000000331740987392709;
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var cubit = ParentsListCubit.get(context);
    return BlocConsumer<ParentsListCubit, ParentsListState>(
      listener: (context, state) {
        if (state is ParentsErrorDataState) {
          showToast(text: state.parentsModel.message!, state: ToastState.error);
        }

        if (state is ParentsDeletingSuccessDataState) {
          showToast(text: 'Deleted Successfully', state: ToastState.success);
          cubit.getParentsTableData(name: '', phoneNumber: '', paginationNumber: 0);
        }

        if (state is ParentsDeletingErrorDataState) {
          showToast(text: state.parentsModel.message!, state: ToastState.error);
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.parentsModel != null,
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
                    title('Parents', width),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    routeRow('Parents List', width, context),
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
                              subTitle('All Parents Data', width),
                              SizedBox(
                                width: width * 0.47,
                              ),
                              clearDataButton(context,width,height,cubit,4),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              searchByNameParent(context, width, height, nameController, nameFocusNode, phoneFocusNode),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              searchByPhoneParent(context, width, height, phoneController, phoneFocusNode),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              searchButtonParent(width, height, cubit, nameController, phoneController),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          dataTableParents(context, width, height, cubit, cubit.parentsModel!),
                          SizedBox(
                            height: height * 0.06,
                          ),
                          //pagination(width,1),
                          parentPagination(width,height,paginationController,cubit,nameController,phoneController),
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
