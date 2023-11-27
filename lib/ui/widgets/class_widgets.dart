import 'dart:convert';
import 'dart:ui';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/cubit/class_profile/class_profile_states.dart';
import 'package:school_dashboard/cubit/class_profile/marks_cubit.dart';
import 'package:school_dashboard/theme/colors.dart';
import 'package:school_dashboard/ui/widgets/classes/classes_list_widgets.dart';
import '../../constants.dart';
import '../../cubit/class_profile/class_profile_cubit.dart';
import '../../cubit/classes/classes_list_cubit.dart';
import '../../models/class_profile_model.dart';
import '../../theme/styles.dart';
import '../components/components.dart';

List<dynamic>data=[];

Map<String,dynamic>update_map={};
List<String> days=[
  'sunday',
  'monday',
  'tuesday',
  'wednsday',
  'thursday'
];

void Add_class({
  required BuildContext context,
  required double height,
  required double width,
}){
  context.showModalFlash(
    builder: (context, controller) => RotationTransition(
      turns: controller.controller.drive(CurveTween(curve: Curves.linear)),
      child: Flash(
        controller: controller,
        dismissDirections: FlashDismissDirection.values,
        slideAnimationCreator: (context, position, parent, curve, reverseCurve){
          return controller.controller.drive(Tween(begin: Offset(0.1, 0.1), end: Offset.zero));
        },
        child: Stack(
          children: [
            AlertDialog(
              contentPadding: EdgeInsets.only(left: 24.0, top: 16.0, right: 24.0, bottom: 16.0),
              title: Animated_Text(text: "Classes",width: width/1.2,speed: 400,),
              content: Container(
                  height: height/4,width: width/2.8,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('To Add class Just choose one and submit it',
                        style: TextStyle(
                            fontSize: 17,fontWeight: FontWeight.w400,color: Colors.black38
                        ),),
                      SizedBox(height: height/20,),
                      drop_add_class(context: context,height: height,width: width,)
                    ],)
              ),
              actions: [
                TextButton(
                  onPressed:() {
                    (ClassesListCubit.get(context).selected_class==null)?
                    showToast(text: 'Select a classs', state: ToastState.warning):ClassesListCubit.get(context).Add_Class(number: ClassesListCubit.get(context).selected_class!);
                    controller.dismiss();
                    ClassesListCubit.get(context).getClassesTableData();
                  },
                  child: Text('Add'),
                ),
                TextButton(
                  onPressed: controller.dismiss,
                  child: Text('Cancel'),
                ),
              ],
            ),
            Positioned(
              left: height/1.01,top: height/4,right: height/3,bottom: height/3,
              child: Lottie.asset('assets/images/employees.json',fit: BoxFit.fill,height: height/4),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget drop_add_class({
  required context,
  required double height,
  required double width,
}){
  return Container(
    width: width/6,
    child: DropdownButtonFormField2(
      decoration:drop_decoration(),
      isExpanded: false,
      hint:Text(
        'Choose Class',
        style: TextStyle(fontSize: width/110,color: Colors.black54),
      ),
      items: classes
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              fontSize: width/110,color: Colors.black
          ),),
      )).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select Grade';
        }
        return null;
      },
      onChanged: (value) {
        ClassesListCubit.get(context).select_class(Mapclasses['$value']);
        //print(Class_Profile_cubit.get(context).selected_class);
      },
      onSaved: (value) {
        ClassesListCubit.get(context).select_class(Mapclasses['$value']);
      },
      buttonStyleData: drop_button_style(width: width),
      iconStyleData:  drop_icon_style(size: 30),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),),
    ),
  );
}

///////////MultiSelectItem
List<MultiSelectItem<String>> convert({
  required List available_list,
  required String intended
}) {
  final List<MultiSelectItem<String>> menuItems = [];
  for(int i=0;i<available_list.length;i++)
  {
    menuItems.addAll( [
      MultiSelectItem('${available_list[i]['id']}', '${available_list[i]['$intended']}')
    ]);
  }
  return menuItems;
}

