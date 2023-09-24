import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/models/course_model.dart';
import 'package:school_dashboard/models/error_model.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';
import 'course_state.dart';


class Courses_cubit extends Cubit<Courses_State> {
  Courses_cubit() : super(CourseInitial());

  static Courses_cubit get(context) => BlocProvider.of(context);

  Map<String,dynamic>teacher_for_session={};
  Future get_teacher_for_session()async{
    emit(Loading_get_teacher_for_session());
    DioHelper.getData(url: 'getTeachersForSessions',
        token: token).then((value){
      teacher_for_session=value.data;
      print(teacher_for_session);
      emit(Success_get_teacher_for_session());
    }).catchError((error){
      print(error.response.data);
      emit(Error_get_teacher_for_session(error.toString()));
    });
  }
  Map<String,dynamic>subject_for_session={};

  Future get_Subjects_Teacher({
  required int id
})async{
    emit(Loading_get_subject_for_session());
    DioHelper.postData(url: 'getSubjectsWhereTeacher',token: token,
    data: {
      'teacher_id':id
    })
        .then((value){
              subject_for_session=value.data;
              print(subject_for_session);
              emit(Success_get_subject_for_session());
            }).catchError((error){
                print(error.response.data);
              emit(Error_get_subject_for_session(error.toString()));
    });
  }

  Future create_Session({
  required String body,
    required int subjects_has_teacher_id,
    required int counter,
    required int price,
    required String date
})async{
    emit(Loading_Create_Session());
    DioHelper.postData(url: 'createSession',token: token,
      data: {
        'body':body,
        'counter':counter,
        'subjects_has_teacher_id':subjects_has_teacher_id,
        'price':price,
        'date':date
      }
    ).then((value) {
      emit(Success_Create_Session());
      print(value.data);
    }).catchError((error){
      print(error.response.data);
      emit(Error_Create_Session(error.toString()));
    });
  }

  //////////////////////////////////////////////////////////////////////////////

  final SessionsColumns = [
    "Id",
    "Teacher",
    "Subject",
    "Enrolled",
    "Price",
    "Date",
    "Editing",
  ];

  int? sortColumnIndex;
  bool isAscending = false;

  GetSessionsModel? sessionsModel;

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      sessionsModel!.data!.sort((user1, user2) => compareString(
          ascending,
          user1.sessionId!.toString(),
          user2.sessionId!.toString()));
    } else if (columnIndex == 1) {
      sessionsModel!.data!.sort(
              (user1, user2) => compareString(ascending, user1.teacherName!, user2.teacherName!));
    } else if (columnIndex == 2) {
      sessionsModel!.data!.sort((user1, user2) =>
          compareString(ascending, user1.subjectName!, user2.subjectName!));
    } else if (columnIndex == 3) {
      sessionsModel!.data!.sort((user1, user2) => compareString(
          ascending, user1.maximumStudents!.toString(), user2.maximumStudents!.toString()));
    } else if (columnIndex == 4) {
      sessionsModel!.data!.sort((user1, user2) =>
          compareString(ascending, user1.price!.toString(), user2.price!.toString()));
    } else if (columnIndex == 5) {
      sessionsModel!.data!.sort((user1, user2) => compareString(
          ascending, user1.date!.toString(), user2.date!.toString()));
    }

    this.sortColumnIndex = columnIndex;
    this.isAscending = ascending;
    emit(SessionsSortingColumn());
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);


  ErrorModel? errorModel;

  Future get_Sessions () async {
    emit(Loading_get_sessions());
    sessionsModel = null;
    DioHelper.getData(url: 'getSessions',token: token,
    ).then((value) {
      print('value.data: ${value.data}');
      sessionsModel = GetSessionsModel.fromJson(value.data);
      emit(Success_get_sessions());
      print(value.data);
    }).catchError((error){
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(Error_get_sessions(errorModel));
    });
  }

  Future delete_Session({required int sessionId}) async {

    emit(Loading_delete_session());
    DioHelper.postData(
        url: 'deleteSession',
        data: {
          'session_id' : sessionId
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');

      emit(Success_delete_session());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(Error_delete_session(errorModel!));
      print(error.toString());
    });
  }


}



