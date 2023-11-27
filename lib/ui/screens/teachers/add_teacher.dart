import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/register/register_cubit.dart';
import 'package:school_dashboard/cubit/register/register_state.dart';
import 'package:school_dashboard/main.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/components/def_dropdown.dart';
import 'package:school_dashboard/ui/widgets/register_widgets.dart';

class Add_Teacher extends StatelessWidget {

  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  var nameFocusNode = FocusNode();
  var genderFocusNode = FocusNode();
  var phoneFocusNode = FocusNode();
  var salaryFocusNode = FocusNode();
  var classstudentFocusNode = FocusNode();
  var subjectsFocusNode = FocusNode();

  bool? iserrorclassStudent = false;
  bool? iserrorgender = false;
  bool? iserrorsubject = false;
  List<String> emptylist = [];

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = heightf / 2.1;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        var cubit = RegisterCubit.get(context);
        if (state is SuccessRegisterTeacher) {
          cubit.clearTeachersControllers();
          showToast(
              text: 'Teacher Created Successfully', state: ToastState.success);
        }
        if (state is ErrorRegisterTeacher) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Animated_Text(
                          width: width, text: 'Add New Teacher', speed: 300),
                      InkWell(
                        onTap: () async {
                          RegisterCubit.get(context).myPickImage(true);
                        },
                        child: Container(
                            width: width * 0.17,
                            height: height * 0.24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFFEDEDED),
                            ),
                            child:
                            RegisterCubit.get(context).webImageTeacher ==
                                null
                                ? Icon(
                              Icons.image,
                              size: 40.sp,
                            )
                                : Image.memory(
                              RegisterCubit.get(context)
                                  .webImageTeacher!,
                              fit: BoxFit.contain,
                            )),
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
                        focusnode: nameFocusNode,
                        onfieldsubmitted: (value) {
                          FocusScope.of(context).requestFocus(phoneFocusNode);
                        },
                        height: height,
                        width: width,
                        hinttext: "Enter name",
                        title: "Full Name",
                        MyController: cubit.nameTeacherController,
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
                        MyController: cubit.phoneTeacherController,
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
                            selectedValue: cubit.valueGenderTeacher,
                            iserror: iserrorgender,
                            focusnode: genderFocusNode,
                            onChanged: (value) {
                              FocusScope.of(context)
                                  .requestFocus(emailFocusNode);
                              cubit.valueGenderTeacher = value;
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
                        MyController: cubit.emailTeacherController,
                        sufix: Icon(
                          Icons.email,
                          size: width * 0.018,
                        ),
                        validator: (value) {
                          if (!EmailValidator.validate(value!)) {
                            print('error email');
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
                      ),
                      def_Container_RegitsterText(
                        focusnode: passwordFocusNode,
                        height: height,
                        width: width,
                        onfieldsubmitted: (value) {
                          FocusScope.of(context).requestFocus(salaryFocusNode);
                        },
                        hinttext: "Password",
                        title: "Password",
                        MyController: cubit.passwordTeacherController,
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
                        MyController: cubit.salaryTeacherController,
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
                  Divider(
                    thickness: 0.5,
                    color: Colors.blue,
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select Classes and Subjects that teacher will be teaching:',
                        style: TextStyle(
                            fontSize: width * 0.011,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 91, 89, 89)),
                      ),
                      SizedBox(width: width*0.01,),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: IconButton(
                            onPressed: () {
                              cubit.plusTeacherList();
                            },
                            icon: const Icon(Icons.add,color: Colors.white,)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: IconButton(
                            onPressed: () {
                              cubit.minTeacherList();
                            },
                            icon: const Icon(Icons.remove,color: Colors.white,)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  cubit.listTeacherLength > 0 ? Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.03,
                    ),
                    child: Container(
                      height: height * 0.18,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => subjectTeacherList(
                                height,
                                width,
                                iserrorclassStudent,
                                context,
                                iserrorsubject,
                                cubit,
                                index,
                              ),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 20,
                              ),
                          itemCount: cubit.listTeacherLength),
                    ),
                  ) : Container(),
                  SizedBox(
                    height: height * 0.035,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.03,
                        top: height * 0.05,
                        right: width * 0.05),
                    child: Row(
                      children: [
                        buttonRegister(cubit, height, width, () {
                          if (formkey.currentState!.validate()) {
                            if (cubit.valueGenderTeacher != null) {
                              RegisterCubit.get(context).registerTeacher(
                                  cubit.phoneTeacherController.text,
                                  cubit.nameTeacherController.text,
                                  cubit.emailTeacherController.text,
                                  cubit.passwordTeacherController.text,
                                  cubit.valueGenderTeacher,
                                  cubit.salaryTeacherController.text);
                            }
                          }
                        }, cubit.onEnterCreate, cubit.onExitCreate, 'Create',
                            cubit.buttonColor, cubit.textButtonWeightCreate),
                        SizedBox(
                          width: width * 0.025,
                        ),
                        buttonRegister(cubit, height, width, () {
                          cubit.clearTeachersControllers();
                        }, cubit.onEnterReset, cubit.onExitReset, 'Reset',
                            cubit.buttonReset, cubit.textButtonWeightReset),
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

// color: Color.fromARGB(255, 120, 139, 149)
int? classId;

Widget subjectTeacherList(
    height,
    width,
    iserrorclassStudent,
    context,
iserrorsubject,
    RegisterCubit cubit,
    index,) {

  return Container(
    width: width * 0.2,
    decoration: BoxDecoration(
        color: const Color.fromARGB(133, 216, 218, 220),
        borderRadius: BorderRadius.circular(10)),
    child: Column(
      children: [
        FormField(
          validator: (value) {
            value == null
                ? iserrorclassStudent = true
                : iserrorclassStudent = false;
            if (value == null) {
              print('error select');
              return;
            }
            return null;
          },
          builder: (FormFieldState<dynamic> state) {
            return CustomDropdownButton2(
              iserror: iserrorclassStudent,
              width: width,
              height: height,
              hint: 'Select Class',
              dropdownItems: classStudent,
              value: cubit.valueClassTeacherList.length <= index ? null : cubit.valueClassTeacherList[index],
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (value) {
                if (cubit.valueClassTeacherList.length == index) {
                  cubit.valueClassTeacherList.add('');
                }
                cubit.valueClassTeacherList[index] = value;

                if (cubit.valueSubjectTeacherList.length == index) {
                  cubit.valueSubjectTeacherList.add('');
                }

                cubit.valueSubjectTeacherList[index] = null;
                cubit.subjects[index] = [];

                print('valueClassTeacherList=');
                print(cubit.valueClassTeacherList);

                RegisterCubit.get(context).updateDropdown();
                value == null
                    ? iserrorclassStudent = true
                    : iserrorclassStudent = false;
                state.didChange(value);
                for (var value in cubit.dataclass) {
                  if (value['grade'] == int.tryParse(cubit.valueClassTeacherList[index])) {
                    RegisterCubit.get(context)
                        .getSubjectsRegister(value['id'],index);
                    break;
                  }
                }
                print('classesIds=');
                print(cubit.classesIds);
                print('subjectsIds=');
                print(cubit.subjectsIds);
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
              print('error select');
              return;
            }
            return null;
          },
          builder: (FormFieldState<dynamic> state) {
            return CustomDropdownButton2(
              iserror: iserrorsubject,
              width: width,
              height: height,
              hint: 'Select Subject',
              dropdownItems: cubit.subjects[index],
              value: cubit.valueSubjectTeacherList.length <= index ? null : cubit.valueSubjectTeacherList[index],
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (value) {
                if (cubit.valueSubjectTeacherList.length == index) {
                  cubit.valueSubjectTeacherList.add('');
                }
                cubit.valueSubjectTeacherList[index] = value;

                print('valueSubjectTeacherList=');
                print(cubit.valueSubjectTeacherList);

                RegisterCubit.get(context).updateDropdown();
                value == null ? iserrorsubject = true : iserrorsubject = false;
                state.didChange(value);
                for (var value in cubit.dataSubject) {
                  if (value['name'] == cubit.valueSubjectTeacherList[index]) {

                    if (cubit.subjectsIds.length == index) {
                      cubit.subjectsIds.add(0);
                    }
                    cubit.subjectsIds[index] = value['id'];
                    break;
                  }
                }
                print('classesIds=');
                print(cubit.classesIds);
                print('subjectsIds=');
                print(cubit.subjectsIds);
              },
            );
          },
        ),
      ],
    ),
  );
}