Future MultiSelect({
  required BuildContext context,
  required double width,
  required String title,
  required List<dynamic> items,
  required dynamic cubit,
  required String intended,
  required bool is_Section
}) async {
   await showAlignedDialog(
     avoidOverflow: true,
     followerAnchor : Alignment.topRight,
     context: context,
     builder: (ctx) {
       return  MultiSelectDialog(
         height: height/3,width: width/3.5,
         searchIcon: Icon(Icons.search,color: Colors.blue,),
         title: Text(title,style: Name_TextStyle(color: Colors.blue, width: width/1.2),),
         searchable: true,
         items:convert(available_list: items,intended:intended),
         initialValue:empty,
         onConfirm: (values) {
           List<Map<String, String>> list = values.map((String number) {
             return {'id': number};
           }).toList();
           (is_Section)?cubit.Delete_section(ids: list):cubit.Delete_Subject(ids: list);
         },
         onSelectionChanged: (value){
          print(value);
         },
         confirmText: Text('Delete',style: TextStyle(fontWeight: FontWeight.w500,
         fontSize: width/120
         ),),
         cancelText: Text('Cancel',style: TextStyle(fontWeight: FontWeight.w500,
             fontSize: width/120
         ),),
       );
     },
   );
}
Widget Add_Remove({
  required BuildContext context,
  required double width,
  required String label,
  required String tip,
  required TextEditingController controller,
  required TextInputType keyboardtype,
  required List<TextInputFormatter> format,
  required String hintText,
  required IconData icon,
  required VoidCallback Add_method,
  required VoidCallback Remove_method,
  double textField_padding=0,
  Color labelColor=Colors.lightBlue,
  Color tipColor=Colors.black38
}){
  return Container(
      height: height/2.6,width: width/3.7,
      padding: EdgeInsets.only(left: width/50,top: height/20,right:width/70 ),
      decoration: CircularBorder_decoration.copyWith(borderRadius: BorderRadius.circular(70)),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style: TextStyle(
              fontSize: 30,fontWeight: FontWeight.bold,color:labelColor
          ),),
          SizedBox(height: height/40,),
          Text(tip,style: TextStyle(
              fontSize: 17,fontWeight: FontWeight.w400,color: tipColor
          ),),
          SizedBox(height: height/20,),
          Padding(
            padding: EdgeInsets.only(left:textField_padding),// width/10
            child: SizedBox(width: width/7,
              child: default_TextFromField(
                width: width,
                controller: controller,
                keyboardtype: keyboardtype,
                inputformater: format,
                hintText: hintText,
                prefixicon: icon,
                is_there_suffix: true,
              ),),
          ),
          SizedBox(height: height/20,),
          Row(
            mainAxisAlignment: (textField_padding>0)?MainAxisAlignment.end:MainAxisAlignment.start,
            children: [
              SizedBox(width: width/22,),
              elevatedbutton(Function: Add_method,
                  widthSize: width/20,
                  heightSize: height/30,
                  text: 'Add'),
              SizedBox(width: width/80,),
              elevatedbutton(
                  Function: Remove_method,widthSize: width/18,heightSize: height/30,
                  text: 'Remove',backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white60)
            ],)

        ],)
  );
}


///////////////////subject_list
Widget Subject_listview({
  required double width,
   List<Subjects>? subjects
}){
  return SizedBox(height: height/8.5,
    child:  ListView.separated(
        padding: EdgeInsets.symmetric(vertical: height/70),
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)=>subject_item(height,width,subjects?[index].name),
        separatorBuilder: (context,index)=>SizedBox(width: width/80,),
        itemCount: (subjects?.length!=null)?subjects!.length:0),);
}

Widget Subject_Loading_listview({
  required double width,
}){
  return SizedBox(height: height/8.5,
    child:  ListView.separated(
        padding: EdgeInsets.symmetric(vertical: height/70),
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)=>subject_Loading_item(height,width),
        separatorBuilder: (context,index)=>SizedBox(width: width/80,),
        itemCount: 8),);
}

Widget subject_Loading_item(height,width){
  return Container(
      width: width/15,height: height/10,
      decoration:three_color_container(borderradius: 20,first_color: Colors.grey.shade300,
          sec_color: Colors.grey.shade200,third_color: Colors.grey.shade300,with_shadow: false)
  );
}

Widget subject_item(height,width,subject_name){
  return Container(
    clipBehavior: Clip.hardEdge,
    padding: EdgeInsets.symmetric(horizontal: width/150),
    width: width/15,height: height/10,
    decoration: three_color_container(borderradius: 20),
    child: Center(child: Text('${subject_name}',
      maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: width/80),)),);
}

////////////////

