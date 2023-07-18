import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/ui/widgets/students/students_list_widgets.dart';
import 'package:school_dashboard/ui/widgets/teachers/teachers_list_widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../constants.dart';
import '../../cubit/profile/Profiles_cubit.dart';
import '../../models/teacher_profile_model.dart';
import '../components/components.dart';
import 'class_widgets.dart';
import 'dashboard_widgets.dart';


Widget Deatils_row({
  required BuildContext context,
  required double width,
  required String text,
  required TextEditingController controller,
  double? spacing,
}){
  bool is_editing=Profiles_cubit.get(context).is_editing;
  return Padding(
    padding: EdgeInsets.only(bottom: height/200),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            width: width/10,
            child: Text("$text :",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: width/90),)),
        SizedBox(width:(spacing!=null)?spacing:width/30),
        Container(width: width/10,
          child: default_TextFromField(
              width: width,
              controller: controller,
              keyboardtype: TextInputType.text,
              hintText: text,
              is_there_border: is_editing,
              fill: is_editing,
              is_there_prefix: false,
              justread: !is_editing
          ),
        )
      ],),
  );
}

Widget Presence_Absence_chart({
  required double height,
  required double width,
  required double presence,
  required double absence,
}){
  return Container(
    height: height/2.4,width: width/5,
    child:  SfCircularChart(
        legend: Legend(isVisible: true),
        series: PieList(Presence: presence,Absence: absence)),
  );}

List<PieSeries>PieList({
  required double Presence,
  required double Absence,
}){
  return <PieSeries>[
    PieSeries<ChartData, String>(
        strokeColor:Colors.white,
        explode:true,
        explodeAll:true,
        dataSource: <ChartData>[
          ChartData('Absence', Absence,Colors.amberAccent),
          ChartData('Presence', Presence,Colors.lightBlueAccent),
        ],
        pointColorMapper: (ChartData data, _) => data.color,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        legendIconType:LegendIconType.pentagon,
        dataLabelSettings:const DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.inside,
        ),
        animationDuration: 1500
    )
  ];
}

Widget Edit_buttons_row({
  required BuildContext context,
  required double width,
  required Profiles_cubit cubit_object,
  required teaching,
}){
  bool is_editing=Profiles_cubit.get(context).is_editing;
  return Row(
    children: [
      circle_icon_button(button_Function: (){
        (teaching)?cubit_object.get_Teacher_profile(teacher_id: Teacher_id!.toInt()):cubit_object.get_Student_profile(student_id: Student_id!.toInt());
      }, icon: Icons.refresh,hint_message: 'refresh'),
      SizedBox(width: width/200,),
      circle_icon_button(button_Function: (){
        cubit_object.edit_toggle();
      }, icon: Icons.edit,hint_message: 'edit'),
      SizedBox(width: width/200,),
      (is_editing)?Row(children: [
        circle_icon_button(button_Function: (){}, icon: Icons.check,icon_color:Colors.green.shade500,
            hint_message: 'Submit'),
        SizedBox(width: width/200,),
        circle_icon_button(button_Function: (){
          cubit_object.close_edit();
        }, icon: Icons.close,icon_color:Colors.red.shade700,hint_message: 'close' ),
      ],):SizedBox(),
    ],
  );
}

Widget identity_row({
  required BuildContext context,
  required double width,
  required var img,
  required TextEditingController name_controller,
  required TextEditingController email_controller,
  required Profiles_cubit cubit_object,
  required String Gender,
  bool is_tech=false
}){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CircleAvatar(backgroundColor:Colors.white,
        child: Center(
          child: IconButton(icon: Icon(Icons.arrow_back_ios_sharp,),
            onPressed: (){
              (is_tech)?Basic_Cubit.get(context).change_Route("/teachers_list"):Basic_Cubit.get(context).change_Route("/students_list");
            },),
        ),),
      (img!=null)?image_container(
          container_width: width/7,
          container_height: height/5, imageUrl: img):(Gender=='Female')?
          Default_image(
          container_width:  width/7,
          container_height: height/5,
          pic_path: 'assets/images/girl.png'):
          Default_image(
          container_width:  width/7,
          container_height: height/5,
          pic_path: 'assets/images/boy.png'),
      SizedBox(width: width/40),
      Padding(
        padding:  EdgeInsets.only(top: height/25,),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: width/5.5,
              child: default_TextFromField(
                  width: width,keyboardtype: TextInputType.text,hintText: '',
                  controller: name_controller,
                  is_there_border: false, fill: false, is_there_prefix: false,
                  justread: !cubit_object.is_editing,
                  is_basic_name: true
              ),
            ),
            Container(width: width/4.5,
              child: default_TextFromField(
                  width: width,keyboardtype: TextInputType.text,hintText: '',
                  controller: email_controller,
                  is_there_border: false, fill: false, is_there_prefix: false,
                  justread: !cubit_object.is_editing,
                  is_email: true),
            ),
          ],),
      ),
      (is_tech)?Expanded(child: Edit_buttons_row(context: context,width: width,cubit_object: cubit_object,teaching: is_tech)):SizedBox()
    ],);
}
// padding:  EdgeInsets.only(top: height/35,),

Widget subject_listview({
  required double width,
  var subject_list_controler,
  teacher_profile_model? teacher_model,
}){
  var Subject=teacher_model?.data?.subjects;
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Subject :',style:TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: width/90),),
      Padding(
        padding: EdgeInsets.symmetric(vertical:height/120,horizontal:width/40  ),
        child: SizedBox(height: height/3,width: width/8.2,
          child: ListView.separated(
              dragStartBehavior: DragStartBehavior.down,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              controller: subject_list_controler,
              scrollDirection:Axis.vertical,
              itemBuilder: (context,index)=>subject_item(text: Subject?[index].name,width: width),
              separatorBuilder: (context,index)=>SizedBox(height: height/40,),
              itemCount: (Subject?.length!=null)?Subject!.length:0),
        ),
      )
    ],);
}

Widget subject_item({
   String? text,
  required double width
}){
  return Text('$text',style: TextStyle(
    fontWeight: FontWeight.w500,fontSize: width/100,color: Colors.black,
    overflow: TextOverflow.ellipsis,
  ),maxLines: 1,);
}
