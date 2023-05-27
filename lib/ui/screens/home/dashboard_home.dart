import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/cubit/home/home_cubit.dart';
import 'package:school_dashboard/cubit/home/home_states.dart';
import '../../../theme/colors.dart';
import '../../widgets/dashboard_widgets.dart';
//lightBlueAccent
class Dashboard_home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<Home_Cubit,Home_State>(
      listener: (context,state){},
      builder: (context,state){
        return Container(
            height: height,width: width,color: basic_background,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width/25,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Welcome_Stack(height: height,width: width),
                      Row(children: [
                        number_container(height: height, width: width, icon: Icons.school, color: Colors.lightBlueAccent,
                            catagory: 'Student',number: 200),
                        SizedBox(width: width/30,),
                        number_container(height: height, width: width, icon: Icons.people_outline_rounded, color: Colors.lightBlue,
                            catagory: 'Teacher',number: 100
                        ),
                        SizedBox(width: width/40,),
                        number_container(height: height, width: width, icon: Icons.account_circle_rounded, color: Colors.blue,
                            catagory: 'Admins',number: 50)
                      ],),
                      SizedBox(height: height/70,),
                      Expanded(flex: 1,
                        child: Row(children: [
                          financial_chart_container(height,width,incoming: 2000, outcoming: 1000),
                          SizedBox(width: width/35,),
                          female_male_chart(height:height,width:width,female: 60,male: 40),
                        ],),
                      )
                    ],),
                ),
                Padding(
                    padding: EdgeInsets.only(top: height/12,left: width/30),
                    child: animation_column(
                      height: height,width: width,
                      children: [
                        Celander(height:height, width: width),
                        SizedBox(height: height/30,),
                        Newest_articals(context,height,width),
                      ],
                    )),
              ],));
      },
    );
  }
}