////////////////////Grades_list
Widget Grade_listview({
  required double width,
  List<SectionsInClass>? sectionsInClass,
  required Class_Profile_cubit cubit
}){
  return SizedBox(height: height/3.9,
   child:  ListView.separated(
       shrinkWrap: false,
       scrollDirection: Axis.horizontal,
       itemBuilder: (context,index)=>Grade_item(context,height,width,sectionsInClass?[index].number,sectionsInClass?[index].numberOfStudent,cubit,class_id,sectionsInClass?[index].number),
       separatorBuilder: (context,index)=>SizedBox(width: width/80,),
       itemCount: (sectionsInClass?.length!=null)?sectionsInClass!.length:0),);
}

Widget Grade_Loading_listview({
  required double width,
}){
  return SizedBox(height: height/3.9,
    child:  ListView.separated(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)=>Grade_Loading_item(width: width),
        separatorBuilder: (context,index)=>SizedBox(width: width/80,),
        itemCount: 4),);
}

Widget Grade_Loading_item({
  required double width
}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: width/150,vertical: height/50),
    width: width/6,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.grey.shade100
    ),
  );
}

Widget Grade_item(context,height,width,sectionNum,studentnum,cubit,saf_id,section_id){
  bool is_Loading=cubit.is_loading;
  return Container(
      padding: EdgeInsets.symmetric(horizontal: width/150,vertical: height/50),
      width: width/6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.grey.shade100
      ),
      child:Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('$sectionNum',maxLines: 1,overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.lightBlue,fontSize: width/80),),
              ),
              SizedBox(width: width/50,),
              SizedBox(height: height/40,),
              Text('Number of Student : $studentnum',
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
              SizedBox(height: height/40,),
              Expanded(
                child: Row(children: [
                  (is_Loading)?SizedBox(
                    width: width/15,
                      child: SpinKitWeb(width)):Adds_container(width:width,icon: Icons.calendar_month,text: 'Add Schedule',
                    ontap: ()async{
                      cubit.change_load();
                      print(saf_id);
                      print(section_id);
                      Class_Profile_cubit.get(context).get_Hessas(section_id: section_id);
                      Class_Profile_cubit.get(context).Get_Available_Teachers(saf_id: saf_id,section_id: section_id).then((value){
                        Add_class_schedule(context: context, height: height, width: width, Hessas_Map: cubit.Hessas_Map,cubit:cubit,saf_id: saf_id );
                      });
                    },),


                  SizedBox(width: width/80,),
                  Adds_container(width:width,icon: Icons.event_note_outlined,text: 'Add Grades',
                      ontap: (){
                        Add_class_Grades(context: context,cubit: cubit,height: height,width: width,saf_id: saf_id!.toInt(), section_id: section_id,);
                      })
                ],),
              )
            ],),
          Padding(
            padding:  EdgeInsets.only(left: width/8),
            child: circle_icon_button(button_Function: ()async{
              cubit.Exam_photo(section_id:section_id).then((value){
                cubit.Add_Exam_photo(section_id: section_id);
              });
            }, icon: Icons.file_open_rounded, hint_message: "Add Exam Schedule",
                backgroundColor:  Colors.grey.shade100),
          ),

        ],
      )
  );
}

//////////////
/* if(Class_Profile_cubit.get(context).available_list.length>0){
                Add_class_schedule(context: context, height: height, width: width, Hessas_Map: cubit.Hessas_Map,cubit:cubit,saf_id: saf_id );
               }
               else{
                Container(height: height/4,width: width/2,color: Colors.white,
                    child: Lottie.asset('assets/images/teaching.json',height: height/3,width:width/6.5 , fit: BoxFit.fill,
                    ),
                  );*/

Widget Adds_container({  //add_sch_grades
  required double width,
  required IconData icon,
  required String text,
  required VoidCallback ontap
}){
  return GestureDetector(
    onTap: ontap,
    child: Container(
      height: height/8.5,width: width/15,
      decoration: three_color_container(),
      child: Column(children: [
        SizedBox(height: height/50,),
        Icon(icon,color: Colors.white,size: 50,),
        SizedBox(height: height/70,),
        Text(text,style: TextStyle(color: Colors.white,fontWeight:FontWeight.w500,fontSize: width/170),),
      ],),),
  );
}

