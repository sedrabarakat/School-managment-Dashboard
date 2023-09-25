import 'dart:ui';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/courses/course_cubit.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/components/table_components.dart';
import 'package:school_dashboard/ui/widgets/courses/sessions_list_widgets.dart';
import '../../../cubit/courses/course_state.dart';


class Courses extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print(heightSize);
    final height = 753.599975586;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider.value(
      value: Courses_cubit()..get_Sessions(),
      child: BlocConsumer<Courses_cubit, Courses_State>(
          listener: (context, state) {
            var cubit = Courses_cubit.get(context);
            if (state is Error_get_sessions) {
              showToast(text: state.errorModel!.message!, state: ToastState.error);
            }

            if (state is Success_delete_session) {
              showToast(text: 'Deleted Successfully', state: ToastState.success);
              cubit.get_Sessions();
            }

            if (state is Error_delete_session) {
              showToast(text: state.errorModel.message!, state: ToastState.error);
            }

          },
          builder: (context, state) {
            var cubit = Courses_cubit.get(context);
            return ConditionalBuilder(
              condition: cubit.sessionsModel != null,
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
                      Animated_Text(width: width, text: 'Sessions'),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      routeRow('Sessions List', width, context),
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
                            SizedBox(
                              height: height * 0.05,
                            ),
                            dataTableSessions(
                              context,
                              width,
                              height,
                              cubit,
                              cubit.sessionsModel!,
                            ),
                            SizedBox(height: height*0.05,),
                            cubit.sessionsModel!.data!.isNotEmpty ? Container() : Center(child: Text('There are no sessions yet',style: TextStyle(fontSize: width*0.02,fontWeight: FontWeight.w600,color: Colors.blue),)),
                            cubit.sessionsModel!.data!.isNotEmpty ? Container() :SizedBox(
                              height: height * 0.06,
                            ),
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
