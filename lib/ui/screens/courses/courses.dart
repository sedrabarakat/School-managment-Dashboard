import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_dashboard/cubit/courses/course_cubit.dart';

import 'package:school_dashboard/main.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/theme/styles.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/components/def_dropdown.dart';
import 'package:school_dashboard/ui/widgets/register_widgets.dart';
import 'package:vph_web_date_picker/vph_web_date_picker.dart';


class Courses extends StatelessWidget {
  var NamecourseController = TextEditingController();
  var CountercourseController = TextEditingController();
  var PricecourseController = TextEditingController();
  String? datetime;
  String? valueteacherssession;
  String? valuenamesubject;
  int? subjects_has_teacher_id;
  bool? iserrorteacherssession = false;
  late TextEditingController datecourseController = TextEditingController();
  //List<String> teacter = ["df", "jjj"];

  late DateTime _selectedDate = DateTime.now();
  final now = DateTime.now();
  final formkeydatapicker = GlobalKey<FormState>();
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

    var height = heightf / 2.1;
    //physicalHeight / 2.1;
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CourseCubit.get(context);

        return SingleChildScrollView(
          child: Container(
            // height: height * 3,
            width: width,
            color: basic_background,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.05),
                child: Container(
                  //height: height * 3,
                  width: width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: height * 0.02, vertical: width * 0.02),
                    child: Form(
                      key: formkey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Creat Session",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: width * 0.02),
                              ),
                              Container(
                                height: height * 0.65,
                                width: width * 0.25,
                                decoration: BoxDecoration(
                                    color: feldColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02),
                                  child: Column(
                                    children: [
                                      // Text("creat Session"),
                                      FormField(
                                        validator: (value) {
                                          value == null
                                              ? iserrorteacherssession = true
                                              : iserrorteacherssession = false;
                                          if (value == null) {
                                            print('errror select');
                                            return;
                                          }
                                          return null;
                                        },
                                        builder:
                                            (FormFieldState<dynamic> state) {
                                          return CustomDropdownButton2(
                                            iserror: iserrorteacherssession,
                                            width: width,
                                            height: height,
                                            hint: 'select Teachers session',
                                            dropdownItems: cubit.teacher,
                                            value: valueteacherssession,
                                            // focusnode: subjectsFocusNode,
                                            // iconEnabledColor: Colors.red,
                                            icon: Icon(Icons.arrow_drop_down),
                                            //RegisterCubit.get(context).icongender,
                                            onChanged: (value) {
                                              // FocusScope.of(context)
                                              //     .requestFocus(emailFocusNode);

                                              valueteacherssession = value;

                                              value == null
                                                  ? iserrorteacherssession =
                                              true
                                                  : iserrorteacherssession =
                                              false;
                                              // RegisterCubit.get(context)
                                              //     .updatdropdown();

                                              state.didChange(value);
                                              cubit.teacherdata
                                                  .forEach((value) {
                                                if (value['name'] ==
                                                    valueteacherssession) {
                                                  int teacherid;
                                                  teacherid = value['id'];
                                                  //valuesection = null;
                                                  //section = [];
                                                  cubit.getSubjectsWhereTeacher(
                                                      teacherid: teacherid);
                                                }
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      FormField(
                                        validator: (value) {
                                          value == null
                                              ? iserrorteacherssession = true
                                              : iserrorteacherssession = false;
                                          if (value == null) {
                                            print('errror select');
                                            return;
                                          }
                                          return null;
                                        },
                                        builder:
                                            (FormFieldState<dynamic> state) {
                                          return CustomDropdownButton2(
                                            iserror: iserrorteacherssession,
                                            width: width,
                                            height: height,
                                            hint: 'select subject',
                                            dropdownItems:
                                            cubit.teachersubjeects,
                                            value: valuenamesubject,
                                            // focusnode: subjectsFocusNode,
                                            // iconEnabledColor: Colors.red,
                                            icon: Icon(Icons.arrow_drop_down),
                                            //RegisterCubit.get(context).icongender,
                                            onChanged: (value) {
                                              // FocusScope.of(context)
                                              //     .requestFocus(emailFocusNode);

                                              valuenamesubject = value;
                                              // int indexselect =
                                              //     itemlistsubjects.indexOf(value);
                                              // subjectId =
                                              //     itemlistsubjectsid[indexselect];

                                              // print('classsss id $classId');

                                              // RegisterCubit.get(context)
                                              //     .addsubjectteatcher(
                                              //         classId, subjectId);

                                              value == null
                                                  ? iserrorteacherssession =
                                              true
                                                  : iserrorteacherssession =
                                              false;
                                              // RegisterCubit.get(context).updatdropdown();

                                              state.didChange(value);
                                              cubit.datateachersubjeects
                                                  .forEach((value) {
                                                if (value['name'] ==
                                                    valuenamesubject) {
                                                  subjects_has_teacher_id =
                                                  value['id'];
                                                  print(
                                                      subjects_has_teacher_id);
                                                }
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      TextFormFieldcourse(
                                          width: width,
                                          controller: CountercourseController,
                                          validator: (value) {
                                            value = int.tryParse(value);
                                            if (value == null) {
                                              return 'Please Type The counter';
                                            }
                                            return null;
                                          },
                                          labelText: "Counter of session",
                                          icon: Icon(Icons.countertops)),
                                      TextFormFieldcourse(
                                          width: width,
                                          controller: PricecourseController,
                                          validator: (value) {
                                            value = int.tryParse(value);
                                            if (value == null) {
                                              return 'Please Type The counter';
                                            }
                                            return null;
                                          },
                                          labelText: "price the session",
                                          icon: Icon(Icons.price_change)),
                                      TextFormFieldcourse(
                                        width: width,
                                        controller: datecourseController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please Type The date of session';
                                          }
                                          return null;
                                        },
                                        labelText: "enter the date",
                                        icon: Icon(Icons.price_change),
                                        formkey: formkeydatapicker,
                                        ontap: () async {
                                          final pickedDate =
                                          await showWebDatePicker(
                                            context: formkeydatapicker
                                                .currentContext!,
                                            initialDate: _selectedDate,

                                            firstDate:DateTime(now.year, now.month, now.day + 1),
                                            lastDate: DateTime(2050),
                                            width: 300,
                                          );
                                          if (pickedDate != null) {
                                            datetime = DateFormat("yyyy/MM/dd")
                                                .format(pickedDate);
                                            _selectedDate = pickedDate;
                                            datecourseController.text =
                                            pickedDate
                                                .toString()
                                                .split(' ')[0];
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        height: height * 0.09,
                                      ),
                                      buttonregister(cubit, height, width, () {
                                        cubit.createSession(
                                            valuenamesubject,
                                            CountercourseController.text,
                                            subjects_has_teacher_id,
                                            PricecourseController.text,
                                            datecourseController.text);
                                      },
                                          cubit.onenter_creat,
                                          cubit.onexitc_creat,
                                          "submet",
                                          cubit.buttonColor,
                                          cubit.textbuttonweightcreat),
                                      // SizedBox(
                                      //   height: height * 0.2,
                                      // ),
                                      //  if(cubit.getSessionsModel!.data!.length !=0)
                                      //    Container(
                                      // height: height * 0.3,

                                      // child:
                                      // ListView.separated(
                                      //   scrollDirection: Axis.horizontal,
                                      //   itemBuilder: (context, index) =>
                                      //         itemlistCourse(height: height,width: width,Subject: cubit.getSessionsModel!.data![index].subjectName,teacher:cubit.getSessionsModel!.data![index].teacherName,price:cubit.getSessionsModel!.data![index].price ,maximum_students:cubit.getSessionsModel!.data![index].maximumStudents,date: cubit.getSessionsModel!.data![index].date,current_booked: cubit.getSessionsModel!.data![index].currentBooked ),
                                      //          separatorBuilder: (context, index) =>SizedBox(height: height*0.1,), itemCount: cubit.getSessionsModel!.data!.length)

                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: height*0.02,),
                              Text(
                                "All Sessions ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: width * 0.02),
                              ),
                              if (cubit.getSessionsModel?.status != null)
                                Container(
                                  width: width * 0.25,
                                  child: ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) =>
                                          itemlistCourse(
                                            height: height,
                                            width: width,
                                            Subject: cubit.getSessionsModel!
                                                .data![index].subjectName,
                                            teacher: cubit.getSessionsModel!
                                                .data![index].teacherName,
                                            price: cubit.getSessionsModel!
                                                .data![index].price,
                                            maximum_students: cubit
                                                .getSessionsModel!
                                                .data![index]
                                                .maximumStudents,
                                            date: cubit.getSessionsModel!
                                                .data![index].date,
                                            current_booked: cubit
                                                .getSessionsModel!
                                                .data![index]
                                                .currentBooked,
                                            cubit: cubit,
                                            session_id: cubit.getSessionsModel!
                                                .data![index].sessionId,
                                          ),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: height * 0.1,
                                          ),
                                      itemCount:
                                      cubit.getSessionsModel!.data!.length),
                                ),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.2,
                          ),
                          // Container(width: width*0.2,
                          //   child: ListView.separated( shrinkWrap: true, scrollDirection: Axis.vertical,itemBuilder: (context, index) => itemStudent(width, height, "ff", "0", 2, cubit), separatorBuilder: (context, index) => SizedBox(height: height*0.1,), itemCount: 2)),

                          // Text(
                          //   "StudentsForSession",
                          //   style: TextStyle(
                          //       color: Colors.black,
                          //       fontWeight: FontWeight.w700,
                          //       fontSize: width * 0.02),
                          // ),
                          // SizedBox(
                          //   height: height * 0.05,
                          // ),
                          // if (cubit.studentsForSessionModel?.status != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "StudentsForSession",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: width * 0.02),
                              ),
                              SizedBox(
                                height: height * 0.05,
                              ),
                              if (cubit.studentsForSessionModel?.status != null)
                                Container(
                                  width: width * 0.3,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) => itemStudent(
                                          width,
                                          height,
                                          cubit.studentsForSessionModel!
                                              .data![index].name,
                                          cubit.studentsForSessionModel!
                                              .data![index].status,
                                          cubit.studentsForSessionModel!
                                              .data![index].studentId,
                                          cubit),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                      itemCount: cubit
                                          .studentsForSessionModel!.data!.length),
                                ),
                            ],
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

int? session_idSend;
Widget itemStudent(width, height, name, status, student_id, cubit) {
  return Row(
    children: [
      Text(
        "$name",
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: width * 0.015),
      ),
      SizedBox(
        width: width * 0.1,
      ),
      if (status == "0")
        InkWell(
          onTap: () {
            print("session_idSend is $session_idSend");
            cubit.confirmBooking(session_idSend, student_id);
          },
          child: Container(
            height: height * 0.05,
            width: width * 0.075,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
                child: Text(
                  'Confirmation',
                  style: TextStyle(
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: width * 0.01,
                  ),
                )),
          ),
        ),
      if (status == "1")
        Text(
          'registed',
          style: TextStyle(
            letterSpacing: 1.5,
            color: Colors.blue,
            fontWeight: FontWeight.w300,
            fontSize: width * 0.01,
          ),
        )
    ],
  );
}

Widget itemlistCourse(
    {height,
      width,
      Subject,
      teacher,
      price,
      maximum_students,
      current_booked,
      session_id,
      cubit,
      date}) {
  return InkWell(
    onTap: () {
      session_idSend = session_id;
      cubit.getStudentsForSession(session_id);
    },
    child: Container(
      height: height * 0.38,
      width: width * 0.25,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 163, 208, 221),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: width * 0.01),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Subject:   $Subject",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: width * 0.015,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "teacher:   $teacher",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: width * 0.015,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "price:   $price",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: width * 0.015,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "maximum_students:   $maximum_students",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: width * 0.015,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "current_booked:   $current_booked",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: width * 0.015,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "date:   $date",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: width * 0.015,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    ),
  );
}

// color: Color.fromARGB(255, 120, 139, 149)
Widget TextFormFieldcourse({
  width,
  controller,
  validator,
  labelText,
  icon,
  ontap,
  Key? formkey,
}) {
  return TextFormField(
    key: formkey,
    onTap: ontap,
    style: TextStyle(fontSize: width * 0.012),
    autovalidateMode: AutovalidateMode.disabled,
    validator: validator,
    controller: controller,
    keyboardType: TextInputType.text,
    cursorColor: Color.fromARGB(255, 102, 101, 101),
    decoration: InputDecoration(
      errorStyle: TextStyle(
        fontSize: width * 0.008,
      ),
      border: InputBorder.none,
      labelText: labelText,
      // hintText: "nnjnj",
      hintStyle: TextStyle(
          fontSize: width * 0.01, color: Color.fromARGB(255, 154, 177, 189)),
      suffixIcon: icon,
    ),
    onChanged: (value) {},
  );
}
