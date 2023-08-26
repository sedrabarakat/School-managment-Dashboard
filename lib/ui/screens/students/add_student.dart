import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_dashboard/cubit/register/register_cubit.dart';
import 'package:school_dashboard/cubit/register/register_state.dart';
import 'package:school_dashboard/main.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/widgets/parents/parents_list_widgets.dart';
import 'package:school_dashboard/ui/widgets/register_widgets.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';

class Add_Student extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var GenderController = TextEditingController();
  var PhoneController = TextEditingController();
  var AddressController = TextEditingController();
  var Left_BusController = TextEditingController();
  var Left_tuition_feesController = TextEditingController();
  late TextEditingController Birth_dateController = TextEditingController();
  // TextEditingController(text: _selectedDate.toString().split(' ')[0]);

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

  String? Valuegender;
  String? Valueinbus;
  String? valueclassStudent;
  String? valuesection;
  String? datetime;
  late int classId;
  int? sectionId;
  var boolisinbus;

  bool? iserrorgender = false;
  bool? iserrorinbus = false;
  bool? iserrorsection = false;
  bool? iserrorclassStudent = false;

  late DateTime _selectedDate = DateTime.now();

  // = DateFormat("yyyy-MM-dd").format(DateTime.now());

  var formkey = GlobalKey<FormState>();
  final formkeydatapicker = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final textFieldKey = GlobalKey();
    var width = MediaQuery.of(context).size.width;
    var height = heightf / 2.1;
    //physicalHeight / 2.1;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is ErrorRegisterStudent){
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
                  height: height * 1.6,
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
                                    text: 'Add New Students',
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
                              FormField(
                                validator: (value) {
                                  value == null
                                      ? iserrorgender = true
                                      : iserrorgender = false;
                                  if (value == null) {
                                    print('errror select');
                                    return;
                                  }
                                  // return null;
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
                                          .requestFocus(classFocusNode);

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
                            // mainAxisAlignment: MainAxisAlignment.start,
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
                                  return def_Container_Regitsterdropdown(
                                    height: height,
                                    width: width,
                                    hinttext: "Select ",
                                    title: "Select Class Student",
                                    item: classStudent,
                                    selectedValue: valueclassStudent,
                                    iserror: iserrorclassStudent,
                                    focusnode: classFocusNode,
                                    onChanged: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(sectionFocusNode);

                                      valueclassStudent = value;

                                      value == null
                                          ? iserrorclassStudent = true
                                          : iserrorclassStudent = false;
                                      RegisterCubit.get(context)
                                          .updatdropdown();

                                      state.didChange(value);

                                      cubit.dataclass.forEach((value) {
                                        if (value['grade'] ==
                                            int.tryParse(valueclassStudent!)) {
                                          classId = value['id'];
                                          valuesection = null;
                                          section = [];
                                          RegisterCubit.get(context)
                                              .getSectionsRegister(
                                              classid: classId);


                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                              FormField(
                                validator: (value) {
                                  value == null
                                      ? iserrorsection = true
                                      : iserrorsection = false;
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
                                    selectedValue: valuesection,
                                    iserror: iserrorsection,
                                    focusnode: sectionFocusNode,
                                    onChanged: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(Birth_dateFocusNode);

                                      valuesection = value;

                                      value == null
                                          ? iserrorsection = true
                                          : iserrorsection = false;
                                      RegisterCubit.get(context)
                                          .updatdropdown();

                                      state.didChange(value);

                                      cubit.datasection.forEach((value) {
                                        if (value['number'] ==
                                            int.tryParse(valuesection!)) {
                                          sectionId = value['id'];
                                        }

                                      });
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
                                    datetime = DateFormat("yyyy/MM/dd")
                                        .format(pickedDate);
                                    _selectedDate = pickedDate;
                                    Birth_dateController.text =
                                    pickedDate.toString().split(' ')[0];
                                  }
                                },
                                height: height,
                                width: width,
                                MyController: Birth_dateController,
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
                                onfieldsubmitted: (value) {
                                  //print(Birth_dateController.text);
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
                              // SizedBox(
                              //   width: width * 0.03,
                              // ),
                              FormField(
                                validator: (value) {
                                  value == null
                                      ? iserrorinbus = true
                                      : iserrorinbus = false;
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
                                    title: "Is in Bus",
                                    item: isinbus,
                                    selectedValue: Valueinbus,
                                    iserror: iserrorinbus,
                                    focusnode: IsinbusFocusNode,
                                    onChanged: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(Left_BusFocusNode);

                                      Valueinbus = value;

                                      value == null
                                          ? iserrorinbus = true
                                          : iserrorinbus = false;
                                      RegisterCubit.get(context)
                                          .updatdropdown();

                                      state.didChange(value);
                                      if (Valueinbus == 'Yes')
                                        boolisinbus = 1;
                                      else
                                        boolisinbus = 0;
                                    },
                                  );
                                },
                              ),
                              // SizedBox(
                              //   width: width * 0.06,
                              // ),
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
                                MyController: Left_BusController,
                                sufix: Icon(
                                  Icons.bus_alert,
                                  size: width * 0.018,
                                ),
                                validator: (value) {
                                  value = int.tryParse(value);
                                  if (value == null) {
                                    return 'Please Type The a number';
                                  }
                                  return null;
                                },
                              ),
                              def_Container_RegitsterText(
                                focusnode: Left_tuition_feesFocusNode,
                                onfieldsubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(AddressFocusNode);
                                },
                                height: height,
                                width: width,
                                hinttext: "Left of tuition_fees",
                                title: "tuition_fees",
                                MyController: Left_tuition_feesController,
                                sufix: Icon(
                                  Icons.money_outlined,
                                  size: width * 0.018,
                                ),
                                validator: (value) {
                                  value = int.tryParse(value);
                                  if (value == null) {
                                    return 'Please Type The a number';
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
                                focusnode: AddressFocusNode,
                                onfieldsubmitted: (value) {
                                  FocusScope.of(context)
                                      .requestFocus(emailFocusNode);
                                },
                                height: height,
                                width: width,
                                hinttext: "Address",
                                title: "Enter Address",
                                MyController: AddressController,
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
                          SizedBox(
                            height: height * 0.1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: width * 0.03,
                            ),
                            child: InkWell(
                              onTap: () async {
                                RegisterCubit.get(context).mypickImage(false);
                              },
                              child: Container(
                                  width: width * 0.17,
                                  height: height * 0.24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey,
                                  ),
                                  child: RegisterCubit.get(context).webimage ==
                                      null
                                      ? Icon(Icons.image)
                                      : Image.memory(
                                    RegisterCubit.get(context).webimage!,
                                    fit: BoxFit.contain,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.03,
                                top: height * 0.1,
                                right: width * 0.05),
                            child: Row(
                              children: [
                                buttonregister(cubit, height, width, () {
                                  if (formkey.currentState!.validate()) {
                                    // RegisterCubit.get(context).RegisterParents(
                                    //     PhoneController.text,
                                    //     nameController.text,
                                    //     emailController.text,
                                    //     passwordController.text,
                                    //     Valuegender);

                                    RegisterCubit.get(context).RegisterStudents(
                                      PhoneController.text,
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text,
                                      Valuegender,
                                      boolisinbus,
                                      Left_BusController.text,
                                      Left_tuition_feesController.text,
                                      parent_id,
                                      sectionId,
                                      AddressController.text,
                                      datetime,
                                    );
                                  }
                                  // RegisterCubit.get(context).updatdropdown();
                                },
                                    cubit.onenter_creat,
                                    cubit.onexitc_creat,
                                    'Creat',
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
                                  Valueinbus = null;
                                  boolisinbus = null;
                                  Left_BusController.clear();
                                  Left_tuition_feesController.clear();
                                  AddressController.clear();
                                  datetime = null;
                                  valueclassStudent = null;
                                  valuesection = null;
                                  iserrorgender = false;
                                  iserrorinbus = false;
                                  iserrorsection = false;
                                  iserrorclassStudent = false;
                                  Birth_dateController.clear();
                                  datetime = null;
                                  sectionId = null;
                                  section = [];

                                  cubit.updatscreen();
                                },
                                    cubit.onenter_reset,
                                    cubit.onexitc_reset,
                                    'Reset',
                                    cubit.buttonReset,
                                    cubit.textbuttonweightreset),
                              ],
                            ),
                          ),
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
