import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart'
    if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/models/articles_models.dart';
import 'package:school_dashboard/models/error_model.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';
import 'package:universal_html/html.dart' as html;

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  ArticlesCubit() : super(ArticlesInitial());

  static ArticlesCubit get(context) => BlocProvider.of(context);

  //////////////////////////////////////////////////////////////////////////////
  // Pick Image

  Uint8List? webMediaArticle;
  String? webMediaArticleName;

  String? extension;

  /// to upload a video from the system
  /// and create a url from it
  Future<String> getLocalVideoUrl() async {
    final completer = Completer<String>();
    // create input element to upload video file from the system
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'video/*,image/*,.mkv';
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        final file = files[0];

        webMediaArticleName = file.name;
        print(file.name);
        // Read the file as bytes using FileReader
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);

        reader.onLoadEnd.listen((e) async {
          if (reader.readyState == html.FileReader.DONE) {
            // Get the byte data
            webMediaArticle = reader.result as Uint8List;

            extension = file.name.split('.').last.toLowerCase();
            print(extension);

            String url = html.Url.createObjectUrl(file);
            completer.complete(url);
          }
        });
      }
    });
    return completer.future;
  }

  /// to create a video element with provided src
  html.VideoElement createVideoElement(String src) {
    return html.VideoElement()
      ..controls = true
      ..autoplay = true
      ..src = src
      ..style.border = 'none'
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'contain';
  }

  int uniqueId = 0;

  String? videoSrc;

  String newLocalVideoPlayerId = 'local-video-player';

  int? mediaStatus;

  Future<void> picky() async {
    videoSrc = await getLocalVideoUrl();
    print(videoSrc);

    uniqueId++;

    newLocalVideoPlayerId = 'local-video-player-$uniqueId';

    // ignore: undefined_prefixed_name
    final res = await ui.platformViewRegistry.registerViewFactory(
        newLocalVideoPlayerId, (int id) => createVideoElement(videoSrc!));

    if (extension == 'mkv' ||
        extension == 'mp4' ||
        extension == 'avi' ||
        extension == 'mov') {
      // Display video upload form
      mediaStatus = 1;
    } else if (extension == 'jpg' ||
        extension == 'jpeg' ||
        extension == 'png' ||
        extension == 'gif') {
      // Display image upload form
      mediaStatus = 2;
    } else {
      // File type not supported
      print('Unsupported file type');
    }
    emit(PickMediaFile());
  }

  /////////////////////////////////////////////////////////////////////////////

  int? counterText = 0;

  void counterTextformField(value) {
    counterText = value;
    emit(ChangeCounter());
  }

  var titleController = TextEditingController();

  var bodyController = TextEditingController();

  void clearControllers() {
    titleController.clear();

    bodyController.clear();

    counterText = 0;

    ///////////
    // Image & Video
    mediaStatus = null;

    webMediaArticle = null;

    videoSrc = null;

    newLocalVideoPlayerId = 'local-video-player';

    /////////////////////////////////////////////////

    // Uploading error or success

    doubleProgress = 0.0;

    emit(ClearDataState());
  }

  //Emoji

  bool emoji_open=false;

  //j
  void open(){
    emoji_open=!emoji_open;
    emit(OpenEmojiKeyboard());
  }
  Future close_emoji()async{
    emoji_open=false;
    emit(CloseEmojiKeyboard());
  }

  ////////////////////////////////////////////////////////////////////////////

  ErrorModel? errorModel;

  String stringProgress = '0.0%';

  double doubleProgress = 0.0;

  //Send Article
  Future<void> sendArticle({
    required String title,
    required String body,
  }) async {
    emit(SendArticleLoading());

    if (webMediaArticle == null) {
      DioHelper.postDataImage(
          url: 'createArticle',
          data: FormData.fromMap(
            {
              'title': title,
              'body': body,
            },
          ),
          token: token,
          onSendProgress: (int sent, int total) {
            String percentage = (sent / total * 100).toStringAsFixed(2);
            stringProgress = '$percentage%';
            doubleProgress = (sent / total);

            print(stringProgress);
            print(doubleProgress);

            emit(ChangeProgress());
          }).then((value) async {
        print('value.data: ${value.data}');

        emit(SendArticleSuccess());
      }).catchError((error) {
        print('error.response.data: ${error.response.data}');
        errorModel = ErrorModel.fromJson(error.response.data);
        emit(SendArticleError(errorModel!));
        print(error.toString());
      });
    } else {
      DioHelper.postDataImage(
          url: 'createArticle',
          data: FormData.fromMap(
            {
              'title': title,
              'body': body,
              'media': await MultipartFile.fromBytes(
                webMediaArticle!,
                filename: webMediaArticleName,
              ),
            },
          ),
          token: token,
          onSendProgress: (int sent, int total) {
            String percentage = (sent / total * 100).toStringAsFixed(2);
            stringProgress = '$percentage%';
            doubleProgress = (sent / total);

            print(stringProgress);
            print(doubleProgress);

            emit(ChangeProgress());
          }).then((value) async {
        print('value.data: ${value.data}');

        emit(SendArticleSuccess());
      }).catchError((error) {
        print('error.response.data: ${error.response.data}');
        errorModel = ErrorModel.fromJson(error.response.data);
        emit(SendArticleError(errorModel!));
        print(error.toString());
      });
    }
  }


  ////////////////////////////////////////////////////////////////////////////////

  // Get Articles

  int? paginationNumberSave;

  int currentIndex = 0;

  ArticlesModel? articlesModel;

  void getArticlesData({
    required int paginationNumber,
  }) async {

    articlesModel = null;
    currentIndex = paginationNumber;

    emit(GetArticleLoading());
    DioHelper.postData(
        url: 'getArticles',
        data: {
          'page': paginationNumber+1,
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');
      articlesModel = ArticlesModel.fromJson(value.data);
      paginationNumberSave = articlesModel!.data!.lastPageNumber!;


      emit(GetArticleSuccess());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(GetArticleError(errorModel!));
      print(error.toString());
    });
  }

  //////////////////////////////////////////////////////////////////////////
  // Delete Articles

  void deleteArticlesData({
  required int id
}) async {

    emit(DeleteArticleLoading());
    DioHelper.postData(
        url: 'deleteArticleAdmin',
        data: {
          "id" : id
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');

      emit(DeleteArticleSuccess());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(DeleteArticleError(errorModel!));
      print(error.toString());
    });
  }

}





