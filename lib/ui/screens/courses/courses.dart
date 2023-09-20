import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/cubit/courses/course_cubit.dart';
import '../../../cubit/courses/course_state.dart';


class Courses extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<Courses_cubit, Courses_State>(
      listener: (context, state) {},
      builder: (context, state) {
        Courses_cubit cubit = Courses_cubit.get(context);

        return Container(child: Text('courses'),);
      },
    );
  }
}
