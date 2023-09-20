import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/constants.dart';
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











}



