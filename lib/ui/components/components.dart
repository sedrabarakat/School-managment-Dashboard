import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_dashboard/cubit/students/students_list_cubit.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:simple_animations/multi_tween/multi_tween.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';

Widget Text_Icon_Button({
  required VoidCallback Function,
  required double width,
  required String text,
  Color color = Colors.white70,
  IconData icon = Icons.door_back_door,
}) {
  return TextButton(
      onPressed: Function,
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(color: color, fontSize: 18),
          ),
          SizedBox(
            width: width / 120,
          ),
          Icon(
            icon,
            color: Colors.white60,
          )
        ],
      ));
}

Widget Animated_Text(
    {required double width,
    required String text,
    int speed = 500,
    bool isRepeating = false,
    List<Color> colors_list = const [
      Colors.blue,
      Colors.lightBlueAccent,
      Colors.white
    ]}) {
  return AnimatedTextKit(
    isRepeatingAnimation: isRepeating,
    animatedTexts: [
      ColorizeAnimatedText(text,
          speed: Duration(milliseconds: speed),
          colors: colors_list,
          textStyle:
              TextStyle(fontWeight: FontWeight.bold, fontSize: width / 50)),
    ],
  );
}

TextFormField def_TextFromField({
  required TextInputType keyboardType,
  required TextEditingController controller,
  required FocusNode focusNode,
  GestureTapCallback? onTap,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onFieldSubmitted,
  FormFieldValidator? validator,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool obscureText = false,
  int maxLines = 6,
  minLines = 1,
  String label = 'Tap here to write ',
  TextStyle labelStyle = const TextStyle(),
  Color cursorColor = Colors.blue,
  Color borderSideColor = primaryColor2,
  Color focusedBorderColor = primaryColor2,
  Color fillColor = const Color.fromARGB(255, 236, 236, 237),
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
}) {
  return TextFormField(
    onTap: onTap,
    keyboardType: keyboardType,
    controller: controller,
    validator: validator,
    focusNode: focusNode,
    obscureText: obscureText,
    readOnly: false,
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onChanged,
    minLines: minLines,
    maxLines: obscureText ? 1 : maxLines,
    cursorColor: cursorColor,
    autovalidateMode: autovalidateMode,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: label,
      labelStyle: labelStyle,
      fillColor: fillColor,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35.0),
        borderSide: BorderSide(
          color: borderSideColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    ),
  );
}

TextFormField def_TextFromField2({
  required TextInputType keyboardType,
  required TextEditingController controller,
  required FocusNode focusNode,
  GestureTapCallback? onTap,
  String? hintText,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onFieldSubmitted,
  FormFieldValidator? validator,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool obscureText = false,
  int maxLines = 6,
  minLines = 1,
  String label = 'Tap here to write ',
  TextStyle labelStyle = const TextStyle(),
  Color cursorColor = Colors.blue,
  Color borderSideColor = primaryColor2,
  Color focusedBorderColor = primaryColor2,
  Color fillColor = const Color.fromARGB(255, 236, 236, 237),
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
}) {
  return TextFormField(
    onTap: onTap,
    keyboardType: keyboardType,
    controller: controller,
    validator: validator,
    focusNode: focusNode,
    obscureText: obscureText,
    readOnly: false,
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onChanged,
    minLines: minLines,
    maxLines: obscureText ? 1 : maxLines,
    cursorColor: cursorColor,
    autovalidateMode: autovalidateMode,
    decoration: InputDecoration(border: InputBorder.none, hintText: hintText),
  );
}

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(AniProps.translateY, Tween(begin: -30.0, end: 0.0),
          const Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(AniProps.translateY)),
            child: child),
      ),
    );
  }
}

//SPINKIT

Widget SpinKitWeb(width) {
  return SpinKitFadingCube(
    color: Colors.blueAccent,
    size: width * 0.022,
  );
}

