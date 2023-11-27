import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/register/register_cubit.dart';
import 'package:school_dashboard/cubit/register/register_state.dart';
import 'package:school_dashboard/main.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/theme/styles.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/widgets/register_widgets.dart';


class Add_Admin extends StatelessWidget {

  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  var nameFocusNode = FocusNode();
  var genderFocusNode = FocusNode();
  var phoneFocusNode = FocusNode();
  var RoleFocusNode = FocusNode();

  bool? iserrorgender = false;
  bool? iserrRole = false;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = heightf / 2.1;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        var cubit = RegisterCubit.get(context);
        if (state is SuccessRegisterAdmin) {
          cubit.clearAdminControllers();
          showToast(text: 'Admin Created Successfully', state: ToastState.success);
        }
        if (state is ErrorRegisterAdmin){
          showToast(text: state.errorModel!.message!, state: ToastState.error);
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return cubit.isLoading == false ? SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: width * 0.03, vertical: height * 0.1),
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.02, vertical: height * 0.03),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  spreadRadius: 18,
                  blurRadius: 20,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Animated_Text(
                      width: width, text: 'Add New Admin ', speed: 300),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      def_Container_RegitsterText(
                        focusnode: nameFocusNode,
                        onfieldsubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(phoneFocusNode);
                        },
                        height: height,
                        width: width,
                        hinttext: "Enter name",
                        title: "Full Name",
                        MyController: cubit.nameAdminController,
                        sufix: Icon(
                          Icons.person,
                          size: width * 0.018,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Type The Name';
                          }
                          return null;
                        },
                      ),
                      def_Container_RegitsterText(
                        focusnode: phoneFocusNode,
                        onfieldsubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(genderFocusNode);
                        },
                        height: height,
                        width: width,
                        hinttext: "Enter phone",
                        title: "Phone Number",
                        MyController: cubit.phoneAdminController,
                        sufix: Icon(
                          Icons.phone,
                          size: width * 0.018,
                        ),
                        validator: (value) {
                          value = int.tryParse(value);
                          if (value == null) {
                            return 'Please Type The Phone number';
                          }
                          return null;
                        },
                      ),
                      FormField(
                        validator: (value) {
                          value == null
                              ? iserrorgender = true
                              : iserrorgender = false;
                          if (value == null) {
                            print('errror select');
                            return;
                          }
                          return null;
                        },
                        builder: (FormFieldState<dynamic> state) {
                          return def_Container_Regitsterdropdown(
                            height: height,
                            width: width,
                            hinttext: "Select gender",
                            title: "Gender",
                            item: genderitem,
                            selectedValue: cubit.valueGenderAdmin,
                            iserror: iserrorgender,
                            focusnode: genderFocusNode,
                            onChanged: (value) {
                              FocusScope.of(context)
                                  .requestFocus(emailFocusNode);

                              cubit.valueGenderAdmin = value;

                              value == null
                                  ? iserrorgender = true
                                  : iserrorgender = false;
                              RegisterCubit.get(context).updateDropdown();

                              state.didChange(value);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      def_Container_RegitsterText(
                        focusnode: emailFocusNode,
                        onfieldsubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        },
                        height: height,
                        width: width,
                        hinttext: "Email Addrass",
                        title: "Email",
                        MyController: cubit.emailAdminController,
                        sufix: Icon(
                          Icons.email,
                          size: width * 0.018,
                        ),
                        validator: (value) {
                          if (!EmailValidator.validate(value!)) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
                      ),
                      def_Container_RegitsterText(
                        focusnode: passwordFocusNode,
                        onfieldsubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(RoleFocusNode);
                        },
                        height: height,
                        width: width,
                        hinttext: "Password",
                        title: "Password",
                        MyController: cubit.passwordAdminController,
                        sufix: IconButton(
                          onPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          icon: Icon(
                            cubit.suffix,
                            size: width * 0.018,
                          ),
                        ),
                        obscureText: cubit.isPassword,
                        validator: (value) {
                          if (value.toString().length < 6) {
                            return 'invalid Password';
                          }
                          return null;
                        },
                      ),
                      FormField(
                        validator: (value) {
                          value == null
                              ? iserrRole = true
                              : iserrRole = false;
                          if (value == null) {
                            print('errror select');
                            return;
                          }
                          return null;
                        },
                        builder: (FormFieldState<dynamic> state) {
                          return def_Container_Regitsterdropdown(
                            height: height,
                            width: width,
                            hinttext: "Select Role",
                            title: "Roll",
                            item: RollAdmin,
                            selectedValue: cubit.valueRoleAdmin,
                            iserror: iserrRole,
                            focusnode: RoleFocusNode,
                            onChanged: (value) {
                              // FocusScope.of(context)
                              //     .requestFocus(emailFocusNode);

                              cubit.valueRoleAdmin = value;

                              value == null
                                  ? iserrRole = true
                                  : iserrRole = false;
                              RegisterCubit.get(context).updateDropdown();

                              state.didChange(value);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: height * 0.04,
                  // ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.03,
                        top: height * 0.1,
                        right: width * 0.05),
                    child: Row(
                      children: [
                        buttonRegister(cubit, height, width, () {
                          if (formkey.currentState!.validate()) {
                            if (cubit.valueGenderAdmin != null && cubit.valueRoleAdmin != null) {
                              RegisterCubit.get(context).registerAdmin(
                                  cubit.phoneAdminController.text,
                                  cubit.nameAdminController.text,
                                  cubit.emailAdminController.text,
                                  cubit.passwordAdminController.text,
                                  cubit.valueGenderAdmin,
                                  cubit.valueRoleAdmin);
                            }
                          }
                        },
                            cubit.onEnterCreate,
                            cubit.onExitCreate,
                            'Create',
                            cubit.buttonColor,
                            cubit.textButtonWeightCreate),
                        SizedBox(
                          width: width * 0.025,
                        ),
                        buttonRegister(cubit, height, width, () {
                          cubit.clearAdminControllers();
                        },
                            cubit.onEnterReset,
                            cubit.onExitReset,
                            'Reset',
                            cubit.buttonReset,
                            cubit.textButtonWeightReset),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ) : Center(child:SpinKitWeb(width),);
      },
    );
  }
}