/////////////Add_class_schedule
void Add_class_schedule({
  required BuildContext context,
  required Class_Profile_cubit cubit,
  required int saf_id,
  required double height,
  required double width,
   Map<String,dynamic>?Hessas_Map,
}){
  context.showModalFlash(

    builder: (context, controller) => Flash(

      controller: controller,
      dismissDirections: FlashDismissDirection.values,
      slideAnimationCreator: (context, position, parent, curve, reverseCurve) {
        return controller.controller.drive(Tween(begin: Offset(0.1, 0.1), end: Offset.zero));
      },

      child:AlertDialog(
       backgroundColor: Colors.blueGrey.shade100,
        contentPadding: EdgeInsets.only(left: 24.0, top: 16.0, right: 24.0, bottom: 16.0),
        title: Padding(
          padding:  EdgeInsets.only(bottom: height/30,top: height/40,right: width/30),
          child: Animated_Text(text: "Add Class Schedule",width: width/1.2,speed: 400,),
        ),
        content: Container(//drop(context: context,height: height,width: width,)
            height: height/1.8,width: width/1.2,
            child: Row(
              children: [
                Column(children: [
                  days_container(width: width,day:'Sunday' ),
                  days_container(width: width,day:'Monday' ),
                  days_container(width: width,day:'Tuesday' ),
                  days_container(width: width,day:'Wednsday' ),
                  days_container(width: width,day:'Thursday' ),
                ],),
                Expanded(
                  child: AlignedGridView.count(
                    crossAxisCount: 7,itemCount: 34,
                    mainAxisSpacing: height/20,
                    crossAxisSpacing: width/90,
                    itemBuilder: (context, index) {
                      return
                        (index==27)?SizedBox():
                        (index==28)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][27],saf_id: saf_id,last: cubit.available_list[27]):
                        (index==29)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][28],saf_id: saf_id,last:cubit.available_list[28]):
                        (index==30)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][29],saf_id: saf_id,last:cubit.available_list[29]):
                        (index==31)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][30],saf_id: saf_id,last:cubit.available_list[30]):
                        (index==32)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][31],saf_id:saf_id,last:cubit.available_list[31] ):
                        (index==33)?drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][32],saf_id:saf_id,last:cubit.available_list[32] ):
                        drop_add_sch(context: context,height: height,width: width,item: Hessas_Map?['data'][index],saf_id: saf_id,last:cubit.available_list[index]);
                    },
                  ),
                ),
              ])
        ),
        actions: [
          TextButton(
            onPressed:(){
              update_map.addAll({
                "data":data
              });
              print(jsonEncode(update_map));
             cubit.Update_program(map: update_map);

              controller.dismiss();
            },
            child: Text('Add',style: TextStyle(color: Colors.black),),
          ),
          TextButton(
            onPressed: (){
              controller.dismiss();
              cubit.change_load();
            },
            child: Text('Cancel',style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
    ),
  ).then((value){
    cubit.change_load();
  });
}

void Loading_schedule({
  required BuildContext context,
  required double width,

}){
  context.showModalFlash(
    builder: (context, controller) => Flash(
      controller: controller,
      dismissDirections: FlashDismissDirection.values,
      slideAnimationCreator: (context, position, parent, curve, reverseCurve) {
        return controller.controller.drive(Tween(begin: Offset(0.1, 0.1), end: Offset.zero));
      },
      child:AlertDialog(
        contentPadding: EdgeInsets.only(left: 24.0, top: 16.0, right: 24.0, bottom: 16.0),
        title: Text(''),
        content:   Container(height:height/1.8,width: width/1.2,color: Colors.white,
          child: Lottie.asset('assets/images/teaching.json', fit: BoxFit.contain,
          )),
        actions: [],
      ),
    ),
  );}

Widget drop_add_sch({
  required context,
  required List<dynamic> last,
  required int saf_id,
  required double height,
  required double width,
  Map<String,dynamic> ?item,
}){
  return Container(
    width: width/8,
    child: DropdownButtonFormField2(
      decoration: drop_decoration(),
      isExpanded: true,
      hint:Text(//'${item?['day']} ,${item?['id']}
        'term ${item?['time']}',
        style: TextStyle(fontSize: width/110,color: Colors.black54),
      ),
      items:add_item(available_list: last),//add_item(available_list: last),
      validator: (value) {
        if (value == null) {
          return 'Please select Grade';
        }
        return null;
      },
      onChanged: (value) {
        if(value!=null){
          for(int i=0;i<data.length;i++){
            if(data[i]["id"]==item!['id']){
              data.removeAt(i);
            }
          }
          data.add({
            "id" : item!['id'],
            "teacher_subject_id" : value
          });
         // print('data is ${jsonEncode(data)}');
        }
      },
      onSaved: (value) {},
      buttonStyleData: drop_button_style(width: width),
      iconStyleData:  drop_icon_style(size: 0),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),),
    ),
  );
}

