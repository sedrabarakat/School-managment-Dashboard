import 'package:bloc/bloc.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/models/course_model.dart';
import 'package:school_dashboard/models/studentCourseModel.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';
import 'package:school_dashboard/theme/colors.dart';

import '../../ui/screens/courses/courses.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(CourseInitial());

  static CourseCubit get(context) => BlocProvider.of(context);

  Color buttonColor = Colors.lightBlue;
  Color buttonReset = Colors.lightBlue;
  FontWeight textbuttonweightcreat = FontWeight.w300;
  FontWeight textbuttonweightreset = FontWeight.w300;
  // TextStyle buttontextstyle(width) {
  //   return TextStyle(
  //       color: Colors.white,
  //       fontWeight: FontWeight.w500,
  //       fontSize: width * 0.015);
  // }

  void onexitc_creat(PointerEvent details) {
    buttonColor = Colors.lightBlue;
    textbuttonweightcreat = FontWeight.w400;
    print('onExit');

    emit(updatebutton());
  }

  void onenter_creat(PointerEvent details) {
    buttonColor = shadow;
    textbuttonweightcreat = FontWeight.w900;
    print('onHover');
    emit(updatebutton());
  }

  void onexitc_reset(PointerEvent details) {
    buttonReset = Colors.lightBlue;
    textbuttonweightreset = FontWeight.w400;
    print('onExit');

    emit(updatebutton());
  }

  void onenter_reset(PointerEvent details) {
    buttonReset = Color.fromARGB(175, 177, 20, 9);
    textbuttonweightreset = FontWeight.w900;
    print('onHover');
    emit(updatebutton());
  }

  late List<String> teacher = [];
  late List<dynamic> teacherdata = [];

  void getTeachers() {
    print("fjnjnjnrjnrjfnjrnjr");
    DioHelper.getData(url: 'getTeachersForSessions',token: token,).then((value) {
      teacher = [];
      teacherdata = [];

      value.data['data'].forEach((v) {
        //print(v['grade']);
        teacher.add(v['name'].toString());
      });
      value.data['data'].forEach((v) {
        //print(v['grade']);
        teacherdata.add(v);
      });
      // classstud = value.data['data'][1]['grade'];
      print(teacher);
      print("dataclass iss $teacherdata");
      emit(updatedropdown());
    }).catchError(onError);
  }

  late List<String> teachersubjeects = [];
  late List<dynamic> datateachersubjeects = [];
  void getSubjectsWhereTeacher({required int teacherid}) {
    DioHelper.postData(url: 'getSubjectsWhereTeacher', data: {
      'teacher_id': teacherid,
    },token: token,).then((value) {
      teachersubjeects = [];
      datateachersubjeects = [];
      value.data['data'].forEach((v) {
        //print(v['grade']);
        teachersubjeects.add(v['name']);
      });
      value.data['data'].forEach((v) {
        datateachersubjeects.add(v);
      });

      emit(updatedropdown());
    }).catchError(onError);
  }

  void createSession(name, counter, subjects_has_teacher_id, price, date) {
    DioHelper.postData(url: 'createSession', data: {
      'body': name,
      'counter': counter,
      'subjects_has_teacher_id': subjects_has_teacher_id,
      'price': price,
      'date': date,
    },token: token,).then((value) {
      getSessions();
      print(value);
    }).catchError(onError);
  }

  GetSessionsModel? getSessionsModel;
  void getSessions() {
    DioHelper.getData(url: 'getSessions',token: token,).then((value) {
      getSessionsModel = GetSessionsModel.fromJson(value.data);

      print(getSessionsModel!.status);

      emit(updatedlistcourse());
    }).catchError(onError);
  }

  StudentsForSessionModel? studentsForSessionModel;
  void getStudentsForSession(session_id) {
    DioHelper.postData(url: 'getStudentsForSession', data: {
      'session_id': session_id,
    },token: token,).then((value) {
      studentsForSessionModel = StudentsForSessionModel.fromJson(value.data);

      print(studentsForSessionModel!.status);

      emit(updatedlistcourse());
    }).catchError(onError);
  }

  void confirmBooking(session_id, student_id) {
    DioHelper.postData(url: 'confirmBooking', data: {
      'session_id': session_id,
      'student_id': student_id,
    },token: token,).then((value) {
      getStudentsForSession(session_id);
      print(value.data);
      emit(updatedlistcourse());
    }).catchError(onError);
  }
}
