import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/articles/articles_cubit.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';
import 'package:school_dashboard/ui/widgets/articles_widgets/articles_widgets.dart';

class add_articals extends StatelessWidget {
  add_articals({Key? key}) : super(key: key);

  var titleFocusNode = FocusNode();

  var bodyFocusNode = FocusNode();

  var emojiFocusNode = FocusNode();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<ArticlesCubit, ArticlesState>(
      listener: (context, state) {
        var cubit = ArticlesCubit.get(context);

        if (state is SendArticleLoading) {}

        if (state is SendArticleSuccess) {
          cubit.clearControllers();
          cubit.stringProgress = '0.0%';
          cubit.doubleProgress = 0.0;
          showToast(text: 'Published Successfully', state: ToastState.success);
        }

        if (state is SendArticleError) {
          cubit.stringProgress = '0.0%';
          cubit.doubleProgress = 0.0;
          showToast(text: state.errorModel.message!, state: ToastState.error);
        }
      },
      builder: (context, state) {
        var cubit = ArticlesCubit.get(context);
        return SingleChildScrollView(
          controller: Basic_Cubit.get(context).scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left: width/50),
                      child: Animated_Text(width: width, text: 'Add an article'),
                    ),
                    SizedBox(
                      width: width * 0.4,
                    ),
                    Container(
                      width: width < 600 ? width * 0.16 : width * 0.12,
                      height: height * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          cubit.clearControllers();
                        },
                        child: Text(
                          'Remove',
                          style:
                              TextStyle(fontSize: 20.sp, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    ConditionalBuilder(
                      condition: cubit.doubleProgress == 0.0,
                      builder: (context) => Container(
                        width: width < 600 ? width * 0.14 : width * 0.12,
                        height: height * 0.04,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: basicColor,
                            textStyle: const TextStyle(),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              awsDialogUploading(context, width, cubit, 0);
                            }
                          },
                          child: Text(
                            'Publish',
                            style:
                                TextStyle(fontSize: 20.sp, color: Colors.white),
                          ),
                        ),
                      ),
                      fallback: (context) => CircularPercentIndicator(
                        animation: false,
                        animationDuration: 1000,
                        radius: 80.r,
                        lineWidth: 7,
                        percent: cubit.doubleProgress,
                        progressColor: Colors.blue,
                        backgroundColor: Colors.blue.shade200,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Text(
                          cubit.stringProgress,
                          style: TextStyle(fontSize: 18.sp, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Form(
                  key: formKey,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 32.sp),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SizedBox(
                              width: width * 0.22,
                              child: def_TextFromField(
                                onTap: () {
                                  if (cubit.emoji_open) {
                                    ArticlesCubit.get(context).close_emoji();
                                    FocusScope.of(context)
                                        .requestFocus(emojiFocusNode);
                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.show');
                                  }
                                },
                                fillColor: Colors.white,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(bodyFocusNode);
                                },
                                keyboardType: TextInputType.text,
                                controller: cubit.titleController,
                                focusNode: titleFocusNode,
                                br: 12.0,
                                maxLines: 1,
                                label: 'Example: A journey event',
                                borderNormalColor: Colors.black,
                                borderFocusedColor: Colors.blue,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the title of the article';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            cubit.mediaStatus == null
                                ? Container(
                                    width: width * 0.35,
                                    height: height * 0.45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        hoverColor: Color(0xFFE2E2E2),
                                        focusColor: Colors.grey,
                                        borderRadius: BorderRadius.circular(15),
                                        splashColor: Colors.grey,
                                        onTap: () {
                                          //cubit.pickMediaFile();
                                          cubit.picky();
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.image_outlined,
                                              size: 82.sp,
                                              color: Colors.blue.shade800,
                                            ),
                                            SizedBox(
                                              height: height * 0.1,
                                            ),
                                            Text(
                                              '(Optional): Add an image or video that complements your article.',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w100),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : cubit.mediaStatus == 1
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.35,
                                            height: height * 0.45,
                                            child: HtmlElementView(
                                                viewType: cubit
                                                    .newLocalVideoPlayerId),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              cubit.picky();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.blue),
                                              width: width * 0.07,
                                              height: height * 0.03,
                                              child: Center(
                                                child: Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.35,
                                            height: height * 0.45,
                                            child: Image.memory(
                                              cubit.webMediaArticle!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              cubit.picky();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.blue),
                                              width: width * 0.07,
                                              height: height * 0.03,
                                              child: Center(
                                                child: Text(
                                                  'Edit',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                                child: Lottie.asset(
                                    'assets/images/article.json',
                                    fit: BoxFit.fill,
                                    height: height / 5,
                                    width: width / 6)),
                            Text(
                              'Description',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 32.sp),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            SizedBox(
                              width: width * 0.34,
                              child: def_TextFromField(
                                onTap: () {
                                  if (cubit.emoji_open) {
                                    ArticlesCubit.get(context).close_emoji();
                                    FocusScope.of(context)
                                        .requestFocus(bodyFocusNode);
                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.show');
                                  }
                                },
                                onChanged: (value) {
                                  cubit.counterTextformField(value.length);
                                },
                                counterText: '${cubit.counterText}/3000',
                                fillColor: Colors.white,
                                maxLength: 3000,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                keyboardType: (cubit.emoji_open)
                                    ? TextInputType.none
                                    : TextInputType.text,
                                controller: cubit.bodyController,
                                focusNode: bodyFocusNode,
                                br: 12.0,
                                minLines: 13,
                                maxLines: 13,
                                label: '',
                                borderNormalColor: Colors.black,
                                borderFocusedColor: Colors.blue,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the description of the article';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            /*IconButton(
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(emojiFocusNode);
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide');
                                ArticlesCubit.get(context).open();
                              },
                              icon: const Icon(
                                Icons.emoji_emotions,
                                color: Colors.blue,
                              ),
                            ),*/
                            /*(cubit.emoji_open)
                                ? Container(
                                    height: height / 4,
                                    width: width*0.34,
                                    child: def_Emoji_picker(
                                        cubit.bodyController,
                                        Colors.blue,
                                        Colors.blueAccent,
                                        cubit
                                    ),
                                  )
                                : Container()*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
