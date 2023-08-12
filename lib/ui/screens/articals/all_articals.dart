import 'dart:ui';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_dashboard/cubit/articles/articles_cubit.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';
import 'package:school_dashboard/ui/widgets/articles_widgets/articles_widgets.dart';

import '../../../cubit/basic/basic_cubit.dart';

Size size = PlatformDispatcher.instance.views.first.physicalSize;

class All_Articals extends StatelessWidget {
  All_Articals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) =>
          ArticlesCubit()..getArticlesData(paginationNumber: 0),
      child: BlocConsumer<ArticlesCubit, ArticlesState>(
        listener: (context, state) {
          var cubit = ArticlesCubit.get(context);

          if (state is GetArticleSuccess) {}

          if (state is GetArticleError) {
            showToast(text: state.errorModel.message!, state: ToastState.error);
          }

          if (state is DeleteArticleSuccess) {
            showToast(text: 'Deleted Successfully', state: ToastState.success);

            if (cubit.articlesModel!.data!.articlesList!.length == 1 &&
                cubit.paginationNumberSave! > 1) {
              cubit.getArticlesData(
                  paginationNumber: cubit.paginationNumberSave! - 2);
            } else {
              cubit.getArticlesData(
                  paginationNumber: cubit.paginationNumberSave! - 1);
            }
          }

          if (state is DeleteArticleError) {
            showToast(text: state.errorModel.message!, state: ToastState.error);
          }
        },
        builder: (context, state) {
          var cubit = ArticlesCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.articlesModel != null,
            builder: (context) => SingleChildScrollView(
              controller: Basic_Cubit.get(context).scrollController,
              child: Padding(
                padding: EdgeInsets.only(
                    left: width * 0.05,
                    top: height * 0.02,
                    bottom: height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Animated_Text(width: width, text: 'Articles'),
                        Padding(
                            padding: EdgeInsets.only(right: width * 0.03),
                            child: Image.asset(
                              'assets/images/article.png',
                              scale: 7,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    SizedBox(
                      height: height * 0.65,
                      child: cubit.articlesModel!.data!.articlesList!.isEmpty
                          ? Center(
                              child: Text(
                                'No Articles found  :(',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 85.sp,fontWeight: FontWeight.bold),
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                width: width * 0.02,
                              ),
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit
                                  .articlesModel!.data!.articlesList!.length,
                              itemBuilder: (context, index) {
                                String role = cubit.articlesModel!.data!
                                    .articlesList![index].role!;
                                bool isAdmin = false;
                                if (role == 'Admin') {
                                  isAdmin = true;
                                } else {
                                  isAdmin = false;
                                }

                                int articleId = cubit.articlesModel!.data!
                                    .articlesList![index].article_id!;

                                String imgPerson = cubit.articlesModel!.data!
                                    .articlesList![index].imgPerson!;

                                String name = cubit.articlesModel!.data!
                                    .articlesList![index].name!;

                                String date = cubit.articlesModel!.data!
                                    .articlesList![index].date!;

                                String title = cubit.articlesModel!.data!
                                    .articlesList![index].title!;

                                String body = cubit.articlesModel!.data!
                                    .articlesList![index].body!;

                                String media = cubit.articlesModel!.data!
                                    .articlesList![index].media!;

                                String extension = '';

                                if (media != '') {
                                  extension = media.split('.').last;
                                  print(extension);
                                }
                                int mediaType = 0;

                                if (extension == 'mkv' ||
                                    extension == 'mp4' ||
                                    extension == 'avi' ||
                                    extension == 'mov') {
                                  // Display video upload form
                                  mediaType = 1;
                                } else if (extension == 'jpg' ||
                                    extension == 'jpeg' ||
                                    extension == 'png' ||
                                    extension == 'gif') {
                                  // Display image upload form
                                  mediaType = 2;
                                }

                                print(media);

                                return buildArticleCard(
                                    context,
                                    width,
                                    height,
                                    cubit,
                                    isAdmin,
                                    articleId,
                                    imgPerson,
                                    name,
                                    date,
                                    title,
                                    body,
                                    media,
                                    mediaType);
                              },
                            ),
                    ),
                    articlePagination(context, width, height, cubit),
                  ],
                ),
              ),
            ),
            fallback: (context) => SpinKitWeb(width),
          );
        },
      ),
    );
  }
}
