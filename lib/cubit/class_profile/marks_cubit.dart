import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'dart:html';
import 'dart:io';
//import 'dart:html';
//import 'dart:html' as html;
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/models/class_profile_model.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';

part 'marks_state.dart';

class MarksCubit extends Cubit<MarksState> {
  MarksCubit() : super(MarksInitial());

  static MarksCubit get(context) => BlocProvider.of(context);

  String? selected_section;

  void select_section(value){
    selected_section=value;
    emit(change_selected_section());
  }

  String? selected_subject;

  void select_subject(value){
    selected_subject=value;
    emit(change_selected_subject());
  }

  String? selected_exam_type;

  void select_exam_type(value){
    selected_exam_type=value;
    emit(change_selected_exam_type());
  }


  void downloadCvs({required int grade, required String subjectName, required String sectionNumber}) async {

    try {
      emit(DownloadExcelFileLoadingState());

      String url = '${baseUrl}marks/export?saf_Id=${grade}&subject_name=${subjectName}&section_number=${sectionNumber}';
      AnchorElement anchorElement = AnchorElement(href: url);
      anchorElement.download = 'marks';
      anchorElement.click();
      anchorElement.remove();

      emit(DownloadExcelFileSuccessState());

    }
    catch (e) {
      emit(DownloadExcelFileErrorState());
      print(e.toString());
    }


  }

  PlatformFile? cvsFile;

  Future pickCvsFile() async {
    try {

      FileUploadInputElement uploadInput = FileUploadInputElement();
      uploadInput.click();

      uploadInput.onChange.listen((e) {
        // read file content as dataURL
        final files = uploadInput.files;
        if (files!.length == 1) {
          final file = files[0];
          FileReader reader =  FileReader();

          reader.onLoadEnd.listen((e)  async{
            final result = reader.result;
            final fileData = result as Uint8List;

            cvsFile = PlatformFile(
              name: file.name,
              bytes: fileData ,
              size: file.size,
            );
            emit(PickCvsFile());
          });

          reader.onError.listen((fileEvent) {
            print("Some Error occured while reading the file");
          });

          reader.readAsArrayBuffer(file);
        }
      });

    } on PlatformException {
      print('Failed to pick File');
    }

  }





}