List<DropdownMenuItem<String>> add_item({
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
             '${available_list[i]['teacher_name']}  Subject: ${available_list[i]['subject_name']}',
             style: const TextStyle(
               fontSize: 14,
             ),),
         ),
       ),
     ]);
   }
  return menuItems;
}

Widget days_container({
  required double width,
  required String day,
}){
  return Padding(
    padding:  EdgeInsets.only(bottom: height/25,left: height/50,right: height/50),
    child: Container(
      height: height/16,
      width: width/15,
      decoration: three_color_container(borderradius: 15),
      child: Center(child: Text('$day',style:normal_TextStyle(width: width),)),
    ),
  );
} 
////////////////////////////end_schedule

Container default_TextFromField({
  required double width,
  required TextEditingController controller,
  required TextInputType keyboardtype,
  required String ?hintText,
  ValueChanged<String>?changed,
  ValueChanged<String>?submit,
  GestureTapCallback?tap,
  List <TextInputFormatter> ?inputformater,
  IconData ?prefixicon,
  Color prefixcolor=Colors.lightBlue,
  Color bordercolor=Colors.blue,
  Color fillColor=const Color.fromARGB(255, 239, 244, 249),
  double borderRadius=20,
  double borderWidth=2,
  bool fill=true,
  bool justread=false,
  bool is_there_border=true,
  bool is_there_prefix=true,
  bool is_email=false,
  bool is_basic_name=false,
  bool is_there_suffix=false,
  Widget ?suffix,
  Color suffixcolor=Colors.blue,
  String Error_Text='Please Fill That Field',
  int maxLines=1
}){
  return Container(height: height/18,
    child: TextFormField(
      style: (is_basic_name)?Name_TextStyle(width: width):(is_email)?email_TextStyle(width: width):TextStyle(),
      readOnly: justread,
      controller: controller,
      maxLines: maxLines,
      minLines: 1,
      keyboardType: keyboardtype,
      inputFormatters: inputformater,
      onChanged: changed,
      onFieldSubmitted: submit,
      onTap: tap,
      decoration: InputDecoration(
        hintText: hintText,
        filled: fill,
        prefixIcon: (is_there_prefix)?Icon(prefixicon,color: prefixcolor):null,
        fillColor:fillColor,
        border: (is_there_border)?OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:BorderSide(color: bordercolor,)
        ):InputBorder.none,
        enabledBorder: (is_there_border)?OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide:BorderSide(color: bordercolor,width:borderWidth)
        ):InputBorder.none,
      errorBorder: OutlineInputBorder(
        gapPadding: 8,
        borderRadius: BorderRadius.circular(borderRadius),
          borderSide:BorderSide(color: Colors.red.shade700,width:borderWidth)
      ),
      suffix: (is_there_suffix)?suffix:null
      ),
      validator: (value){
        if(value==null||value.isEmpty) {
          return Error_Text;}
        else
          return null;
      },
    ),
  );
}
////////////

/////latest_containers_finallly
Widget last_Add_Remove_Grade({
  required double width,
  required BuildContext context,
  required TextEditingController gradecontroller,
  required Class_Profile_cubit cubit,
  required int id
}){
  return  Add_Remove(width: width, label: 'Section',context: context,
      tip: 'To Add Grade to that class Just enter a Section number here and submit it',
      controller: gradecontroller,
      keyboardtype: TextInputType.number,
      format: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly],
      hintText: 'Section Number', icon: Icons.group_rounded,
      Add_method: (){
        cubit.Add_Sections(class_id: id.toString(), class_number: int.parse(gradecontroller.text)).then((value){
          cubit.get_class_profile(class_id: id);
          gradecontroller.clear();
          ClassesListCubit.get(context).getClassesTableData();
        });
      }, Remove_method: (){
        MultiSelect(context: context,width: width,title: 'Select Section to Delete',cubit: cubit,intended: 'number',
            items: cubit.sectionsInClass,
            is_Section: true
        ).then((value){
          cubit.get_class_profile(class_id: id);
          gradecontroller.clear();
          ClassesListCubit.get(context).getClassesTableData();
        });
        //cubit.Get_Available_Teachers(saf_id: 1, section_id: 1,);
      });
}

