 import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

Widget Text_Icon_Button({
   required VoidCallback Function,
   required double width,
   required String text,
   Color color= Colors.white70,
   IconData icon=Icons.door_back_door,
 }){
  return TextButton(onPressed: Function, child: Row(children: [
    Text(text,style: TextStyle(color:color,fontSize: 18),),
    SizedBox(width: width/120,),
    Icon(icon,color: Colors.white60,)
  ],));
 }

 Widget Animated_Text({
   required double width,
   required String text,
    int speed=500,
   bool isRepeating=false,
   List<Color>colors_list= const [Colors.blue,Colors.lightBlueAccent,Colors.white]
 }){
  return AnimatedTextKit(
    isRepeatingAnimation: isRepeating,
    animatedTexts: [
      ColorizeAnimatedText(text,
          speed: Duration(milliseconds: speed),
          colors: colors_list,
          textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width/50
          )
      ),
    ],
  );
 }

TextFormField def_chat_TextFromField({
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
  Color cursorColor =  Colors.blue,
  Color borderSideColor =  primaryColor2,
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
    maxLines: obscureText?1:maxLines,
    cursorColor: cursorColor,
    autovalidateMode: autovalidateMode,
    /*decoration: InputDecoration(
      border: InputBorder.none,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: label,
      labelStyle: labelStyle,
      fillColor: fillColor,
      filled: true,
    ),*/
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






enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(AniProps.translateY, Tween(begin: -30.0, end: 0.0), Duration(milliseconds: 500), Curves.easeOut);

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
