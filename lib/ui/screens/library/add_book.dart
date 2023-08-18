import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/library/library_cubit.dart';
import 'package:school_dashboard/cubit/library/library_states.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/widgets/class_widgets.dart';
import '../../../theme/styles.dart';
import '../../widgets/library_widgets.dart';

class Add_Book extends StatelessWidget{
  var Book=TextEditingController();
  var Scroll_controller=ScrollController();
  var Add_Key=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.sizeOf(context).width;
    return BlocConsumer<Library_cubit,Library_states>(
      listener: (context,state){
        if (state is Success_Add_Book) showToast(text: 'Success Add Book', state:ToastState.success );
        if (state is Error_Add_Book) showToast(text: Library_cubit.get(context).Error_book.toString(), state: ToastState.error);

        if (state is Success_Delete_Book) showToast(text: 'Success Delete Book', state: ToastState.success);
        if (state is Error_Delete_Book) showToast(text: 'Error in Delete...Try Again later', state: ToastState.error);
      },
      builder: (context,state){
        Library_cubit cubit=Library_cubit.get(context);
        List<int> ?ImagePath=Library_cubit.get(context).Cover_Bytes;
        return SingleChildScrollView(
          child: Container(
            width: width,height: height,color: basic_background,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              controller: Scroll_controller,
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/15,vertical: height/7),
                  child: Container(
                    decoration: CircularBorder_decoration.copyWith(borderRadius: BorderRadius.circular(5),
                    boxShadow: [light_gry_shadow]),
                    child: Row(
                      children: [
                        Book_with_CoverButton(width: width, ImagePath: ImagePath, cubit: cubit),
                        Padding(
                          padding: EdgeInsets.only(left: width/15,top: height/10 ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Animated_Text(width: width, text: 'Add Book 📚',
                                  colors_list: [Colors.blue,Colors.lightBlueAccent,Colors.white]),
                              SizedBox(height: height/30,),
                              Text('you can add any Book to the Library of School',style: email_TextStyle(width: width),),
                              Text('By write its Name then pick the book cover',style: email_TextStyle(width: width),),
                              SizedBox(height: height/15,),
                              SizedBox(
                                width: width/3.8,
                                child: Form(
                                  key: Add_Key,
                                  child: default_TextFromField(
                                    maxLines: 3,
                                    prefixicon: Icons.my_library_books_outlined,
                                      width: width,
                                      controller: Book,
                                      Error_Text: 'Please Write Book Name Here',
                                      keyboardtype: TextInputType.text,
                                      hintText: 'Write Book Name 📖'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: width/5,top: height/10),
                                child: elevatedbutton(
                                    Function: (){
                                      if(Add_Key.currentState!.validate()){
                                      cubit.Add_Book(name: Book.text);
                                      cubit.Get_Books();
                                      cubit.Cover_Bytes=null;
                                      Book.clear();
                                      }
                                    },
                                    widthSize: width/18,
                                    heightSize: height/23,
                                    text: "Add Book",
                                    borderRadius: 15,
                                    backgroundColor: Colors.blue),
                              )
                            ],),
                        ),
                        SizedBox(width: width/15,)
                      ],),
                  ),),
                Go_Forward_Back(Scroll_controller: Scroll_controller),
                Padding(
                  padding: EdgeInsets.only(top: height/9, bottom: height/8.7, left:width/22, right:width/15,),
                  child: Container(
                    width: width/1.4,
                    decoration: BigCircularBorder_decoration,
                    child: ConditionalBuilder(
                      condition: cubit.Books_list.isNotEmpty && state is Success_Book_List ,
                      builder: (context)=>Stack(
                        children: [
                          multiselect(width: width, books:cubit.Books_list),
                          Positioned(
                            left: width/1.6,top: height/1.45,
                            child: elevatedbutton(Function: (){
                              cubit.Delete_book(ids: Selected_id);
                              cubit.Get_Books();
                             // Basic_Cubit.get(context).change_Route('/books_list');
                            },backgroundColor: Colors.blue,
                                widthSize: width/16,
                                heightSize: height/20,
                                text: "Delete"),
                          )
                        ],),
                      fallback: (context)=>Center(child: Lottie.asset('assets/images/empty.json')),),
                  ),),
              ],),),
          ),);
      },
    );
  }
}


