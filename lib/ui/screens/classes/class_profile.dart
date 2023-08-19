import 'dart:js_interop';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:school_dashboard/cubit/class_profile/marks_cubit.dart';
import 'package:school_dashboard/cubit/classes/classes_list_cubit.dart';
import 'package:school_dashboard/cubit/home/home_cubit.dart';
import 'package:school_dashboard/models/class_profile_model.dart';
import '../../../constants.dart';
import '../../../cubit/basic/basic_cubit.dart';
import '../../../cubit/class_profile/class_profile_cubit.dart';
import '../../../cubit/class_profile/class_profile_states.dart';
import '../../../theme/colors.dart';
import '../../../theme/styles.dart';
import '../../components/components.dart';
import '../../widgets/class_widgets.dart';
import '../../widgets/classes/classes_list_widgets.dart';
class Class_Profile extends StatelessWidget{
  var subjectcontroller=TextEditingController();
  var gradecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width  =  MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context)=>Class_Profile_cubit()..get_class_profile(class_id: class_id!.toInt()),
      child: BlocConsumer<Class_Profile_cubit,Class_Profile_States>(
        listener:(context,state){
          if(state is Success_Add_Subject_States){showToast(text: 'Added Successfully', state: ToastState.success);ClassesListCubit.get(context).getClassesTableData();}

          if(state is Error_Add_Subject_States){showToast(text: 'Error in Adding...Try Again later', state: ToastState.error);}

          if(state is Success_delete_subject_State){showToast(text: 'Deleted Successfully', state: ToastState.success);ClassesListCubit.get(context).getClassesTableData();}

          if(state is Error_delete_subject_State){showToast(text: 'Error in Deleting', state: ToastState.success);}

          if(state is Success_Add_Section_States){showToast(text: 'Added Successfully', state: ToastState.success);ClassesListCubit.get(context).getClassesTableData();}

          if(state is Error_Add_Section_States){showToast(text: 'Error in Adding...Try Again later', state: ToastState.error);}

          if(state is Success_delete_section_State){showToast(text: 'Deleted Successfully', state: ToastState.success);ClassesListCubit.get(context).getClassesTableData();}

          if(state is Error_delete_section_State){showToast(text: 'Error in deleting...Try Again later', state: ToastState.error);}

          if(state is Success_Add_exam_photo){showToast(text: 'Successfully Add The Exam Schedule', state: ToastState.success);ClassesListCubit.get(context).getClassesTableData();}

          if(state is Error_Add_exam_photo){showToast(text: 'Error in Adding...Try Again later', state: ToastState.error);}

          if(state is Success_Update_program_State){showToast(text: 'Successfully Added', state: ToastState.success);ClassesListCubit.get(context).getClassesTableData();}

          if(state is Error_Update_program_State){showToast(text: 'Failed...try afain', state: ToastState.error);}

          if(state is UploadExcelFileSuccessState){Navigator.pop(context); MarksCubit.get(context).cvsFile=null; showToast(text: state.marksModel.message!, state: ToastState.success);}

          if(state is UploadExcelFileErrorState){showToast(text: state.marksModel.message!, state: ToastState.error);}

        },
        builder: (context,states){
          Class_Profile_cubit cubit=Class_Profile_cubit.get(context);
          List<Subjects>? subject=cubit.class_profile?.data?.subjects;
          List<SectionsInClass>? sectionsInClass=cubit.class_profile?.data?.sectionsInClass;
          var stuNum=cubit.class_profile?.data?.pupilsInClass;
          return SingleChildScrollView(
            child: Container(
                height: height,width: width,color: basic_background,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: width/25,top: height/12),
                        child: Container(
                          height: height/1.25,width: width/2,clipBehavior: Clip.hardEdge,
                          padding: EdgeInsets.only(left: width/25,top: height/12,right:width/35 ),
                          decoration: CircularBorder_decoration.copyWith(borderRadius: BorderRadius.circular(60)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Row(children: [
                                    Animated_Text(text: "Class Profile",width: width,speed: 400),
                                    Expanded(
                                      flex: 5,
                                        child: SizedBox(width:width/3.8,)),
                                    Expanded(
                                      child: SizedBox(width: width/25,
                                          child: Text((stuNum.isNull)?'0':'${cubit.class_profile?.data?.pupilsInClass}',style: email_TextStyle(width: width*1.7),overflow: TextOverflow.ellipsis,)),
                                    )
                                  ],),
                                ),
                                SizedBox(height: height/20,),
                                Animated_Text(text: "Subjects",width: width*0.6,speed: 400,colors_list: [Colors.black54,Colors.black26,]),
                                SizedBox(height: height/30,),
                                ConditionalBuilder(
                                    condition: subject?.length!=null,
                                    builder: (context)=>Subject_listview(width:width,subjects: subject),
                                    fallback: (context)=>Subject_Loading_listview(width: width)),
                                SizedBox(height: height/15,),
                                Animated_Text(text: "Grades",width: width*0.6,speed: 400,colors_list: [Colors.black54,Colors.black26,]),
                                SizedBox(height: height/30,),
                                ConditionalBuilder(
                                    condition: sectionsInClass?.length!=null,
                                    builder: (context)=>Grade_listview(width: width,sectionsInClass: sectionsInClass,cubit: cubit),
                                    fallback: (context)=>Grade_Loading_listview(width: width))
                              ]),
                        ),),
                      Padding(
                        padding: EdgeInsets.only(left: width/50,top: height/12),
                        child: Stack(
                          children: [
                            Column(children: [
                              last_Add_Remove_Grade(width: width, context: context, gradecontroller: gradecontroller, cubit: cubit, id: class_id!.toInt()),
                              SizedBox(height: height/30,),
                              last_Add_Remove_Subject(width: width, context: context, subjectcontroller: subjectcontroller, cubit: cubit, id: class_id!.toInt())
                            ],),
                            Padding(
                              padding:  EdgeInsets.only(left: width/6.6,top: height/7.2),
                              child: Lottie.asset('assets/images/teaching.json',height: height/3,width:width/6.5 , fit: BoxFit.fill,
                              ),),
                            Padding(
                              padding:  EdgeInsets.only(top: height/2.1,right: width/7,bottom: height/10),
                              child: Lottie.asset('assets/images/book.json', fit: BoxFit.cover,height: height/1.2,width: width/7
                              ),),
                          ],),
                      )
                    ])
            ),
          );
        },
      ),
    );
  }}








/*Lottie.asset('assets/images/class.json',height: height/5,width: width/3.5,fit: BoxFit.fill,
                                 repeat: false)*/


