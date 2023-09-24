import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_network/image_network.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/articles/articles_cubit.dart';
import 'package:school_dashboard/cubit/courses/course_cubit.dart';
import 'package:school_dashboard/ui/components/def_dropdown.dart';
import 'package:simple_animations/multi_tween/multi_tween.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';
import '../../cubit/basic/basic_cubit.dart';
import '../../cubit/students/students_list_cubit.dart';
import '../../theme/colors.dart';
import '../../theme/styles.dart';


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

Widget Animated_Text({
  required double width,
  required String text,
  int speed=500,
  bool isRepeating=false,
  List<Color>colors_list= const [Colors.blue,Colors.lightBlueAccent,Colors.white],
}){
  return AnimatedTextKit(
    isRepeatingAnimation: isRepeating,
    animatedTexts: [
      ColorizeAnimatedText(text,
          speed: Duration(milliseconds: speed),
          colors: colors_list,
          textStyle:
          TextStyle(fontWeight: FontWeight.bold, fontSize: width / 50,)),
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
  int? maxLength,
  String? counterText = '',
  MaxLengthEnforcement? maxLengthEnforcement,
  bool obscureText = false,
  int maxLines = 1,
  int minLines = 1,
  String label = 'Tap here to write ',
  TextStyle labelStyle = const TextStyle(),
  Color cursorColor = Colors.blue,

  Color borderFocusedColor = primaryColor2,
  Color borderNormalColor = Colors.black,



  Color fillColor = const Color.fromARGB(255, 236, 236, 237),
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  double br = 25.0,
}) {
  return TextFormField(
    onTap: onTap,
    maxLength: maxLength,
    maxLengthEnforcement:
    maxLengthEnforcement,
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
      counterText: counterText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: label,
      labelStyle: labelStyle,
      fillColor: fillColor,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(br),
        borderSide: BorderSide(
          color: borderFocusedColor,
          width: 2
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(br),
        borderSide:  BorderSide(
          color: borderNormalColor,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(br),
        borderSide:  BorderSide(
          color: borderNormalColor,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(br),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.0,
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
            child: child
        ),
      ),
    );
  }
}

//SPINKIT

Widget SpinKitApp(width){
  return SpinKitFadingCube(
    color: Colors.blueAccent,
    size: width*0.022,
  );
}

Widget SpinKitWeb(width) {
  return SpinKitFadingCube(
    color: Colors.blueAccent,
    size: width * 0.02,
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
    context, width,cubit, int typeCall, int idToDelete) {
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
        if (typeCall == 0) {
          cubit.delete_Session(sessionId: idToDelete);
        }
          else if (typeCall == 1) {
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
        webShowClose: true,
        msg: "$text",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 3,
        webPosition: "center",
        webBgColor: "${chooseToastColor(state)}",
        textColor: Colors.white,
        fontSize: 16.0
    );

enum ToastState { success, error, warning }

String chooseToastColor(ToastState state) {
  String color;
  switch (state) {
    case ToastState.success:
      color="linear-gradient(to right,#1f8cf2, #03a9f4, #1cb2f5)";
      break;
    case ToastState.error:
      color ="linear-gradient(to right, #dc1c13, #dc1c13)";
      break;
    case ToastState.warning:
      color = "linear-gradient(to right, #f7b436,#f7b436)";
      break;
  }
  return color;
}


image_container({
  required double container_width,
  required double container_height,
  required String imageUrl,
}){
  return  Container(
    clipBehavior: Clip.hardEdge,
    height: container_height,width: container_width,
    decoration:Circle_BoxDecoration,//'http://10.0.2.2:8000/storage/${myprofile['image']}
    child: ImageNetwork(image: "$imageUrl",
      debugPrint: true,
      height:container_height,
      width: container_width,
    ),
  );
}

Default_image({
  required double container_width,
  required double container_height,
  required String pic_path,
}){
  return  Container(
    clipBehavior: Clip.hardEdge,
    height: container_height,width: container_width,
    decoration:Circle_BoxDecoration,
    child: Image.asset(pic_path),
  );
}



Widget circle_icon_button({
  required VoidCallback button_Function,
  required IconData icon,
  required String hint_message,
  Color icon_color=Colors.lightBlue,
  Color backgroundColor=const Color.fromARGB(255, 239, 244, 249)
}){
  return Tooltip(
    waitDuration: Duration(milliseconds:500),
    message: hint_message,
    child: CircleAvatar(
        backgroundColor: backgroundColor,
        child: IconButton(onPressed: button_Function,icon: Icon(icon,color:icon_color,
        ),)
    ),
  );
}

ElevatedButton elevatedbutton({
  required VoidCallback Function,
  required double widthSize,
  required double heightSize,
  required String text,
  Color textcolor=Colors.white,
  Color backgroundColor=Colors.lightBlue,
  Color  foregroundColor=Colors.white54,
  Color shadowColor=Colors.grey,
  double elevation=10,
  double borderRadius=10,
  // required double widthSize,
  //   required double heightSize,
}){
  return ElevatedButton(
    onPressed:Function,
    child: Text(text,
      style: TextStyle(color: textcolor),),
    style: ElevatedButton.styleFrom(
        elevation:elevation,
        fixedSize:Size(widthSize, heightSize),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shadowColor:shadowColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)
        ),
        animationDuration: Duration(seconds: 100),
        splashFactory: InkSplash.splashFactory
    ),
  );
}

Widget backToRout({
  required String from,
  required double width,
  required String from_rout,
  required BuildContext context,
  required String To
}) {
  return Container(
    height: height/40,
    child: Row(
      children: [
        TextButton(
            onPressed: () {
              Basic_Cubit.get(context).change_Route('$from_rout');
            },
            child: Text(
              '$from',
              style: TextStyle(color: Colors.blue, fontSize: width * 0.012),
            )),
        SizedBox(
          width: width * 0.01,
        ),
        Text(
          '->     + $To',
          style: TextStyle(color: Colors.grey, fontSize: width * 0.012),
        ),
      ],
    ),
  );
}


Widget def_Emoji_picker(message,Color indicatorColor,iconColorSelected, ArticlesCubit cubit){
  return EmojiPicker(
    onEmojiSelected: (category,emoji){
      message.text=message.text+emoji.emoji;
      print(emoji);
    },
    config: Config(columns: 7,
      gridPadding: EdgeInsets.all(18),
      initCategory: Category.RECENT,
      bgColor: Colors.white,
      indicatorColor: indicatorColor,//Color(0xFFD3567C)
      iconColor: Colors.grey,
      iconColorSelected:iconColorSelected,//Color(0xFFD3567C)
      skinToneDialogBgColor: Colors.white,
      skinToneIndicatorColor: Colors.grey,
      recentsLimit: 0,
      replaceEmojiOnLimitExceed: false,
      noRecents:  Text(
        'No Recents',
        style: TextStyle(fontSize: 40.sp, color: Colors.black),
        textAlign: TextAlign.center,
      ),
      loadingIndicator: const SizedBox.shrink(),
      tabIndicatorAnimDuration: kTabScrollDuration,
      categoryIcons: const CategoryIcons(),
      buttonMode: ButtonMode.MATERIAL,
      checkPlatformCompatibility: true,),
  );
}

image_article_container({
  required double container_width,
  required double container_height,
  required String imageUrl,
}){
  return  Container(
    height: container_height,width: container_width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: ImageNetwork(image: "$imageUrl",
      debugPrint: true,
      height:container_height,
      width: container_width,
    ),
  );
}


Widget def_Container_RegitsterText({
  required height,
  required width,
  required MyController,
  hinttext,
  title,
  Widget? sufix,
  bool obscureText = false,
  FormFieldValidator? validator,
  Key? formkey,
  Key? datapickerformkey,
  focusnode,
  ValueChanged<String>?  onfieldsubmitted,
  ontap,

}) {
  return FadeAnimation(
    1,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height * 0.07,
          width: width * 0.2,
          decoration: BoxDecoration(
              color: Color.fromARGB(133, 216, 218, 220),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.008),
            child: Center(
              child: TextFormField(
                key: formkey,
                onTap: ontap,
                style: TextStyle(fontSize: width*0.012),
                autovalidateMode: AutovalidateMode.disabled,
                focusNode: focusnode,
                onFieldSubmitted:onfieldsubmitted ,
                validator: validator,
                obscureText: obscureText,
                controller: MyController,
                keyboardType: TextInputType.text,
                cursorColor: Color.fromARGB(255, 102, 101, 101),
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    fontSize: width * 0.008,
                  ),
                  border: InputBorder.none,
                  hintText: hinttext,
                  hintStyle: TextStyle(
                      fontSize: width * 0.01,
                      color: Color.fromARGB(255, 154, 177, 189)),
                  suffixIcon: sufix,
                ),
                onChanged: (value) {},
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.015,
        ),
        Text(
          ' $title *',
          style: TextStyle(
              fontSize: width * 0.011,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 91, 89, 89)),
        ),
      ],
    ),
  );
}

Widget def_Container_Regitsterdropdown(
    {required height,
      required width,
      required List<String> item,
      hinttext,
      title,
      Widget? sufix,
      bool? iserror,
      required ValueChanged? onChanged,
      FormFieldValidator? validator,
      focusnode,

      required selectedValue,}) {
  return FadeAnimation(
    1.1,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height * 0.07,
          width: width * 0.2,
          decoration: BoxDecoration(
              color: Color.fromARGB(133, 216, 218, 220),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.008),
            child: Center(
              child: CustomDropdownButton2(
                iserror: iserror,
                width: width,
                height: height,
                hint: hinttext,
                dropdownItems: item,
                value: selectedValue,
                focusnode: focusnode,
                // iconEnabledColor: Colors.red,
                icon: Icon(Icons.arrow_drop_down),
                //RegisterCubit.get(context).icongender,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.015,
        ),
        Text(
          ' $title *',
          style: TextStyle(
              fontSize: width * 0.011,
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 91, 89, 89)),
        ),
      ],
    ),
  );
}