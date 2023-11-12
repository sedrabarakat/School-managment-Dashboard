import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/constants.dart';
import '../../models/available_teacher_model.dart';
import '../../models/class_profile_model.dart';
import '../../network/remote/dio_helper.dart';
import 'class_profile_states.dart';

class Class_Profile_cubit extends Cubit<Class_Profile_States>{

  Class_Profile_cubit():super(Class_init_Profile_States());

  static Class_Profile_cubit get(context)=>BlocProvider.of(context);



  Future Add_Sections({
    required String class_id,
    required int class_number,
  })async{
    print(class_number);
    emit(Loading_Add_Section_States());
    await DioHelper.postData(url: 'createSections',
        token: token,
        data: {
          'saf_id':class_id,
          'number':class_number
        }
    ).then((value){
      print(value.data);
      emit(Success_Add_Section_States());
    }).catchError((error){
      //print(error.response.data);
      emit(Error_Add_Section_States(error.toString()));
    });
  }

  Future Delete_section({
  required List<dynamic> ids
})async{
    emit(Loading_delete_section_State());
    await DioHelper.postData(url: 'deleteSections',
        token: token,
        data: {
        "ids":ids
    }).then((value){
      emit(Success_delete_section_State());

    }).catchError((error){
      print(error.response.data);
      emit(Error_delete_section_State(error.toString()));
    });
  }

  Future Add_subject({
    required String name,
    required int saf_id
  })async{
    emit(Loading_Add_Subject_States());
    await DioHelper.postData(url: 'createSubject',
        token: token,
        data: {
          'name':name,
          'saf_id':saf_id
        }
    ).then((value){
      emit(Success_Add_Subject_States());
      print(value.data);
    }).catchError((error){
      emit(Error_Add_Subject_States(error.toString()));
    });
  }

  Future Delete_Subject({
    required List<dynamic> ids
  })async{
    emit(Loading_delete_subject_State());
    await DioHelper.postData(url: 'deleteSubjects',
        token: token,
        data: {
          "ids":ids
        }).then((value){
      emit(Success_delete_subject_State());

    }).catchError((error){
      print(error.response.data);
      emit(Error_delete_subject_State(error.toString()));
    });
  }

  final List<String>sectionNumbers = [];

  final List<String>subjectNames = [];


  class_profile_model ?class_profile;
  List<dynamic>subjects=[];
  List<dynamic>sectionsInClass=[];
Future get_class_profile({
  required int class_id
})async{
    emit(Loading_get_class_States());
    await DioHelper.postData(url: 'getClass',
        token: token,
      data: {'class_id':class_id
    }
    ).then((value){
      class_profile=class_profile_model.fromJson(value.data);
      subjects=value.data['data']['subjects'];
      sectionsInClass=value.data['data']['sectionsInClass'];

      if (class_profile!.data != null && class_profile!.data!.sectionsInClass != null) {
        for (var section in class_profile!.data!.sectionsInClass!) {
          sectionNumbers.add(section.number.toString());
        }
      }

      if (class_profile!.data != null && class_profile!.data!.subjects != null) {
        for (var subject in class_profile!.data!.subjects!) {
          subjectNames.add(subject.name ?? "");
        }
      }

      emit(Success_get_class_States());
    }).catchError((error){
      print(error.response.data);
      emit(Error_get_class_States(error.toString()));
    });
}


Map<String,dynamic>?Hessas_Map;
Future get_Hessas({
  required int section_id,
})async{
  emit(Loading_get_hessas_State());
  await DioHelper.getData(url: 'getHessas/${section_id}',
      token: token).then((value){
    Hessas_Map=value.data;
    print('the get');
   print(Hessas_Map?['data']);
    emit(Success_get_hessas_State());
  }).catchError((error){
   // print(error.response.data);
    emit(Error_get_hessas_State(error.toString()));
  });
}
  Available_teacher_model ?available_model;

List<dynamic>available_list=[];
Future Get_Available_Teachers({
  required int saf_id,
  required int section_id
})async{
  emit(Loading_Available_teacher_State());
  await DioHelper.postData(
    url: 'GetAvailableTeachers',
      token: token,
    data: {
      'saf_id':saf_id,
      'section_id':section_id,
    }
  ).then((value){
   emit(Success_Available_teacher_State());
   available_list=value.data;
   print(available_list);
  }).catchError((error){
    print(error.response.data);
  emit(Error_Available_teacher_State(error.toString()));
  });
}

Future Update_program({
  required Map<dynamic,dynamic>map
})async{
  emit(Loading_Update_program_State());
  await DioHelper.postData(url: 'updateProgram'
      ,data: map,token: token
  ).then((value){
     print(value.data);
     emit(Success_Update_program_State());
  }).catchError((error){
     print(error.response.data);
     emit(Error_Update_program_State(error.toString()));
  });
}


  List<int> ?exam_img_Bytes;
  FilePickerResult? Exam_img;
  Future Exam_photo({
  required int section_id
})async {
    Exam_img= await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );
    if(Exam_img!=null){
      exam_img_Bytes=Exam_img!.files.single.bytes;

    }
    emit(Add_Exam_File_state());

  }

  Future Add_Exam_photo({
    required int section_id,
  })async{
    emit(Loading_Add_exam_photo());
    await DioHelper.postDataImage(url: 'updateExamPhoto',
        token: token,
        data:  FormData.fromMap({
          'section_id':section_id,
          'photo':MultipartFile.fromBytes(exam_img_Bytes!,filename:Exam_img!.files.single.name)
        })
    ).then((value) {
      print(value.data);
      emit(Success_Add_exam_photo());
    }).catchError((error){
      print(error);
      emit(Error_Add_exam_photo(error.toString()));
    });
  }


/*
  List<List<dynamic>>daily_available_list=[];
Future get_index_available_list({
  required int saf_id,
})async{
  for(int j=0;j<5;j++){
    for(int i=1;i<=7;i++){
      await Get_Available_Teachers(saf_id: saf_id, day: days[j], time: i).then((value){
        daily_available_list.add(available_list);
      });
    }
    print('/////////////////////////////////////////day');
  }
  emit(Success_all_indexing_teacher_State());
print(daily_available_list);
}*/


  MarksModel? marksModel;

  void uploadFile({required Uint8List cvsFile, required String filename}) async {

    emit(UploadExcelFileLoadingState());
    print('dfgfdgdfg');
    DioHelper.postDataImage(
      url: 'marks/import',
      data: FormData.fromMap({
        'file': await MultipartFile.fromBytes(
            cvsFile,
            filename: filename
        ),
      },),
      token: token,
    ).then((value) async {

      marksModel = MarksModel.fromJson(value.data);

      emit(UploadExcelFileSuccessState(marksModel!));
    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      marksModel = MarksModel.fromJson(error.response.data);
      emit(UploadExcelFileErrorState(marksModel!));
      print(error.toString());
    });

  }











}



