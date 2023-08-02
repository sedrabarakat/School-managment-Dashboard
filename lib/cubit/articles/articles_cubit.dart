import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit() : super(ArticlesInitial());

  static ArticlesCubit get(context) => BlocProvider.of(context);

  Uint8List? webImage;

  Future pickImage(ImageSource source, context, width) async {
    try {
      final XImage = await ImagePicker().pickImage(source: source);
      if (XImage == null) return;

      //For Web
      webImage = await XImage.readAsBytes();

    } on PlatformException {
      print('Failed to pick image');
    }
    emit(PickImage());

  }


    Future<void> register() async {
      emit(Loading());

      if (webImage == null) {
        print('No image selected');

        String assetImage = 'assets/default-placeholder.png';
        ByteData byteData = await rootBundle.load(assetImage);
        Uint8List bytes = byteData.buffer.asUint8List();

        webImage = bytes;

        String filename = 'image_${DateTime.now().millisecondsSinceEpoch}';
        print(filename);
        DioHelper.postDataImage(
          url: 'registerStudent',
          data: FormData.fromMap({
            'phone_number': '293924922',
            'name': 'beeso',
            'email': 'hhf@gmail.com',
            'password': '123456',
            'gender': 'Male',
            'is_in_bus': 1,
            'left_for_bus': '234555',
            'left_for_qusat': '324632',
            'parent_id': 1,
            'section_id': 1,
            'address': 'sdfksddkfsds',
            'birth_date':'2002/1/13',
            'saf_id':1,


            'img': await MultipartFile.fromBytes(
              webImage!,
              filename: filename,
              contentType: MediaType('image', 'png'),
            ),
          }),
          token: token,
        ).then((value) {
          emit(Success());
        }).catchError((error) {
          print(error.response.data);
          emit(Error());
          print(error.toString());
        });
      } else {
        String filename = 'image_${DateTime.now().millisecondsSinceEpoch}';
        print(filename);
        DioHelper.postDataImage(
          url: 'registerStudent',
          data: FormData.fromMap({
            'phone_number': '293924922',
            'name': 'beeso',
            'email': 'hsffdffh@gmail.com',
            'password': '123456',
            'gender': 'Male',
            'is_in_bus': 1,
            'left_for_bus': '234555',
            'left_for_qusat': '324632',
            'parent_id': 1,
            'section_id': 1,
            'address': 'sdfksddkfsds',
            'birth_date':'2002/1/13',
            'saf_id':1,
            'img': await MultipartFile.fromBytes(
              webImage!,
              filename: filename,
              contentType: MediaType('image', 'png'),
            ),
          }),
          token: token,
        ).then((value) {
          emit(Success());
        }).catchError((error) {
          print(error.response.data);
          emit(Error());
          print(error.toString());
        });
      }
    }




}
