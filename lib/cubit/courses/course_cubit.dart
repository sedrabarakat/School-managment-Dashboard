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


  Map<String,dynamic>student_in_course={};
  Future get_student_in_course({
  required int session_id
})async{
    emit(Loading_get_Student_for_session());
    return DioHelper.postData(url: 'getStudentsForSession',
    token: token,
    data: {
      'session_id':session_id
    }).
    then((value){
      student_in_course=value.data;
      print(student_in_course);
      emit(Success_get_Student_for_session());
    }).
    catchError((error){
      print(error.response.data);
      emit(Error_get_Student_for_session(error));
    });
  }
  
  Future confirm_booking({
  required int session_id,
    required int student_id
})async{
    emit(Loading_Confirm_booking());
    DioHelper.postData(url: 'confirmBooking',
    token: token,
    data: {
      'session_id':session_id,
      'student_id':student_id,
    }).
    then((value){
      get_student_in_course(session_id: 4);
      emit(Success_Confirm_booking());
    }).
    catchError((error){
      emit(Error_Confirm_booking(error));
    });
  }










}



