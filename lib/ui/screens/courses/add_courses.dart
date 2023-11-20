import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_dashboard/cubit/courses/course_cubit.dart';
import 'package:school_dashboard/cubit/courses/course_state.dart';
import 'package:school_dashboard/ui/components/components.dart';
import 'package:school_dashboard/ui/widgets/class_widgets.dart';

import '../../../constants.dart';

import '../../../theme/styles.dart';

class Add_Courses extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var body_controller=TextEditingController();
    var Num_controller=TextEditingController();
    var price_controller=TextEditingController();
    var Date_controller=TextEditingController();
    var validation_key=GlobalKey<FormState>();

    return BlocConsumer<Courses_cubit,Courses_State>(
        listener: (context,state){
          if(state is Success_Create_Session)
            showToast(text: 'Successfully Added', state: ToastState.success);
          if(state is Error_Create_Session)
            showToast(text: 'Cannot Add that session...Try Again', state: ToastState.success);
        },
        builder: (context,state){
          Courses_cubit cubit=Courses_cubit.get(context);
          //List<dynamic>teacher_List=cubit.teacher_for_session['data'];
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height/10,horizontal: width/15),
                child: Container(
                    height: height/1.3,width: width,
                    decoration: CircularBorder_decoration.copyWith(borderRadius: BorderRadius.circular(30),
                        boxShadow: [light_blue_shadow]),
                    child: ConditionalBuilder(
                      condition: cubit.teacher_for_session.length>0,
                      builder: (context)=>Padding(
                          padding: EdgeInsets.only(left: width/20,top: height/15),
                          child: Form(
                            key: validation_key,
                            child: Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Animated_Text(width: width, text: 'Add Course'),
                                  SizedBox(height: height/20,),
                                  Text('Session description',style: email_TextStyle(width: width)),
                                  SizedBox(height: height/60,),
                                  SizedBox(
                                    width: width/5,
                                    child: default_TextFromField(
                                        maxLines: 2,
                                        is_there_prefix: true,
                                        prefixicon: Icons.description,
                                        width: width/10,
                                        controller: body_controller,
                                        keyboardtype: TextInputType.text,
                                        hintText: 'Session description '),
                                  ),

                                  SizedBox(height: height/30,),

                                  Text('Student Number',style: email_TextStyle(width: width)),
                                  SizedBox(height: height/60,),
                                  SizedBox(
                                    width: width/5,
                                    child: default_TextFromField(
                                        is_there_prefix: true,
                                        prefixicon: Icons.people_outline_rounded,
                                        width: width/10,
                                        controller: Num_controller,
                                        keyboardtype: TextInputType.number,
                                        inputformater: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        hintText: 'Student Number'),
                                  ),

                                  SizedBox(height: height/30,),

                                  Text('Session Price',style: email_TextStyle(width: width)),
                                  SizedBox(height: height/60,),
                                  SizedBox(
                                    width: width/5,
                                    child: default_TextFromField(
                                        is_there_prefix: true,
                                        prefixicon: Icons.price_change,
                                        width: width/10,
                                        controller: price_controller,
                                        inputformater: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardtype: TextInputType.number,
                                        hintText: 'Session Price'),
                                  ),

                                  SizedBox(height: height/30),

                                  Text('Session Date',style: email_TextStyle(width: width)),
                                  SizedBox(height: height/60,),
                                  SizedBox(
                                    width: width/5,
                                    child: default_TextFromField(
                                        tap: (){
                                          showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now().add(Duration(days: 1)),
                                              firstDate: DateTime.now().add(Duration(days: 1)),
                                              lastDate: DateTime(2090)).then((value){
                                            if(value!=null){
                                              Date_controller.text=DateFormat('yyyy-M-dd').format(value).toString();
                                              print(DateFormat('yyyy-M-dd').format(value));
                                            }
                                          });

                                        },
                                        is_there_prefix: true,
                                        prefixicon: Icons.date_range,
                                        width: width/10,
                                        controller: Date_controller,
                                        keyboardtype: TextInputType.none,
                                        hintText: 'Session Date'),
                                  ),

                                ],
                              ),
                              Padding(
                                padding:  EdgeInsets.only(
                                    top: height/11,left: width/8
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Session Teacher',style: email_TextStyle(width: width)),
                                    SizedBox(height: height/60,),
                                    if(cubit.teacher_for_session.length>0)
                                      drop_Teacher_for_session(
                                          is_techer_drop: true,
                                          context: context,
                                          last: cubit.teacher_for_session['data'],
                                          height: height, width: width*1.5),
                                    SizedBox(height: height/30),
                                    ConditionalBuilder(
                                        condition: cubit.subject_for_session.length>0,
                                        builder: (context)=>Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Session Subject',style: email_TextStyle(width: width)),
                                            SizedBox(height: height/60,),
                                            drop_Teacher_for_session(

                                                context: context,
                                                last: cubit.subject_for_session['data'],
                                                height: height, width: width*1.5, is_techer_drop: false)
                                          ],),
                                        fallback: (context)=>SizedBox())


                                  ],),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(
                                    left:width/20,
                                    top: height/2
                                ),
                                child: elevatedbutton(
                                    Function: (){
                                      if(validation_key.currentState!.validate()){
                                        cubit.create_Session(
                                            body: body_controller.text,
                                            subjects_has_teacher_id: subjects_has_teacher_id!,
                                            counter: int.parse(Num_controller.text),
                                            price: int.parse(price_controller.text),
                                            date: Date_controller.text);
                                      }
                                    },
                                    widthSize: width/16,
                                    heightSize: height/20,
                                    text: 'Add Session'),
                              )
                            ],),
                          )
                      ),
                      fallback: (context)=>SizedBox(),
                    )
                ),),),
          );
        });
  }
}

int ?subjects_has_teacher_id;
Widget drop_Teacher_for_session({
  required context,
  required List<dynamic> last,
  required double height,
  required double width,
  required bool is_techer_drop
}){
  return Container(
    padding: EdgeInsets.symmetric(vertical: height/150),
    width: width/8,height: height/18,
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(),
    child: DropdownButtonFormField2(
      decoration: drop_decoration(),
      isExpanded: true,
      hint:Text(
        'Choose Teacher',
        style: TextStyle(fontSize: width/150,color: Colors.black54),
      ),
      items:Teacher_item(available_list: last),
      validator: (value) {
        if (value == null) {
          return 'Please select Grade';
        }
        return null;
      },
      onChanged: (value){
       print(value);
       if(value!=null){
         if(is_techer_drop){
           Courses_cubit.get(context).get_Subjects_Teacher(id: int.parse(value));
         }
         else {
           subjects_has_teacher_id=int.parse(value);
         }
       }
      },
      onSaved: (value) {},
      buttonStyleData: drop_button_style(width: width),
      iconStyleData:  drop_icon_style(size: 0),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),),
    ),
  );
}

List<DropdownMenuItem<String>> Teacher_item({
  required List available_list,
}) {
  final List<DropdownMenuItem<String>> menuItems = [];
  for(int i=0;i<available_list.length;i++)
  {
    menuItems.addAll( [
      DropdownMenuItem<String>(
        value: '${available_list[i]['id']}',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Teacher : ${available_list[i]['name']}',
            style: const TextStyle(
              fontSize: 14,
            ),),
        ),
      ),
    ]);
  }
  return menuItems;
}