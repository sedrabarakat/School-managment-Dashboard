import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/theme/colors.dart';
import '../../../cubit/library/library_cubit.dart';
import '../../../cubit/library/library_states.dart';
import '../../../theme/styles.dart';
import '../../components/components.dart';
import '../../widgets/library_widgets.dart';

class Books_List extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (context)=>Library_cubit()..Get_Books(),
      child: BlocConsumer<Library_cubit,Library_states>(
        listener: (context,state){},
        builder: (context,state){
          Library_cubit cubit=Library_cubit.get(context);
          List<dynamic>book_list=cubit.Books_list;
          return SingleChildScrollView(
            child: Container(
              width: width,color: basic_background,
              child: Padding(
                padding:  EdgeInsets.only(left: width/15,right: width/15,bottom: height/20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Library_Presentation(width:width,height:height),
                        SizedBox(height: height/20,),
                        Container(
                          width: width/1.2,height: height/1.1,
                          decoration: CircularBorder_decoration,
                          child: Column(
                            children: [
                              Init_book_cell(width: width),
                              ConditionalBuilder(
                                condition: book_list.length>0,
                                builder: (context)=>Expanded(
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      itemBuilder: (context,index)=>book_cell(width: width,cubit: cubit,
                                        ImagePath: book_list[index]['img'],book_name: book_list[index]['name'],
                                        date: book_list[index]['available_date'],is_available:book_list[index]['is_available'],
                                        taken: book_list[index]['taken'],
                                        library_student_id: book_list[index]['library_student_id'],
                                      ),
                                      separatorBuilder:  (context,index)=>SizedBox(),
                                      itemCount: book_list.length),
                                ),
                                fallback: (context)=>Image.asset('assets/images/fly.gif'),
                              ),
                          ],),),
                      ],),
                    Padding(
                      padding: EdgeInsets.only(left: width/1.45,top: height/2.6),
                      child: circle_icon_button(button_Function: (){
                        cubit.Get_Books();
                      }, icon: Icons.refresh, hint_message: 'refresh'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Image.asset('assets/images/book.png',height: height/2.5,fit: BoxFit.fitHeight,),),
                    Padding(
                      padding: EdgeInsets.only(left: width/2),
                      child: Image.asset('assets/images/book3.png',height: height/2.55,fit: BoxFit.fitHeight,),),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}