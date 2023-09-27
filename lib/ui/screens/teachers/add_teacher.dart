import 'dart:js_interop';
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
import 'package:school_dashboard/ui/components/def_dropdown.dart';
import 'package:school_dashboard/ui/widgets/register_widgets.dart';


class Add_Teacher extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var GenderController = TextEditingController();
  var PhoneController = TextEditingController();
  var SalaryController = TextEditingController();

  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  var nameFocusNode = FocusNode();
  var genderFocusNode = FocusNode();
  var phoneFocusNode = FocusNode();
  var salaryFocusNode = FocusNode();
  var classstudentFocusNode = FocusNode();
  var subjectsFocusNode = FocusNode();

  String? value;
  String? Valuegender;
  String? valueclassStudent;
  String? valuesubject;

  bool? iserrorclassStudent = false;
  bool? iserrorgender = false;
  bool? iserrorsubject = false;
  List<String> emptylist = [];

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

    var height = heightf / 2.1;
    //physicalHeight / 2.1;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ErrorRegisterTeacher){
          showToast(text: state.errorModel!.message!, state: ToastState.error);
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);

        return SingleChildScrollView(
          child: Container(
            // height: height,
            width: width,
            color: basic_background,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.05),
              child: Center(
                child: Container(
                  height: height * 1.5,
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
                                    text: 'Add New Teacher',
                                    speed: 300),
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
                                      RegisterCubit.get(context)
                                          .updatdropdown();

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
                              // SizedBox(
                              //   width: width * 0.03,
                              // ),
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
                              // SizedBox(
                              //   width: width * 0.06,
                              // ),
                              def_Container_RegitsterText(
                                focusnode: passwordFocusNode,
                                height: height,
                                width: width,
                                onfieldsubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(salaryFocusNode);
                                },
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
                              def_Container_RegitsterText(
                                focusnode: salaryFocusNode,
                                onfieldsubmitted: (value) {
                                  // FocusScope.of(context)
                                  //     .requestFocus(genderFocusNode);
                                },
                                height: height,
                                width: width,
                                hinttext: "Salary",
                                title: "Salary",
                                MyController: SalaryController,
                                sufix: Icon(
                                  Icons.money,
                                  size: width * 0.018,
                                ),
                                validator: (value) {
                                  value = int.tryParse(value);
                                  if (value == null) {
                                    return 'Please Type The Salary';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),

                          SizedBox(
                            height: height * 0.05,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.03,
                            ),
                            child: InkWell(
                              onTap: () async {
                                RegisterCubit.get(context).mypickImage(true);
                              },
                              child: Container(
                                  width: width * 0.17,
                                  height: height * 0.24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey,
                                  ),
                                  child: RegisterCubit.get(context)
                                      .webimageteacher ==
                                      null
                                      ? Icon(Icons.image)
                                      : Image.memory(
                                    RegisterCubit.get(context)
                                        .webimageteacher!,
                                    fit: BoxFit.contain,
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.03,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Select the class and subject taught by the teacher ',
                                  style: TextStyle(
                                      fontSize: width * 0.011,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 91, 89, 89)),
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                      onPressed: () {
                                        cubit.plusteacherlist();
                                      },
                                      icon: Icon(Icons.add)),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                      onPressed: () {
                                        cubit.minteacherlist();
                                      },
                                      icon: Icon(Icons.remove)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.03,
                            ),
                            child: Container(
                                height: height * 0.2,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        subject_teacher(
                                          height,
                                          width,
                                          iserrorclassStudent,
                                          // cubit.valueClassTeacher[index],
                                          valueclassStudent,
                                          classstudentFocusNode,
                                          context,
                                          iserrorsubject,
                                          valuesubject,
                                          subjectsFocusNode,
                                          cubit,
                                          index,
                                          cubit.subjects[index],
                                          cubit.itemlistsubjectsid,
                                          //cubit.subjects[index].isUndefinedOrNull?emptylist:cubit.subjects[index],
                                          // cubit.itemlistsubjects!,

                                          // cubit.ListSubjectStudent[index],
                                          // height,
                                          // width,
                                          // iserrorclassStudent,
                                          // valueclassStudent,
                                          // classstudentFocusNode,
                                          // context,
                                          // iserrorsubject,
                                          // valuesubject,
                                          // valueclassStudent,
                                          // subjectsFocusNode,
                                          // cubit
                                        ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          width: 20,
                                        ),
                                    itemCount: cubit.listTecherLength)),
                          ),
//cubit.ListSubjectStudent.length

                          SizedBox(
                            height: height * 0.015,
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.03,
                                top: height * 0.05,
                                right: width * 0.05),
                            child: Row(
                              children: [
                                buttonregister(cubit, height, width, () {
                                  if (formkey.currentState!.validate()) {
                                    RegisterCubit.get(context).RegisterTeacher(
                                        PhoneController.text,
                                        nameController.text,
                                        emailController.text,
                                        passwordController.text,
                                        Valuegender,
                                        SalaryController.text);
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
          ),
        );
      },
    );
  }
}
// color: Color.fromARGB(255, 120, 139, 149)
int? classId;
Widget subject_teacher(
    height,
    width,
    iserrorclassStudent,
    valueclassStudent,
    classstudentFocusNode,
    context,
    iserrorsubject,
    valuesubject,
    subjectsFocusNode,
    cubit,
    index,
    itemlistsubjects,
    itemlistsubjectsid) {
  //int? classId;

  int? subjectId;
  var valueclassscreen;
  return Container(
    height: height * 0.8,
    width: width * 0.2,
    decoration: BoxDecoration(
        color: Color.fromARGB(133, 216, 218, 220),
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        FormField(
          validator: (value) {
            value == null
                ? iserrorclassStudent = true
                : iserrorclassStudent = false;
            if (value == null) {
              print('errror select');
              return;
            }
            return null;
          },
          builder: (FormFieldState<dynamic> state) {
            // String valueclassStudent='';
            return CustomDropdownButton2(
              iserror: iserrorclassStudent,
              width: width,
              height: height,
              hint: 'select class',
              dropdownItems: classStudent,
              value: valueclassscreen,
              focusnode: classstudentFocusNode,
              // iconEnabledColor: Colors.red,
              icon: Icon(Icons.arrow_drop_down),
              //RegisterCubit.get(context).icongender,
              onChanged: (value) {
                // FocusScope.of(context)
                //     .requestFocus(emailFocusNode);
                //  valueclassscreen = value;

                valueclassStudent = value;

                // cubit.valueClassSub.add[index] = value;

                value == null
                    ? iserrorclassStudent = true
                    : iserrorclassStudent = false;

                //RegisterCubit.get(context).updatscreen();
                state.didChange(value);
                // int classId;
                cubit.dataclass.forEach((value) {
                  if (value['grade'] == int.tryParse(valueclassStudent!)) {
                    classId = value['id'];
                    // print('classsss id $classId');

                    RegisterCubit.get(context).SubjectsRegister(classId, index);
                  }
                });
              },
            );
          },
        ),
        SizedBox(
          height: height * 0.001,
        ),
        FormField(
          validator: (value) {
            value == null ? iserrorsubject = true : iserrorsubject = false;
            if (value == null) {
              print('errror select');
              return;
            }
            return null;
          },
          builder: (FormFieldState<dynamic> state) {
            return CustomDropdownButton2(
              iserror: iserrorsubject,
              width: width,
              height: height,
              hint: 'select subject',
              dropdownItems: itemlistsubjects,
              value: valuesubject,
              focusnode: subjectsFocusNode,
              // iconEnabledColor: Colors.red,
              icon: Icon(Icons.arrow_drop_down),
              //RegisterCubit.get(context).icongender,
              onChanged: (value) {
                // FocusScope.of(context)
                //     .requestFocus(emailFocusNode);

                valuesubject = value;
                int indexselect = itemlistsubjects.indexOf(value);
                subjectId = itemlistsubjectsid[indexselect];

                print('classsss id $classId');


                RegisterCubit.get(context)
                    .addsubjectteatcher(classId, subjectId);

                value == null ? iserrorsubject = true : iserrorsubject = false;
                // RegisterCubit.get(context).updatdropdown();

                state.didChange(value);
              },
            );
          },
        ),
      ],
    ),
  );
}
