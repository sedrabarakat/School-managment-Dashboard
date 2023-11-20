import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/routes/web_router.dart';

import '../../../constants.dart';
import '../../../cubit/basic/basic_cubit.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../components/components.dart';

var scroll = ScrollController();

class Basic_Screen extends StatelessWidget {
  Basic_Screen({super.key});

  void scrollUp() {
    final double start = 0;
    scroll.animateTo(start,
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<Basic_Cubit, Basic_State>(
      listener: (context, Basic_State) {
        if (Basic_State is LogoutSuccessState) {
          showToast(text: Basic_State.logoutModel.message!, state: ToastState.success);
          signOut(context);
        }

        if (Basic_State is LogoutErrorState) {
          showToast(text: Basic_State.errorModel.message!, state: ToastState.error);
          signOut(context);
        }
      },
      builder: (context, Basic_State) {
        Basic_Cubit basic_cubit = Basic_Cubit.get(context);
        Map<String, Widget> screen = basic_cubit.screens;
        var selected_route=basic_cubit.select_route;
        return Scaffold(
          appBar: null,
          floatingActionButton: basic_cubit.backToTop ? FloatingActionButton(

            backgroundColor: Colors.lightBlue,
            onPressed: () {
              basic_cubit.scrollUp();
            },
            child: Icon(Icons.arrow_upward_rounded,size: width*0.015,),
          ) : Container(),
          body: AdminScaffold(
              backgroundColor: basic_background,
              appBar: AppBar(
                backgroundColor: Colors.lightBlue,
                actions: [
                  Text_Icon_Button(width: width, Function: () {
                    basic_cubit.logout().then((value) =>  W_Router.router.go('/login'));

                  }, text: 'Logout')
                ],
              ),
              sideBar: SideBar(
                header: Container(
                  height: height / 4,
                  width: width / 7.5,
                  color: Colors.white,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),

                ),
                width: width / 7.5,

                iconColor: Colors.lightBlue,
                backgroundColor: Colors.white,
                onSelected: (item) {
                  basic_cubit.on_select(item);
                  print(basic_cubit.select_route);
                },
                selectedRoute: '/',
                items: (admin_type==2)?Library_SideBar:Side_Bar_Menu,
              ),//screen[basic_cubit.select_route]!
              body:screen[basic_cubit.select_route]!,
            ),
        );
      },
    );
  }
}