// Awesome Dialog
Future<Object?> awsDialogNote(
    context,
    width,
    StudentsListCubit cubit,
    typeCall,
    TextEditingController titleController,
    TextEditingController messageController) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    borderSide: const BorderSide(
      color: Colors.yellow,
      width: 2,
    ),
    width: width * 0.3,
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: false,
    headerAnimationLoop: true,
    animType: AnimType.topSlide,
    title: 'Warning',
    desc: 'Do you want to send a notification?',
    showCloseIcon: true,
    btnCancelOnPress: () {},
    btnOkOnPress: () {
      if (cubit.selectedStudents.isNotEmpty) {
        print(cubit.selectedStudents);
        if (typeCall == 1) {
          cubit.sendAbsentStudents();
        } else {
          cubit.sendNotificationsToStudents(title: titleController.text, message: messageController.text);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('There is no selected data to send notification'),
          ),
        );
      }
    },
  ).show();
}

Future<Object?> awsDialogDeleteForOne(
    context, width, cubit, int typeCall, int idToDelete) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      borderSide: const BorderSide(
        color: Colors.yellow,
        width: 2,
      ),
      width: width * 0.3,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: true,
      animType: AnimType.topSlide,
      title: 'Warning',
      desc: 'Do you want to delete?',
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        //addOneStudentToIds();
        //cubit.ids.add(Ids(StudentData.student_id));
        if (typeCall == 1) {
          cubit.deleteOneStudentData(id: idToDelete);
        } else if (typeCall == 2) {
          cubit.deleteOneTeacherData(id: idToDelete);
        } else if (typeCall == 3) {
          cubit.deleteOneClassData(id: idToDelete);
        } else if (typeCall == 4) {
          cubit.deleteOneParentData(id: idToDelete);
        } else {
          cubit.deleteOneAdminData(id: idToDelete);
        }
      }).show();
}

Future<Object?> awsDialogDeleteForAll(context, width, cubit, typeCall) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      borderSide: const BorderSide(
        color: Colors.yellow,
        width: 2,
      ),
      width: width * 0.3,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: true,
      animType: AnimType.topSlide,
      title: 'Warning',
      desc: 'Do you want to delete?',
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        if (typeCall == 1) {
          if (cubit.selectedStudents.isNotEmpty) {
            cubit.deleteStudentsData();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('There is no selected data to delete'),
              ),
            );
          }
        } else if (typeCall == 2) {
          if (cubit.selectedTeachers.isNotEmpty) {
            cubit.deleteTeachersData();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('There is no selected data to delete'),
              ),
            );
          }
        } else if (typeCall == 3) {
          if (cubit.selectedClasses.isNotEmpty) {
            cubit.deleteClassesData();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('There is no selected data to delete'),
              ),
            );
          }
        } else if (typeCall == 4) {
          if (cubit.selectedParents.isNotEmpty) {
            cubit.deleteParentsData();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('There is no selected data to delete'),
              ),
            );
          }
        } else {
          if (cubit.selectedAdmins.isNotEmpty) {
            cubit.deleteAdminsData();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('There is no selected data to delete'),
              ),
            );
          }
        }
      }).show();
}

//without buttons
Future<Object?> AwsDialog(context, type, width) {
  return AwesomeDialog(
    context: context,
    dialogType: type == 1 ? DialogType.success : DialogType.warning,
    borderSide: const BorderSide(
      color: Colors.greenAccent,
      width: 2,
    ),
    width: width * 0.3,
    buttonsBorderRadius: const BorderRadius.all(
      Radius.circular(2),
    ),
    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: false,
    /*onDismissCallback: (type) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Deletion Cancelled'),
        ),
      );
    },*/
    headerAnimationLoop: true,
    animType: AnimType.topSlide,
    title: 'Success',
    desc: 'A Notification sent',
    showCloseIcon: true,
    autoHide: const Duration(seconds: 2),
    //btnCancelOnPress: () {},
    //btnOkOnPress: () {},
  ).show();
}

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM_LEFT,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.black87,
      fontSize: 17.0,
    );

enum ToastState { success, error, warning }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.black26;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
