import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_network/image_network.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:school_dashboard/cubit/articles/articles_cubit.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/widgets/videoController.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

Future<Object?> awsDialogUploading(
    context, width, ArticlesCubit cubit, typeCall) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      borderSide: const BorderSide(
        color: Colors.yellow,
        width: 2,
      ),
      width: width * 0.3,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: true,
      animType: AnimType.topSlide,
      title: 'Warning',
      desc: 'Do you want to publish?',
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        cubit.sendArticle(
            title: cubit.titleController.text, body: cubit.bodyController.text);
      }).show();
}

Future<Object?> awsDialogDeleteArticle(
    context, width, ArticlesCubit cubit, typeCall, int articleId) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      borderSide: const BorderSide(
        color: Colors.yellow,
        width: 2,
      ),
      width: width * 0.3,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: true,
      animType: AnimType.topSlide,
      title: 'Warning',
      desc: 'Do you want to Delete the article?',
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        cubit.deleteArticlesData(id: articleId);
      }).show();
}

Widget buildArticleCard(
    context,
    width,
    height,
    ArticlesCubit cubit,
    bool isAdmin,
    int articleId,
    String imgProfile,
    String name,
    String date,
    String title,
    String body,
    String mediaSrc,
    int mediaType,) {
  String dataArticle = timeago.format((DateTime.parse(date)));

  String schoolName = 'Admin';

  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 5,
          )
        ],
      ),
      width: width * 0.37,

      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.blue, width: 3),
                    color: Colors.white),
                clipBehavior: Clip.hardEdge,
                width: 80,
                height: 80,
                child: isAdmin
                    ? Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fill,
                      )
                    : ImageNetwork(image: imgProfile, height: 80, width: 80,fitWeb: BoxFitWeb.fill,borderRadius: BorderRadius.circular(100),)
              ),
              SizedBox(
                width: width * 0.012,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      isAdmin
                          ? Text(
                              schoolName,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.black,
                              ),
                            )
                          : Text(
                              name,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                                color: Colors.black,
                              ),
                            ),
                      SizedBox(
                        width: width * 0.005,
                      ),
                      isAdmin
                          ? Image.asset(
                              'assets/images/img1.png',
                              width: 15,
                              height: 15,
                            )
                          : Container(),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      //child: Text('$formattedTime, $formattedDate'),
                      Text(
                        dataArticle,
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp),
                    maxLines: 1,
                  )
                ],
              ),
              SizedBox(
                width: width * 0.1,
              ),
              IconButton(
                onPressed: () {
                  awsDialogDeleteArticle(context, width, cubit, 0, articleId);
                },
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.blue,
                  size: 32.sp,
                ),
              )
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          mediaType == 0
              ? Container()
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        color: Colors.blue.withOpacity(0.1),
                        blurRadius: 5,
                      )
                    ],
                    color: Colors.white,
                  ),
                  child: mediaType == 2
                      ? image_article_container(container_width: width*0.4, container_height: height*0.3, imageUrl: mediaSrc)
                  /*CachedNetworkImage(
                          imageUrl: mediaSrc,
                          placeholder: (context, url) => SpinKitWeb(width),
                          height: height * 0.4,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        )*/
                      : ChewieListItem(
                          controlsPlace: 20,
                          videoPlayerController:
                              VideoPlayerController.network(mediaSrc),
                        ),
                ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.01, vertical: height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isAdmin
                    ? Text(
                        schoolName,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Colors.black,
                        ),
                      )
                    : Text(
                        name,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                          color: Colors.black,
                        ),
                      ),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                  child: Text(
                    body,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 15.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget articlePagination(context, width, height, ArticlesCubit cubit) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    SizedBox(
      width: width < 1100 ? width * 0.7 : width * 0.33,
      height: width < 1100 ? height * 0.06 : height * 0.08,
      child: NumberPaginator(
        initialPage: cubit.currentIndex,
        numberPages: cubit.paginationNumberSave!,
        onPageChange: (int index) async {
          print(index);
          cubit.getArticlesData(paginationNumber: index);
        },
      ),
    ),
    SizedBox(
      width: width < 1100 ? width * 0.01 : width * 0.04,
    ),
  ]);
}