Widget last_Add_Remove_Subject({
  required double width,
  required BuildContext context,
  required TextEditingController subjectcontroller,
  required Class_Profile_cubit cubit,
  required int id
}){
  return Add_Remove(
      width: width, label: 'Subject',context: context,
      tip: 'To Add or Remove Subject to that class Just Write Subject name here and submit it',
      controller: subjectcontroller, keyboardtype: TextInputType.number,
      format:  <TextInputFormatter>[],
      hintText: 'Subject Name', icon: Icons.library_books,
      Add_method: (){
        cubit.Add_subject(name: subjectcontroller.text, saf_id: id).then((value){
          cubit.get_class_profile(class_id: id);
          subjectcontroller.clear();
          ClassesListCubit.get(context).getClassesTableData();
        });
      }, Remove_method: (){
    MultiSelect(context: context,width: width,title: 'Select Grade to Delete',cubit: cubit,intended: 'name',
        is_Section: false,
        items: cubit.subjects)..then((value){
      cubit.get_class_profile(class_id: id);
      subjectcontroller.clear();
      ClassesListCubit.get(context).getClassesTableData();
    });
  },
      textField_padding:width/10);
}
////////////////////////////////



/*Widget button_container({
  required double width,
  required String day,
  required Class_Profile_cubit cubit,
  required int saf_id,
  Map<String,dynamic> ?item,
}){
  return elevatedbutton(
      Function: ()async{
        await cubit.Get_Available_Teachers(saf_id: saf_id, section_id: 1).then((value){
          print(cubit.available_list);
        });
      },
      widthSize:  width/15,
      heightSize: height/16,
      text: 'choose',borderRadius: 15,backgroundColor: Colors.white,textcolor: blue);
}*/
////////////////////////////////Grades


