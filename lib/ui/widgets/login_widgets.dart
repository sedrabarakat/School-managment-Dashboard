
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/cubit/auth_cubit.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/theme/styles.dart';
import 'package:school_dashboard/ui/components/components.dart';


//Wave
Widget Wave(width){
  return CustomPaint(
    size: Size(width, (width*0.2).toDouble()),
    painter: RPSCustomPainter(),
  );
}



class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint0 = Paint()
      ..color = basicColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path0 = Path();
    path0.moveTo(size.width*0.0000500,size.height*-0.0057917);
    path0.quadraticBezierTo(size.width*0.0000125,size.height*0.4619271,0,size.height*0.6178333);
    path0.cubicTo(size.width*0.0456000,size.height*0.6296250,size.width*0.0574875,size.height*0.8449583,size.width*0.3754625,size.height*0.9319583);
    path0.cubicTo(size.width*0.6785875,size.height*0.9898750,size.width*0.8451375,size.height*0.4568750,size.width,size.height*0.3928750);
    path0.quadraticBezierTo(size.width*1.0200000,size.height*0.2917917,size.width*1.0000500,size.height*-0.0057917);

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}





///////////////////////////////////////////////
//Logo
Widget Logo(width,height){
  return Positioned(
    bottom: height*0.001,
    child: FadeAnimation(
      1,
      Image.asset(
        'assets/images/logo.png',
        width: width * 0.4,
        height: height*0.48,
      ),
    ),
  );
}

/////////////////////////////////////
//White Container

Widget WhiteContainer(context,width,height,cubit,emailController,passwordController,emailFocusNode,passwordFocusNode,formkey){

  return Container(
          height: height * 0.52,
          width: width * 0.5,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.035, vertical: height * 0.008),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                color: shadow.withOpacity(0.7),
                blurRadius: 5,
              )
            ],
          ),
          child: Form(
            key: formkey,
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Login Here',
                        style: TextStyle(color: iconsColor,
                            fontSize: width * 0.03,
                            fontWeight: FontWeight.bold
                        ),

                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    EmailTextFormField(context, emailController, emailFocusNode, passwordFocusNode),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    PasswordTextFormField(cubit, passwordController, passwordFocusNode),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Button(height, width, formkey, emailController, passwordController, cubit),
                  ],
                );
              },
            ),
          ),

  );

}

/////////////////////////////////////

Widget EmailTextFormField(context,emailController,emailFocusNode,passwordFocusNode){
  return FadeAnimation(
    1.1,
    def_chat_TextFromField(
      cursorColor: Colors.blueAccent,
      focusNode: emailFocusNode,
      onFieldSubmitted: (val) {
        FocusScope.of(context)
            .requestFocus(passwordFocusNode);
      },
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      autovalidateMode:
      AutovalidateMode.onUserInteraction,
      label: 'Enter Email',
      labelStyle: const TextStyle(
        color: Colors.black87,
      ),
      prefixIcon: Icon(
        Icons.email,
        color: iconsColor,
      ),
      validator: (value) {
        if (!EmailValidator.validate(value!)) {
          return 'Please enter a valid Email';
        }
        return null;
      },
    ),
  );
}

Widget PasswordTextFormField(cubit,passwordController,passwordFocusNode){

  return FadeAnimation(
    1.2,
    def_chat_TextFromField(
      cursorColor: Colors.blueAccent,
      focusNode: passwordFocusNode,
      keyboardType: TextInputType.emailAddress,
      controller: passwordController,
      obscureText: cubit.isPassword,
      autovalidateMode:
      AutovalidateMode.onUserInteraction,
      label: 'Enter Password',
      labelStyle: const TextStyle(
        color: Colors.black87,
      ),
      prefixIcon: const Icon(
        Icons.lock,
        color: iconsColor,
      ),
      suffixIcon: IconButton(
        onPressed: () {
          cubit.changePasswordVisibility();
        },
        icon: Icon(
          cubit.suffix,
          color: iconsColor,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your Password';
        }
        return null;
      },
    ),
  );

}

Widget Button(height,width,formkey,emailController,passwordController,cubit){

  return ConditionalBuilder(
      condition: !cubit.isAnimated,
      builder: (context) => MouseRegion(
        onEnter: (event)=>cubit.onEntered(true),
        onExit: (event)=>cubit.onEntered(false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: cubit.transform,
          child: AnimatedContainer(
            duration:
            const Duration(milliseconds: 600),
            curve: Curves.easeIn,
            onEnd: () {
              cubit.login(
                  email: emailController.text,
                  password: passwordController.text);
            },
            height: height * 0.06,
            width: width * cubit.ratioButtonWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: primaryGradient,
              border: Border.all(
                  color: Colors.blue
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                // highlightColor: Colors.orange.withOpacity(0.3),
                splashColor: Colors.blue,
                borderRadius:
                BorderRadius.circular(30),
                onTap: () {
                  if (formkey.currentState!
                      .validate()) {
                    cubit.animateTheButton();
                    //toast(text: 'Login Successfulyy');
                  }
                },
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width*0.015,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: width*0.012,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      fallback: (context) => SpinKitApp(width)
  );
}