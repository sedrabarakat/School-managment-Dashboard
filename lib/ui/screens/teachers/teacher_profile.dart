import 'dart:js_interop';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/models/teacher_profile_model.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/widgets/class_widgets.dart';
import 'package:school_dashboard/ui/widgets/teachers/teachers_list_widgets.dart';
import '../../../cubit/profile/Profiles_cubit.dart';
import '../../../cubit/profile/student_profile_states.dart';
import '../../../theme/styles.dart';
import '../../components/components.dart';
import '../../widgets/profiles_widget.dart';

class Teacher_profile extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var name=TextEditingController();
    var email=TextEditingController();
    var Gender=TextEditingController();
    var Number=TextEditingController();
    var Subject=TextEditingController();
    var Salary=TextEditingController();
    double width  =  MediaQuery.of(context).size.width;

  return BlocProvider(
    create: (BuildContext context) => Profiles_cubit()..get_Teacher_profile(teacher_id: Teacher_id!.toInt()),
    child: BlocConsumer<Profiles_cubit,Profiles_states>(
      listener: (context,state){
        if(state is Success_update_teacher_profile)
          showToast(text: 'Successfully updated', state: ToastState.success);
        if(state is Error_get_teacher_profile)
          showToast(text: 'Updating Failed...try again', state: ToastState.error);
      },
      builder: (context,state){
        var subject_list_controler=ScrollController();
        Profiles_cubit profile_cubit = Profiles_cubit.get(context);
        teacher_profile_model? teacher_model=profile_cubit.teacher_model;
        TeacherInfo ?info=teacher_model?.data?.teacherInfo;
        List<Subjects> ?subject=teacher_model?.data?.subjects;
        var img;
        if(info!=null){
          name.text  =info.name.toString();
          email.text =info.email.toString();
          Gender.text=info.gender.toString();
          Salary.text=info.salary.toString();
          Number.text=info.phoneNumber.toString();
          img=info.img;
        }
        return ConditionalBuilder(
            condition: teacher_model != null,
            builder: (context)=>SingleChildScrollView(
              child: Container(
                  width: width,height: height,color: basic_background,
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width/50,vertical: width/30),
                            child: Container(
                              height: height/1.2,width: width/1.3,
                              decoration: CircularBorder_decoration.copyWith(borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                padding: EdgeInsets.only(top: height/15,),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(left: width/70),
                                      child: identity_row(context: context,width: width, img: null,Gender: info!.gender.toString(),
                                          cubit_object: profile_cubit,name_controller: name,email_controller: email,is_tech: true,
                                      submit_teacher_button: (){
                                        profile_cubit.update_teacher(
                                            id: info.id!,
                                            name: name.text.toString(),
                                            gender: Gender.text.toString(),
                                            email: (email.text==info.email.toString())?'a@gmail.com':email.text.toString(),
                                            salary: Salary.text.toString()).then((value) => profile_cubit.get_Teacher_profile(teacher_id: info.id!));
                                      }
                                      ),
                                    ),
                                    SizedBox(height: height/10,),
                                    Padding(
                                      padding: EdgeInsets.only(left: width/30),
                                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Deatils_row(context: context,width:width,text: 'Gender', controller: Gender),
                                              Deatils_row(context: context,width:width,text: 'Number', controller: Number),
                                              Deatils_row(context: context,width:width,text: 'Salary', controller: Salary,),
                                            ],),
                                          SizedBox(width: width/25,),
                                          subject_listview(width: width,teacher_model: teacher_model,subject_list_controler: subject_list_controler)
                                        ],),
                                    )  ],),),
                            ),),
                          /*
                          Padding(
                            padding:  EdgeInsets.only(left: width/200,top: width/30),
                            child: Add_Remove(width: width, label: 'Subject', tip: 'To Add or remove subject to teacher Just write its name'
                                ' then click on button',
                                controller: Subject, keyboardtype:TextInputType.text , format: [], hintText: 'Subject name',context: context,
                                icon: Icons.library_books_rounded, Add_method: (){}, Remove_method: (){}),
                          )*/
                        ],),
                          Padding(padding:  EdgeInsets.only(left: width/2,top: height/2.5),
                            child: Lottie.asset('assets/images/teaher.json',height: height/1.8,width:width/2, fit: BoxFit.fill,
                        ),),
                    ],
                  )
              ),),
            fallback: (context)=>Center(child: Lottie.asset('assets/images/teacher_profile.json', fit: BoxFit.fill,)));
      },
    ),
  );}}





