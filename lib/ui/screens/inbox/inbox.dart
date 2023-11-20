import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/inbox/inbox_cubit.dart';
import 'package:school_dashboard/cubit/inbox/inbox_states.dart';
import 'package:school_dashboard/theme/colors.dart';
import '../../../theme/styles.dart';
import '../../components/components.dart';
import '../../widgets/inbox_widgets.dart';


class Inbox extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>inbox_cubit()..Get_inbox(),
      child: BlocConsumer<inbox_cubit,inbox_states>(
        listener: (context,state){},
        builder: (context,state){
          inbox_cubit cubit=inbox_cubit.get(context);
          List <dynamic>complaints=cubit.complaints;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Container(
                width: width,color: basic_background,
                child: Padding(
                  padding:  EdgeInsets.only(left: width/15,right: width/15,bottom: height/20),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Inbox_Presentation(width:width,height:height),
                          SizedBox(height: height/20,),
                          Container(
                            width: width/1.2,height: height/1.5,
                            decoration: CircularBorder_decoration,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Init_Inbox(width: width),
                                ConditionalBuilder(
                                  condition: complaints.length>0,
                                  builder: (context)=>Expanded(
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        itemBuilder: (context,index)=>inbox_cell(
                                            item:complaints[index],
                                            width: width
                                        ),
                                        separatorBuilder:  (context,index)=>SizedBox(),
                                        itemCount: complaints.length),
                                  ),
                                  fallback: (context)=>Center(
                                    child:Lottie.asset('assets/images/teacher_profile.json', fit: BoxFit.fill,
                                      height: height/3
                                    ),
                                  ),

                                ),
                              ],),),
                        ],),
                      Padding(
                        padding: EdgeInsets.only(),
                        child: Image.asset('assets/images/inbox3.png',height: height/2.5,fit: BoxFit.fitHeight,),),
                      Padding(
                        padding: EdgeInsets.only(left: width/2,top: height/30),
                        child: Image.asset('assets/images/shadow.png',height: height/2.55,fit: BoxFit.fitHeight,),),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}