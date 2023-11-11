import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/register/register_cubit.dart';
import 'package:school_dashboard/cubit/register/register_state.dart';
import 'package:school_dashboard/main.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/widgets/register_widgets.dart';

class Add_Parent extends StatelessWidget {
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  var nameFocusNode = FocusNode();
  var genderFocusNode = FocusNode();
  var phoneFocusNode = FocusNode();
  bool? isErrorGender = false;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = heightf / 2.1;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        var cubit = RegisterCubit.get(context);
        if (state is SuccessRegisterParent) {
          cubit.clearControllers();
          showToast(text: 'Parent Created Successfully', state: ToastState.success);
        }
        if (state is ErrorRegisterParent) {
          showToast(text: state.errorModel!.message!, state: ToastState.error);
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        return cubit.isLoading == false ? SingleChildScrollView(
          controller: Basic_Cubit.get(context).scrollController,
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
                      width: width, text: 'Add New Parents', speed: 300),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      def_Container_RegitsterText(
                        focusnode: nameFocusNode,
                        onfieldsubmitted: (value) {
                          FocusScope.of(context).requestFocus(phoneFocusNode);
                        },
                        height: height,
                        width: width,
                        hinttext: "Enter name",
                        title: "Full Name",
                        MyController: cubit.nameParentController,
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
                          FocusScope.of(context).requestFocus(genderFocusNode);
                        },
                        height: height,
                        width: width,
                        hinttext: "Enter phone",
                        title: "Phone Number",
                        MyController: cubit.phoneParentController,
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
                      // SizedBox(
                      //   width: width * 0.05,
                      // ),
                      FormField(
                        validator: (value) {
                          value == null
                              ? isErrorGender = true
                              : isErrorGender = false;
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
                            selectedValue: cubit.valueGender,
                            iserror: isErrorGender,
                            focusnode: genderFocusNode,
                            onChanged: (value) {
                              FocusScope.of(context)
                                  .requestFocus(emailFocusNode);
                              cubit.valueGender = value;
                              value == null
                                  ? isErrorGender = true
                                  : isErrorGender = false;
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      def_Container_RegitsterText(
                        focusnode: emailFocusNode,
                        onfieldsubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        },
                        height: height,
                        width: width,
                        hinttext: "Email Address",
                        title: "Email",
                        MyController: cubit.emailParentController,
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
                        height: height,
                        width: width,
                        hinttext: "Password",
                        title: "Password",
                        MyController: cubit.passwordParentController,
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
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.03,
                        top: height * 0.1,
                        right: width * 0.05),
                    child: Row(
                      children: [
                        buttonRegister(cubit, height, width, () {
                          if (formkey.currentState!.validate() && cubit.valueGender != null) {
                            print('yess');
                            RegisterCubit.get(context).registerParents(
                                cubit.phoneParentController.text,
                                cubit.nameParentController.text,
                                cubit.emailParentController.text,
                                cubit.passwordParentController.text,
                                cubit.valueGender);
                          }
                        }, cubit.onEnterCreate, cubit.onExitCreate, 'Create',
                            cubit.buttonColor, cubit.textButtonWeightCreate),
                        SizedBox(
                          width: width * 0.025,
                        ),
                        buttonRegister(cubit, height, width, () {
                          cubit.clearControllers();
                        }, cubit.onEnterReset, cubit.onExitReset, 'Reset',
                            cubit.buttonReset, cubit.textButtonWeightReset),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ) ,
        ): Center(child:SpinKitWeb(width),);
      },
    );
  }
}
// color: Color.fromARGB(255, 120, 139, 149)
