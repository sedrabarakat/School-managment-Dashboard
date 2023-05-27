import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants.dart';
import '../../../cubit/basic/basic_cubit.dart';
import '../../../theme/styles.dart';
import '../../components/components.dart';

class Basic_Screen extends StatelessWidget {
  const Basic_Screen({super.key});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<Basic_Cubit,Basic_State>(
      listener: (context,Basic_State){},
      builder: (context,Basic_State){
        Basic_Cubit basic_cubit=Basic_Cubit.get(context);
        Map<String, Widget> screen=basic_cubit.screens;
        return AdminScaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              actions: [
                Padding(
                  padding:  EdgeInsets.symmetric(vertical: height/140,),
                  child: Container(
                    width: width/20,height: height/15,
                    decoration: Circle_BoxDecoration,),),
                Text_Icon_Button(width: width,Function: (){},text: 'Logout')
              ],
            ),
            sideBar: SideBar(
              header: Container(height: height/4,color:Colors.white,
                child:Image.asset('assets/images/logo.png',fit: BoxFit.cover,) ,),
              width: width/7.5,
              iconColor:Colors.lightBlue,
              backgroundColor:Colors.white,
              onSelected: (item){
                basic_cubit.on_select(item);
                print(basic_cubit.select_route);
                },
              selectedRoute:'/',
              items: Side_Bar_Menu,),
            body:screen[basic_cubit.select_route]!
        );},
    );
  }
}





