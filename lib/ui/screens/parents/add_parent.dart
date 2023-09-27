import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/cubit/register/register_cubit.dart';
import 'package:school_dashboard/cubit/register/register_state.dart';
import 'package:school_dashboard/main.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/theme/styles.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/widgets/register_widgets.dart';


class add_parent extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var GenderController = TextEditingController();
  var PhoneController = TextEditingController();

  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  var nameFocusNode = FocusNode();
  var genderFocusNode = FocusNode();
  var phoneFocusNode = FocusNode();
  String? Valuegender;
  bool? iserrorgender = false;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //const screenWidth = View.of(context).physicalSize;

    //  var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var pixelRatio = View.of(context).devicePixelRatio;

    //Size in physical pixels
    var physicalScreenSize = View.of(context).physicalSize;
    var physicalWidth = physicalScreenSize.width;
    var physicalHeight = physicalScreenSize.height;

//Size in logical pixels
    var logicalScreenSize = View.of(context).physicalSize / pixelRatio;
    var logicalWidth = logicalScreenSize.width;
    var logicalHeight = logicalScreenSize.height;

//Padding in physical pixels
    var padding = View.of(context).padding;

//Safe area paddings in logical pixels
    var paddingLeft =
        View.of(context).padding.left / View.of(context).devicePixelRatio;
    var paddingRight =
        View.of(context).padding.right / View.of(context).devicePixelRatio;
    var paddingTop =
        View.of(context).padding.top / View.of(context).devicePixelRatio;
    var paddingBottom =
        View.of(context).padding.bottom / View.of(context).devicePixelRatio;

//Safe area in logical pixels
    var safeWidth = logicalWidth - paddingLeft - paddingRight;
    var safeHeight = logicalHeight - paddingTop - paddingBottom;

    var height =heightf/ 2.1;
    //physicalHeight / 2.1;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ErrorRegisterParent){
          showToast(text: state.errorModel!.message!, state: ToastState.error);
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);

        return SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            color: basic_background,
            child: Center(
              child: Container(
                height: height * 0.8,
                width: width * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: height * 0.02, vertical: width * 0.02),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: width * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Animated_Text(
                                  width: width,
                                  text: 'Add New Parents',
                                  speed: 300),
                              // Text(
                              //   'Add New Parents',
                              //   style: TextStyle(
                              //       fontSize: width * 0.02,
                              //       fontWeight: FontWeight.bold),
                              // )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        // Row_Name_phone_gender(context, height, width, nameController, nameFocusNode, PhoneController, phoneFocusNode, genderFocusNode, iserrorgender, Valuegender, emailFocusNode);
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
                              MyController: nameController,
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
                            // SizedBox(
                            //   width: width * 0.1,
                            // ),
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
                              MyController: PhoneController,
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
                                  selectedValue: Valuegender,
                                  iserror: iserrorgender,
                                  focusnode: genderFocusNode,
                                  onChanged: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(emailFocusNode);

                                    Valuegender = value;

                                    value == null
                                        ? iserrorgender = true
                                        : iserrorgender = false;
                                    RegisterCubit.get(context).updatdropdown();

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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width * 0.03,
                            ),
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
                              MyController: emailController,
                              sufix: Icon(
                                Icons.email,
                                size: width * 0.018,
                              ),
                              validator: (value) {
                                if (!EmailValidator.validate(value!)) {
                                  print('errror email');
                                  return 'Please enter a valid Email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              width: width * 0.06,
                            ),
                            def_Container_RegitsterText(
                              focusnode: passwordFocusNode,
                              height: height,
                              width: width,
                              hinttext: "Password",
                              title: "Password",
                              MyController: passwordController,
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
                              buttonregister(cubit, height, width, () {
                                if (formkey.currentState!.validate()) {
                                  print('yess');
                                  RegisterCubit.get(context).RegisterParents(
                                      PhoneController.text,
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text,
                                      Valuegender);
                                }
                                // RegisterCubit.get(context).updatdropdown();
                              },
                                  cubit.onenter_creat,
                                  cubit.onexitc_creat,
                                  'Create',
                                  cubit.buttonColor,
                                  cubit.textbuttonweightcreat),
                              SizedBox(
                                width: width * 0.025,
                              ),
                              buttonregister(cubit, height, width, () {
                                nameController.clear();
                                PhoneController.clear();
                                Valuegender = null;
                                emailController.clear();
                                passwordController.clear();

                                cubit.updatscreen();
                              },
                                  cubit.onenter_reset,
                                  cubit.onexitc_reset,
                                  'Reset',
                                  cubit.buttonReset,
                                  cubit.textbuttonweightreset),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
// color: Color.fromARGB(255, 120, 139, 149)
