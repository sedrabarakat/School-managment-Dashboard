import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';

import 'library_states.dart';

class Library_cubit extends Cubit<Library_states>{

  Library_cubit():super(Library_init_state());

  static Library_cubit get(context)=>BlocProvider.of(context);

  List<int> ?Cover_Bytes;
  FilePickerResult? cover;
  Future add_cover()async {
     cover= await FilePicker.platform.pickFiles(
       allowMultiple: false,
    );
    if(cover!=null){
      Cover_Bytes=cover!.files.single.bytes;
    }
    emit(Add_Cover_state());
  }


//booksDelete
  //booksList
  String ?Error_book;
  Future Add_Book({
  required String name,
    var img
}) async {
    emit(Loading_Add_Book());
     return await DioHelper.postDataImage(url: 'addBook',
      token: token,
      data: FormData.fromMap({
        'name':name,
        if(cover!=null)'img':MultipartFile.fromBytes(Cover_Bytes!,filename:cover!.files.single.name)

      })
    ).then((value) {
      print(value);
      emit(Success_Add_Book());
    }).catchError((error){
       Error_book=error.response.data['message'];
      //print(Error_book);
       emit(Error_Add_Book(error.toString()));
    });
  }

List<dynamic>Books_list=[];
Future Get_Books()async{
    emit(Loading_Book_List());
    return await DioHelper.getData(
        url: 'booksList',
      token: token,).then((value){
      Books_list=value.data;
      print(value);
      emit(Success_Book_List());
    }).catchError((error){
      //print(error);
      emit(Error_Book_List(error));
    });
}

Future Delete_book({
  required List<dynamic>ids
})async{
    emit(Loading_Delete_Book());
    return await DioHelper.postData(
        url: 'booksDelete',
        token: token,
      data: {
          'ids':ids
      }
    ).then((value){
      emit(Success_Delete_Book());
    }).catchError((error){
      emit(Error_Delete_Book(error.toString()));
    });
}

  Future Confirm_Booked({
    required int library_student_id
  })async{
    emit(Loading_Confirm());
    return await DioHelper.postData(url: 'confirm/${library_student_id}',
      token: token,).then((value){
      emit(Success_Confirm());
    }).catchError((error){
      emit(Error_Confirm(error.toString()));
    });
  }

  Future Disconfirm_Booked({
    required int library_student_id
  })async{
    emit(Loading_DisConfirm());
    return await DioHelper.postData(url: 'disconfirm/${library_student_id}',
      token: token,).then((value){
      emit(Success_DisConfirm());
    }).catchError((error){
      emit(Error_DisConfirm(error.toString()));
    });
  }







}