import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_dashboard/ui/screens/articals/all_articals.dart';
import 'package:school_dashboard/ui/screens/courses/courses.dart';
import 'package:school_dashboard/ui/screens/inbox/inbox.dart';
import 'package:school_dashboard/ui/screens/library/add_book.dart';
import 'package:school_dashboard/ui/screens/library/books_list.dart';

import 'package:school_dashboard/ui/screens/students/add_student.dart';

import 'package:school_dashboard/ui/screens/students/students_list.dart';
import 'package:school_dashboard/ui/screens/teachers/add_teacher.dart';
import 'package:school_dashboard/ui/screens/teachers/teachers_list.dart';

import '../../ui/screens/admins/add_admin.dart';
import '../../ui/screens/admins/admin_list.dart';
import '../../ui/screens/articals/add_articals.dart';
import '../../ui/screens/classes/class_list.dart';
import '../../ui/screens/classes/class_profile.dart';
import '../../ui/screens/home/dashboard_home.dart';
import '../../ui/screens/parents/add_parent.dart';
import '../../ui/screens/parents/parents_list.dart';
import '../../ui/screens/students/student_profile.dart';
import '../../ui/screens/teachers/teacher_profile.dart';

part 'basic_cubit_state.dart';

class Basic_Cubit extends Cubit<Basic_State> {
  ScrollController scrollController;
  Basic_Cubit(this.scrollController) : super(HomeInitial()){

    scrollController.addListener(() {
      backToTop = scrollController.offset > 100 ? true : false;
      emit(ShowButtonScroll());
    });

  }

  static Basic_Cubit get(context)=>BlocProvider.of(context);

  String select_route='/dashboard_home';

  final Map<String, Widget> screens = {
    '/dashboard_home':Dashboard_home(),
    '/add_parent': add_parent(),
    '/parents_list':Parents_List(),

    '/add_student':Add_Student(),
    '/students_list':Students_List(),
    '/student_profile':Student_profile(),

    '/add_teacher':Add_Teacher(),
    '/teachers_list':Teachers_List(),
    '/teacher_profile':Teacher_profile(),

    '/add_admin': Add_Admin(),
    '/admin_list':Admin_List(),

    '/class_list':Class_List(),//Class_List(),
    '/class_profile':Class_Profile(),

    '/add_book':Add_Book(),
    '/books_list':Books_List(),

    '/all_articals':All_Articals(),
    '/add_articals': add_articals(),

    '/inbox':Inbox(),//Inbox()
    '/courses':Courses(),//Courses()
  };

  void on_select(AdminMenuItem item){
    if(item.route != null){
      select_route=item.route!;
      //print(select_route);
      emit(Change_Route(select_route));
    }}

  void change_Route(route){
    select_route=route;
    emit(Change_Route(select_route));
  }

  bool backToTop = false;

  void scrollUp() {
    const double start = 0;
    scrollController.animateTo(start,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }

}
