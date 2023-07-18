import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/cubit/profile/student_profile_states.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';

import '../../models/student_profile_model.dart';
import '../../models/teacher_profile_model.dart';


class Profiles_cubit extends Cubit<Profiles_states>{
  Profiles_cubit():super(init_profile_states());

  static Profiles_cubit get(context)=>BlocProvider.of(context);

  bool is_editing=false;

  edit_toggle(){
    is_editing=!is_editing;
    emit(is_editing_states());
  }
  close_edit(){
    is_editing=false;
    emit(editing_closed_state());
  }

  teacher_profile_model ?teacher_model;
  Future get_Teacher_profile({
    required int teacher_id
  })async{
    emit(Loading_get_teacher_profile());
    await DioHelper.postData(url: 'getTeacher',
        data: {
          'teacher_id':teacher_id
        }
    ).then((value){
      teacher_model=teacher_profile_model.fromJson(value.data);
      emit(Success_get_teacher_profile());
    }).catchError((error){
      print('get_Teacher_profile_Error : ${error.response.data}');
      emit(Error_get_teacher_profile(error));
    });
  }

  Student_profile_model ?student_profile_model;
  Future get_Student_profile({
  required int student_id
})async{
    emit(Loading_get_student_profile());
    await DioHelper.postData(url:'getStudent',
    data: {
      'student_id':student_id
    }).then((value){
     emit(Success_get_student_profile());
     student_profile_model=Student_profile_model.fromJson(value.data);
    }).catchError((error){
      print(error.response.data);
      emit(Error_get_student_profile(error.toString()));
    });
  }



}