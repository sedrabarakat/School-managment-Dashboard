import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_dashboard/cubit/class_profile/marks_cubit.dart';
import 'package:school_dashboard/models/auth/login_model.dart';
import 'package:school_dashboard/models/error_model.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';
import 'package:school_dashboard/ui/screens/articals/all_articals.dart';
import 'package:school_dashboard/ui/screens/courses/courses.dart';
import 'package:school_dashboard/ui/screens/inbox/inbox.dart';
import 'package:school_dashboard/ui/screens/library/add_book.dart';
import 'package:school_dashboard/ui/screens/library/books_list.dart';

import 'package:school_dashboard/ui/screens/students/add_student.dart';

import 'package:school_dashboard/ui/screens/students/students_list.dart';
import 'package:school_dashboard/ui/screens/teachers/add_teacher.dart';
import 'package:school_dashboard/ui/screens/teachers/teachers_list.dart';

import '../../constants.dart';
import '../../routes/web_router.dart';
import '../../ui/screens/admins/add_admin.dart';
import '../../ui/screens/admins/admin_list.dart';
import '../../ui/screens/articals/add_articals.dart';
import '../../ui/screens/classes/class_list.dart';
import '../../ui/screens/classes/class_profile.dart';
import '../../ui/screens/courses/add_courses.dart';
import '../../ui/screens/courses/course_students_list.dart';
import '../../ui/screens/home/dashboard_home.dart';
import '../../ui/screens/login.dart';
import '../../ui/screens/parents/add_parent.dart';
import '../../ui/screens/parents/parents_list.dart';
import '../../ui/screens/students/student_profile.dart';
import '../../ui/screens/teachers/teacher_profile.dart';
import '../../ui/widgets/teachers/teachers_list_widgets.dart';

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

  String select_route=(admin_type==2)?"/books_list":'/dashboard_home';
   int su=27;
  final Map<String, Widget> screens = {
    '/login':LoginScreen(),
    '/dashboard_home':Dashboard_home(),
    '/add_parent': add_parent(),
    '/parents_list':Parents_List(),

    '/add_student':Add_Student(),
    '/students_list':Students_List(),

    '/students_list/student_profile/:Student_id':Student_profile(),

    '/add_teacher':Add_Teacher(),
    '/teachers_list':Teachers_List(),
    '/teachers_list/teacher_profile/:Teacher_id':Teacher_profile(),

    '/add_admin': Add_Admin(),
    '/admin_list':Admin_List(),

    '/class_list':Class_List(),//Class_List(),
    '/class_list/class_profile/:class_id':Class_Profile(),

    '/add_book':Add_Book(),
    '/books_list':Books_List(),

    '/all_articals':All_Articals(),
    '/add_articals': add_articals(),

    '/inbox':Inbox(),
    '/courses':Courses(),//Courses()
    '/add_courses':Add_Courses(),
    '/courses/course_students_list/:Sessions_id':course_student_list()
  };




  void routing({
    required var route,
    var context,
}){
    select_route=route;
    emit(Change_Route(route));
   // W_Router.router.go(route!);
  }


  void on_select(AdminMenuItem item){
    if(item.route != null){
      select_route=item.route!;
      W_Router.router.go(item.route!);
      //print(select_route);
      emit(Change_Route(select_route!));
    }}

void ss(){
    emit(Change_num());
  }

  bool backToTop = false;

  void scrollUp() {
    const double start = 0;
    scrollController.animateTo(start,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }


  LogoutModel? logutModel;

  ErrorModel? errorModel;

  Future logout() async {

    emit(LogoutLoadingState());
    DioHelper.postData(
        url: 'logout',
        data: {
          'deviceToken': '.',
        },
        token: token
    ).then((value) {
      print('value.data: ${value.data}');

      logutModel = LogoutModel.fromJson(value.data);

      emit(LogoutSuccessState(logutModel!));
    }).catchError((error) {
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(LogoutErrorState(errorModel!));
      print(error.toString());
    });

  }

}
/* /students_list/student_profile
    switch(route){
      case '/student_profile':
        W_Router.router.go('/students_list/student_profile');
        break;

      case '/teacher_profile':
        W_Router.router.go('/teachers_list/teacher_profile');
        break;

      case '/class_profile':
        W_Router.router.go('/class_list/class_profile');
        break;

      case '/course_students_list':
        W_Router.router.go('/add_courses/course_students_list');
        break;
      default:
        W_Router.router.go(route!);
    }*/