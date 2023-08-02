import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_dashboard/cubit/articles/articles_cubit.dart';
import 'package:school_dashboard/theme/colors.dart';


Size size = PlatformDispatcher.instance.views.first.physicalSize;


class All_Articals extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var cubit = ArticlesCubit.get(context);
    return BlocConsumer<ArticlesCubit, ArticlesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          child: Column(
            children: [

              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    cubit.pickImage(
                        ImageSource.gallery, context, width);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor,
                    ),
                    padding: const EdgeInsets.all(8),
                    height: height * 0.22,
                    width: width * 0.22,
                    child: cubit.webImage != null
                        ? Image.memory(
                      cubit.webImage!,
                      fit: BoxFit.fill,
                    )
                        : Center(
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.image_outlined,
                              color: Colors.black,
                              size: 50,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              'Choose an Image',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ),

              ElevatedButton(onPressed: () {

                cubit.register();

              }, child: Text('sdfsdf')),

            ],
          ),
        );
      },
    );
  }
}
