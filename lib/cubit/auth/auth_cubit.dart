import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_dashboard/models/login_model.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';
import 'package:school_dashboard/network/remote/end_points.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_off;

  void changePasswordVisibility()
  { 
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility_off : Icons.visibility;
    
    emit(ChangePasswordVisibility());
  }


  var ratioButtonWidth = 0.14;

  bool isAnimated = false;

  void animateTheButton(){
    ratioButtonWidth=0.07;
    emit(AnimateTheButton());
  }


  bool isHovered =false;

  var transform;
  
  void onEntered(bool isHov){
    isHovered=isHov;
    final ht = Matrix4.identity()..scale(1.1);
    transform = isHovered? ht : Matrix4.identity();
    emit(OnHoverButton());
  }


  LoginModel? loginModel;

  void login({
    required String email,
    required String password,
  }) {
    isAnimated = true;
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      //loginModel = LoginModel.fromJson(value.data);

      //print(loginModel!.status);
      //print(loginModel!.message);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      //loginModel = LoginModel.fromJson(error.response.data);
      emit(LoginErrorState(loginModel!));
      print(error.toString());
    });
  }



}
