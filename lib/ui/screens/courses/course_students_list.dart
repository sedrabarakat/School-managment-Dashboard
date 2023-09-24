import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/courses/course_state.dart';

import '../../../constants.dart';
import '../../../cubit/courses/course_cubit.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../components/components.dart';
import '../../widgets/courses/student_courses_widgets.dart';


class course_student_list extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.sizeOf(context).width;
    return BlocConsumer<Courses_cubit,Courses_State>(
        listener: (context,state){},
        builder: (context,state){
          Courses_cubit cubit=Courses_cubit.get(context);
          List<dynamic>?student_List=cubit.student_in_course['data'];
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: width,color: basic_background,
                  child: Padding(
                    padding:  EdgeInsets.only(left: width/15,right: width/15,bottom: height/20,top: height/20),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Animated_Text(width: width, text: 'Students enrolled in that Course'),
                         SizedBox(height: height/20,),
                         backToRout(from: 'Courses', width: width,
                           from_rout: '/courses', context: context, To: 'Course Students'),
                        //assets/images/book_small.png
                        SizedBox(height: height/20,),
                        Container(
                          width: width/1.2,height: height/1.5,
                          decoration: CircularBorder_decoration,
                          child: Column(
                            children: [
                              Init_student_course_cell(width: width),
                              SizedBox(height: height/20,),
                              Expanded(
                                child: ListView.separated(
                                     shrinkWrap: true,
                                    itemBuilder:  (context,index)=>student_course_cell(
                                        width: width, name: student_List[index]['name'],status: student_List[index]['status'],
                                      stuid: student_List[index]['student_id'] ,cubit: cubit
                                    ),
                                    separatorBuilder: (context,index)=>SizedBox(height: height/22,),
                                    itemCount:student_List!.length),
                              )
                            ],),),
                      ],
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width/2),
                  child: Image.asset('assets/images/book_small.png',height: height/4.5,fit: BoxFit.fitHeight,),),
                Padding(
                  padding: EdgeInsets.only(left: width/1.6),
                  child: Image.asset('assets/images/courses1.png',height: height/4.4,fit: BoxFit.fitHeight,),),
                //assets/images/book2.png
              ],
            ),
          );
        },
        );
  }
}

/*Stack(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(top: height/2),
                      child: Container(
                        width: width/1.2,height: height/1.1,
                        decoration: CircularBorder_decoration,
                        child: Column(
                          children: [
                            Init_student_course_cell(width: width),

                          ],),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width/1.45,top: height/10),
                      child: circle_icon_button(button_Function: (){}, icon: Icons.refresh, hint_message: 'refresh'),
                    ),
                    /*
                    Padding(
                      padding: EdgeInsets.only(),
                      child: Image.asset('assets/images/teacher_courses.gif',height: height/2.5,fit: BoxFit.fitHeight,),),
*/
                  ],
                ),*/