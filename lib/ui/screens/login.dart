
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/auth/auth_cubit.dart';
import 'package:school_dashboard/network/local/cash_helper.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/widgets/login_widgets.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var emailFocusNode = FocusNode();

  var passwordFocusNode = FocusNode();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = 753.599975586;
    // final height = MediaQuery.of(context).size.height;
    //final height = heightSize / 1.2500000000000000331740987392709;
    final width = MediaQuery.of(context).size.width;
    var cubit = AuthCubit.get(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          print(state.loginModel.status!);
          print(state.loginModel.data!.token);

          CacheHelper.saveData(
            key: 'user_id',
            value: state.loginModel.data!.user!.user_id,
          ).then(
            (value) {
              user_id = state.loginModel.data!.user!.user_id;
            },
          );

          CacheHelper.saveData(
            key: 'token',
            value: state.loginModel.data!.token,
          ).then(
            (value) {
              token = state.loginModel.data!.token;
              Navigator.of(context).pushReplacementNamed('/home');
            },
          );
          showToast(
            text: state.loginModel.message!,
            state: ToastState.success,
          );
        }
        if (state is LoginErrorState) {
          showToast(
            text: state.loginModel.message!,
            state: ToastState.error,
          );
        }
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: null,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Wave(width),
                  Logo(width, height),
                ],
              ),
              WhiteContainer(
                  context,
                  width,
                  height,
                  cubit,
                  emailController,
                  passwordController,
                  emailFocusNode,
                  passwordFocusNode,
                  formKey)
            ],
          ),
        ),
      ),
    );
  }
}
