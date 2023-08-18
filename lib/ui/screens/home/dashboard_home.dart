
import 'dart:js_interop';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:school_dashboard/cubit/home/home_cubit.dart';
import 'package:school_dashboard/cubit/home/home_states.dart';
import '../../../constants.dart';
import '../../../models/home.dart';
import '../../../theme/colors.dart';
import '../../widgets/dashboard_widgets.dart';

//lightBlueAccent

class Dashboard_home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<Home_Cubit, Home_State>(
      listener: (context, state) {},
      builder: (context, state) {
        Home_Cubit cubit=Home_Cubit.get(context);
        Map<dynamic,dynamic>?Home=cubit.Home;
    int studentNum=0,Teachernum=0,Adminnum=0;
    if(Home?.isEmpty==false) {
      studentNum = Home!['data']['Students_num'];
      Teachernum = Home['data']['Teachers_Num'];
      Adminnum = Home['data']['Admins_Num'];
    }
        return SingleChildScrollView(
          child: ConditionalBuilder(
            condition: Home.isNull==false,
            builder: (context)=>Container(
                height: height, width: width,
                color: basic_background,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width / 25,),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Welcome_Stack(height: height, width: width),
                          Row(
                            children: [
                              number_container(height: height, width: width, icon: Icons.school, color: Colors.lightBlueAccent, catagory: 'Student', number: studentNum),
                              SizedBox(width: width / 30,),
                              number_container(height: height, width: width, icon: Icons.people_outline_rounded, color: Colors.lightBlue, catagory: 'Teacher', number: Teachernum),
                              SizedBox(width: width / 40,),
                              number_container(height: height, width: width, icon: Icons.account_circle_rounded, color: Colors.blue, catagory: 'Admins', number: Adminnum)
                            ],
                          ),
                          SizedBox(height: height / 100,),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                financial_chart_container(height, width, incoming:(Home?['data']['Income']!=null)?double.parse('${Home?['data']['Income']}'):2000,
                                    outcoming: 222),
                                SizedBox(width: width / 35,),
                                female_male_chart(height: height, width: width,
                                    female: (Home?['data']['Female_perecentage']!=null)?Home!['data']['Female_perecentage']:50,
                                    male: (Home?['data']['Male_perecentage']!=null)?Home!['data']['Male_perecentage']:50),
                              ],),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: height / 12, left: width / 30),
                        child: animation_column(
                          height: height, width: width,
                          children: [
                            Celander(height: height, width: width),
                            SizedBox(height: height / 30,),
                            Newest_articals(context, height, width,list:cubit.articals ),
                          ],
                        )),
                  ],
                )),
            fallback: (context)=>Padding(
              padding: EdgeInsets.only(top: height/10),
                child: Lottie.asset('assets/images/data.json',height: height/1.5,
                  fit: BoxFit.fill,
                )),
          )
        );
      },
    );
  }
}


/*
* Center(
                child: Lottie.asset('assets/images/data.json' ,height: height/1.2,
                  fit: BoxFit.fill,
                ))*/


/* int studentNum=0,Teachernum=0,Adminnum=0;
    double incoming=0.0,outcoming=0.0,female=0.0,male=0.0;
    if(Home?.isEmpty==false){
    studentNum=Home!['data']['Students_num'];
    Teachernum=Home['data']['Teachers_Num'];
    Adminnum=Home['data']['Admins_Num'];
    incoming=Home['data']['Income']+0.0;
    outcoming=double.parse('${Home['data']['Outcome']}');
    female=Home['data']['Female_perecentage'];
    male=Home['data']['Male_perecentage'];
    }*/


