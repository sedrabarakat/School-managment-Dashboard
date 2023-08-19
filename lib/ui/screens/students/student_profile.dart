import 'dart:js_interop';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:school_dashboard/ui/screens/teachers/teacher_profile.dart';
import 'package:school_dashboard/ui/widgets/profiles_widget.dart';
import 'package:school_dashboard/ui/widgets/students/students_list_widgets.dart';
import '../../../constants.dart';
import '../../../cubit/profile/Profiles_cubit.dart';
import '../../../cubit/profile/student_profile_states.dart';
import '../../../models/student_profile_model.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../components/components.dart';

class Student_profile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var name=TextEditingController();
    var email=TextEditingController();
    var age=TextEditingController();
    var Gender=TextEditingController();
    var Address=TextEditingController();
    var Number=TextEditingController();
    var Class=TextEditingController();
    var Section=TextEditingController();
    var Installment=TextEditingController();
    var Bus_Installment=TextEditingController();
    var Mark_rate=TextEditingController();
    var img;
    int Presence=85;
    int Absence=15;
    double width  =  MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context)=>Profiles_cubit()..get_Student_profile(student_id: Student_id!.toInt()),
      child: BlocConsumer<Profiles_cubit,Profiles_states>(
        listener: (context,state){
          if(state is Success_update_student_profile)
            showToast(text: 'Successfully updated', state: ToastState.success);
          if(state is Error_update_student_profile)
            showToast(text: 'Updating Failed...try again', state: ToastState.error);
        },
        builder: (context,state){
          Profiles_cubit profile_cubit = Profiles_cubit.get(context);
          Student_profile_model ?student_profile_model=profile_cubit.student_profile_model;
          var data=profile_cubit.student_profile_model?.data;
          StudentData? studentData=student_profile_model?.data?.studentData;
          if(data.isNull!=true){
            name.text=studentData!.name.toString();
            email.text=studentData.email.toString();

            age.text=studentData.birthDate.toString();
            Gender.text=studentData.gender.toString();
            Address.text=studentData.address.toString();
            Number.text=studentData.phoneNumber.toString();
            Installment.text=studentData.leftForQusat.toString();
            Bus_Installment.text=studentData.leftForBus.toString();

            Class.text=studentData.grade.toString();
            Section.text=studentData.sectionNumber.toString();
            Mark_rate.text=data!.marksRate.toString();
            Absence=data.absenceRate!;
            Presence=100-Absence;
            img=studentData.img;
          }
          return ConditionalBuilder(
              condition: !data.isNull,
              builder: (context)=>SingleChildScrollView(
                child: Container(
                    height: height,width: width,
                    color: basic_background,
                    child: Padding(
                      padding:  EdgeInsets.only(left:width/30,right:width/30 ,top:height/20 ,bottom:height/8 ),
                      child: Container(
                          height: height/3,
                          decoration: CircularBorder_decoration.copyWith(borderRadius: BorderRadius.circular(30)),
                          child:Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: height/15,left: width/30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    identity_row(width: width, img: img,context: context,Gender: studentData!.gender.toString(),
                                        cubit_object: profile_cubit,name_controller: name,email_controller: email,
                                    submit_teacher_button: (){}),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: height/15,),
                                            Deatils_row(context: context,width:width,text: 'age', controller: age),
                                            Deatils_row(context: context,width:width,text: 'Gender', controller: Gender),
                                            Deatils_row(context: context,width:width,text: 'Address', controller: Address),
                                            Deatils_row(context: context,width:width,text: 'Number', controller: Number),
                                            Deatils_row(context: context,width:width,text: 'Installment', controller: Installment),
                                            Deatils_row(context: context,width:width,text: 'Bus Installment', controller: Bus_Installment),
                                          ],),
                                        SizedBox(width: width/25,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Deatils_row(context: context,width:width,text: 'Class', controller: Class,spacing: width/100,
                                            Not_editable: true,justread:true
                                            ),
                                            Deatils_row(context: context,width:width,text: 'Section', controller: Section,spacing: width/100,
                                                Not_editable: true,justread:true),
                                            Deatils_row(context: context,width:width,text: 'Mark Rate', controller: Mark_rate,spacing: width/100,
                                                Not_editable: true,justread:true),
                                            SizedBox(height: height/10,),
                                          ],),
                                      ],)  ],),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(padding:  EdgeInsets.only(top: width/50,left:width/6 ),
                                      child: Edit_buttons_row(context: context,width: width,cubit_object: profile_cubit,teaching: false,
                                      submit_button: (){
                                        profile_cubit.update_student(id: studentData.id!, name: name.text.toString(), birth_date: age.text.toString(),
                                            gender: Gender.text.toString(),
                                            email: (email.text==studentData.email.toString())?'a@gmail.com':email.text.toString()

                                            , address: Address.text.toString(), phone_number: Number.text.toString(),
                                            left_for_qusat: Installment.text.toString(), is_in_bus: '1', left_for_bus: Bus_Installment.text.toString()).
                                        then((value) => profile_cubit.get_Student_profile(student_id:  studentData.id!));
                                      }
                                      
                                      )),
                                  Padding(padding: EdgeInsets.only(top: height/6,left: width/50),
                                    child: Presence_Absence_chart(height: height, width: width, presence: Presence+0.0, absence: Absence+0.0),)
                                ],)
                            ],)
                      ),)
                ),),
              fallback: (context)=> Center(child: Lottie.asset('assets/images/teacher_profile.json', fit: BoxFit.fill,))
          );},
      ),
    );
  }}


