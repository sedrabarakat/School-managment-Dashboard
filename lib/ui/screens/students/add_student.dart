import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/register/register_cubit.dart';
import 'package:school_dashboard/cubit/register/register_state.dart';
import 'package:school_dashboard/main.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/widgets/parents/parents_list_widgets.dart';
import 'package:school_dashboard/ui/widgets/register_widgets.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

import '../../../constants.dart';
import '../../../routes/web_router.dart';

class Add_Student extends StatelessWidget {
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  var nameFocusNode = FocusNode();
  var genderFocusNode = FocusNode();
  var classFocusNode = FocusNode();
  var sectionFocusNode = FocusNode();
  var phoneFocusNode = FocusNode();
  var AddressFocusNode = FocusNode();
  var Left_BusFocusNode = FocusNode();
  var Left_tuition_feesFocusNode = FocusNode();
  var Birth_dateFocusNode = FocusNode();
  var IsinbusFocusNode = FocusNode();

  late DateTime _selectedDate = DateTime.now();

  var formkey = GlobalKey<FormState>();
  final formkeydatapicker = GlobalKey<FormState>();

  Add_Student({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = heightf / 2.1;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        var cubit = RegisterCubit.get(context);
        if (state is SuccessRegisterStudent) {
          cubit.clearStudentControllers();
          showToast(
              text: 'Student Created Successfully', state: ToastState.success);
        }
        if (state is ErrorRegisterStudent) {
          showToast(text: state.errorModel!.message!, state: ToastState.error);
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        if (cubit.isLoading == false) {
          return SingleChildScrollView(
                controller: Basic_Cubit.get(context).scrollController,
                scrollDirection: Axis.vertical,
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    W_Router.router.go('/parents_list');

                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                Animated_Text(
                                    width: width,
                                    text: 'Add New Students',
                                    speed: 300),
                              ],
                            ),
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
                                child: RegisterCubit.get(context).webImageStudent ==
                                        null
                                    ? Icon(
                                        Icons.image,
                                        size: 40.sp,
                                      )
                                    : Image.memory(
                                        RegisterCubit.get(context).webImageStudent!,
                                        fit: BoxFit.contain,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        //Row_Name_phone_gender(context, height, width, nameController, nameFocusNode, PhoneController, phoneFocusNode, genderFocusNode, iserrorgender, Valuegender, emailFocusNode),
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
                              MyController: cubit.nameStudentController,
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
                              MyController: cubit.phoneStudentController,
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
                                    ? cubit.iserrorgender = true
                                    : cubit.iserrorgender = false;
                                if (value == null) {
                                  print('errror select');
                                  return;
                                }
                                return null;
                                // return null;
                              },
                              builder: (FormFieldState<dynamic> state) {
                                return def_Container_Regitsterdropdown(
                                  height: height,
                                  width: width,
                                  hinttext: "Select gender",
                                  title: "Gender",
                                  item: genderitem,
                                  selectedValue: cubit.valueGenderStudent,
                                  iserror: cubit.iserrorgender,
                                  focusnode: genderFocusNode,
                                  onChanged: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(classFocusNode);

                                    cubit.valueGenderStudent = value;

                                    value == null
                                        ? cubit.iserrorgender = true
                                        : cubit.iserrorgender = false;
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
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FormField(
                              validator: (value) {
                                value == null
                                    ? cubit.iserrorclassStudent = true
                                    : cubit.iserrorclassStudent = false;
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
                                  hinttext: "Select ",
                                  title: "Select Class Student",
                                  item: classStudent,
                                  selectedValue: cubit.valueClassStudent,
                                  iserror: cubit.iserrorclassStudent,
                                  focusnode: classFocusNode,
                                  onChanged: (value) {
                                    print('value=$value');
                                    FocusScope.of(context)
                                        .requestFocus(sectionFocusNode);

                                    cubit.valueClassStudent = value;

                                    value == null
                                        ? cubit.iserrorclassStudent = true
                                        : cubit.iserrorclassStudent = false;
                                    RegisterCubit.get(context).updateDropdown();

                                    state.didChange(value);
                                    print(cubit.valueClassStudent);
                                    for (var value in cubit.dataclass) {
                                      print('${value['grade']} <><> ${cubit.valueClassStudent!}');
                                      if (value['grade'] ==
                                          int.tryParse(
                                              cubit.valueClassStudent!)) {
                                        cubit.classId = value['id'];
                                        section = [];
                                        RegisterCubit.get(context)
                                            .getSectionsRegisterForStudent(
                                                classId: cubit.classId!);
                                        break;
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                            FormField(
                              validator: (value) {
                                value == null
                                    ? cubit.iserrorsection = true
                                    : cubit.iserrorsection = false;
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
                                  hinttext: "Select ",
                                  title: "Select Section",
                                  item: section,
                                  selectedValue: cubit.valueSectionStudent,
                                  iserror: cubit.iserrorsection,
                                  focusnode: sectionFocusNode,
                                  onChanged: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(Birth_dateFocusNode);

                                    cubit.valueSectionStudent = value;

                                    value == null
                                        ? cubit.iserrorsection = true
                                        : cubit.iserrorsection = false;
                                    RegisterCubit.get(context).updateDropdown();

                                    state.didChange(value);

                                    for (var value in cubit.datasectionst) {
                                      if (value['number'] ==
                                          int.tryParse(cubit.valueSectionStudent!)) {
                                        cubit.sectionId = value['id'];
                                        break;
                                      }
                                    }
                                  },
                                );
                              },
                            ),
                            def_Container_RegitsterText(
                              formkey: formkeydatapicker,
                              ontap: () async {
                                final pickedDate = await showWebDatePicker(
                                  context: formkeydatapicker.currentContext!,
                                  initialDate: _selectedDate,
                                  firstDate: DateTime(1980),
                                  lastDate: DateTime.now(),

                                  //firstDate: DateTime.now().add(const Duration(days: 1)),
                                  // lastDate: DateTime.now().add(const Duration(days: 14000)),
                                  width: 300,
                                );
                                if (pickedDate != null) {
                                  cubit.valueDateTimeStudent = DateFormat("yyyy/MM/dd")
                                      .format(pickedDate);
                                  _selectedDate = pickedDate;
                                  cubit.birthDateController.text =
                                      pickedDate.toString().split(' ')[0];
                                }
                              },
                              height: height,
                              width: width,
                              MyController: cubit.birthDateController,
                              hinttext: 'date',
                              title: 'date of birth',
                              sufix: Icon(
                                Icons.today,
                                size: width * 0.018,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Type The date of birth';
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            def_Container_RegitsterText(
                              focusnode: AddressFocusNode,
                              onfieldsubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(Left_BusFocusNode);
                              },
                              height: height,
                              width: width,
                              hinttext: "Address",
                              title: "Enter Address",
                              MyController: cubit.addressStudentController,
                              sufix: Icon(
                                Icons.location_city,
                                size: width * 0.018,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Type The Address';
                                }
                                return null;
                              },
                            ),
                            def_Container_RegitsterText(
                              focusnode: Left_BusFocusNode,
                              onfieldsubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(Left_tuition_feesFocusNode);
                              },
                              height: height,
                              width: width,
                              hinttext: "Left of Bus",
                              title: "Left of Bus",
                              MyController: cubit.leftBusController,
                              sufix: Icon(
                                Icons.bus_alert,
                                size: width * 0.018,
                              ),
                              validator: (value) {
                                int? parsedValue = int.tryParse(value);
                                if (parsedValue == null && value != '') {
                                  return 'Must be a number';
                                }
                                return null;
                              },
                            ),
                            def_Container_RegitsterText(
                              focusnode: Left_tuition_feesFocusNode,
                              onfieldsubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(emailFocusNode);
                              },
                              height: height,
                              width: width,
                              hinttext: "Left of tuition_fees",
                              title: "tuition_fees",
                              MyController: cubit.leftTuitionFeesController,
                              sufix: Icon(
                                Icons.money_outlined,
                                size: width * 0.018,
                              ),
                              validator: (value) {
                                value = int.tryParse(value);
                                if (value == null) {
                                  return 'Please Type The number';
                                }
                                return null;
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
                              hinttext: "Email Address",
                              title: "Email",
                              MyController: cubit.emailStudentController,
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
                              hinttext: "Password",
                              title: "Password",
                              MyController: cubit.passwordStudentController,
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
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.03,
                              top: height * 0.1,
                              right: width * 0.05),
                          child: Row(
                            children: [
                              buttonRegister(cubit, height, width, () {
                                if (formkey.currentState!.validate()) {
                                  if (cubit.valueGenderStudent != null &&
                                      cubit.valueDateTimeStudent != null &&
                                      cubit.sectionId != null) {
                                    RegisterCubit.get(context).registerStudents(
                                      cubit.phoneStudentController.text,
                                      cubit.nameStudentController.text,
                                      cubit.emailStudentController.text,
                                      cubit.passwordStudentController.text,
                                      cubit.valueGenderStudent,
                                      cubit.leftBusController.text,
                                      cubit.leftTuitionFeesController.text,
                                      parent_id,
                                      cubit.sectionId,
                                      cubit.addressStudentController.text,
                                      cubit.valueDateTimeStudent,
                                    );
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
                                cubit.clearStudentControllers();
                              },
                                  cubit.onEnterReset,
                                  cubit.onExitReset,
                                  'Reset',
                                  cubit.buttonReset,
                                  cubit.textButtonWeightReset),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
        } else {
          return Center(
                child: SpinKitWeb(width),
              );
        }
      },
    );
  }
}
// color: Color.fromARGB(255, 120, 139, 149)