void Add_class_Grades({
  required BuildContext context,
  required Class_Profile_cubit cubit,
  required int saf_id,
  required int section_id,
  required double height,
  required double width,
}){
  context.showModalFlash(
    builder: (context, controller) => Flash(
      controller: controller,
      dismissDirections: FlashDismissDirection.values,
      slideAnimationCreator: (context, position, parent, curve, reverseCurve) {
        return controller.controller.drive(Tween(begin: Offset(0.1, 0.1), end: Offset.zero));
      },
      child:BlocBuilder<MarksCubit, MarksState>(
  builder: (context, state) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey.shade100,
        title: Padding(
          padding:  EdgeInsets.only(bottom: height/30,top: height/40,right: width/30),
          child: Animated_Text(text: "Add Class Grades",width: width/1.2,speed: 400,),
        ),
        content: BlocBuilder<MarksCubit, MarksState>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.015, vertical: height * 0.01),
                  child: SingleChildScrollView(
                    child: Container(
                      height: height * 0.62,
                      width: width * 0.58,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Export',
                                    style: TextStyle(
                                        fontSize: width * 0.02,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Icon(
                                    Icons.download,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height / 30,
                              ),
                              const Text(
                                'Choose Exam Type',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black38),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              drop_add_exam_type(
                                  context: context,
                                  height: height,
                                  width: width),
                              SizedBox(
                                height: height / 8,
                              ),
                              const Text(
                                'Choose Subject',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black38),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              drop_add_subject(
                                  context: context,
                                  height: height,
                                  width: width,
                                  cubit: cubit),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.12,
                          ),
                          Container(
                            height: height * 0.68,
                            width: width * 0.0005,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: width * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Import',
                                    style: TextStyle(
                                        fontSize: width * 0.02,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Icon(
                                    Icons.upload,
                                    size: 25,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.045,
                              ),
                              const Text(
                                'Upload Excel File',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black38),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              MarksCubit.get(context).cvsFile == null
                                  ? Container(
                                height: height * 0.25,
                                width: width * 0.18,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  border:
                                  Border.all(color: Colors.blue),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.blueAccent,
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    onTap: () {
                                      MarksCubit.get(context)
                                          .pickCvsFile();
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.file_upload_outlined,
                                          size: 40,
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        Text(
                                          'No Such a file',
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                                  : Container(
                                height: height * 0.25,
                                width: width * 0.18,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  border:
                                  Border.all(color: Colors.green),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      MarksCubit.get(context)
                                          .pickCvsFile();
                                    },
                                    splashColor: Colors.blueAccent,
                                    borderRadius:
                                    BorderRadius.circular(10),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/Microsoft_Excel_2013-2019_logo.svg.png',
                                          width: width * 0.1,
                                          height: height * 0.15,
                                        ),
                                        Text(
                                          'marks.xlsx',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: width * 0.01),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        actions: [
          TextButton(
            onPressed: () {
              var cubitMark = MarksCubit.get(context);
              var selectedSubject = cubitMark.selected_subject;
              var selected_exam_type = cubitMark.selected_exam_type;

              if (selected_exam_type != null && selectedSubject != null && section_id != null) {
                cubitMark.downloadCvs(
                  grade: saf_id,
                  subjectName: selectedSubject,
                  sectionNumber: section_id.toString(),
                  examType: selected_exam_type,
                );
              }

            },
            child: Text(
              'Export',
              style: TextStyle(
                color: Colors.black,
                  fontWeight: FontWeight.w400, fontSize: width * 0.01),
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          TextButton(
            onPressed: () {

              var cubitMark = MarksCubit.get(context);
              var cvsFile = cubitMark.cvsFile;
              var filename = cubitMark.cvsFileName;

              if (cvsFile != null) {
                cubit.uploadFile(cvsFile: cvsFile,filename: filename!);
              }
            },
            child: Text(
              'Import',
              style: TextStyle(
                color: Colors.black,
                  fontWeight: FontWeight.w400, fontSize: width * 0.01),
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          TextButton(
            onPressed: () {
              controller.dismiss();
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
                  fontWeight: FontWeight.w400, fontSize: width * 0.01),
            ),
          ),
        ],
      );
  },
),
    ),
  );}

Widget drop_add_section({
  required context,
  required double height,
  required double width,
  required Class_Profile_cubit cubit,
}){
  return Container(
    width: width/6,
    child: DropdownButtonFormField2(
      decoration:drop_decoration(),
      isExpanded: false,
      hint:Text(
        'Choose Section',
        style: TextStyle(fontSize: width/110,color: Colors.black54),
      ),
      items: cubit.sectionNumbers
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              fontSize: width/110,color: Colors.black
          ),),
      )).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select Section';
        }
        return null;
      },
      onChanged: (value) {
        MarksCubit.get(context).select_section(value);
        print(MarksCubit.get(context).selected_section);
      },
      onSaved: (value) {
        MarksCubit.get(context).select_section(value);
      },
      buttonStyleData: drop_button_style(width: width),
      iconStyleData:  drop_icon_style(size: 30),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),),
    ),
  );
}

Widget drop_add_subject({
  required context,
  required double height,
  required double width,
  required Class_Profile_cubit cubit
}){
  return Container(
    width: width/6,
    child: DropdownButtonFormField2(
      decoration:drop_decoration(),
      isExpanded: false,
      hint:Text(
        'Choose Subject',
        style: TextStyle(fontSize: width/110,color: Colors.black54),
      ),
      items: cubit.subjectNames
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              fontSize: width/110,color: Colors.black
          ),),
      )).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select Subject';
        }
        return null;
      },
      onChanged: (value) {
        MarksCubit.get(context).select_subject(value);
        print(MarksCubit.get(context).selected_subject);
      },
      onSaved: (value) {
        MarksCubit.get(context).select_subject(value);
        },
      buttonStyleData: drop_button_style(width: width),
      iconStyleData:  drop_icon_style(size: 30),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),),
    ),
  );
}

Widget drop_add_exam_type({
  required context,
  required double height,
  required double width,
}){
  return Container(
    width: width/6,
    child: DropdownButtonFormField2(
      decoration:drop_decoration(),
      isExpanded: false,
      hint:Text(
        'Choose Exam Type',
        style: TextStyle(fontSize: width/110,color: Colors.black54),
      ),
      items: examType
          .map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              fontSize: width/110,color: Colors.black
          ),),
      )).toList(),
      validator: (value) {
        if (value == null) {
          return 'Please select Exam Type';
        }
        return null;
      },
      onChanged: (value) {
        MarksCubit.get(context).select_exam_type(value);
        print(MarksCubit.get(context).selected_exam_type);
      },
      onSaved: (value) {
        MarksCubit.get(context).select_exam_type(value);
      },
      buttonStyleData: drop_button_style(width: width),
      iconStyleData:  drop_icon_style(size: 30),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),),
    ),
  );
}