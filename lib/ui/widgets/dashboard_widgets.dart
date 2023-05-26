import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../theme/styles.dart';
import '../components/components.dart';


Widget Celander({
  required double height,
  required double width,
}){
  return Container(
    clipBehavior: Clip.hardEdge,
    height: (height<700)?height/200:height/2.89-height/30,
    width: (width<1400)?width/100:width/5,
    decoration: CircularBorder_decoration.copyWith(
        borderRadius: BorderRadius.circular(50)),
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: height/60),
      child: TableCalendar(
        calendarStyle:CalendarStyle(
            todayDecoration: Circle_BoxDecoration.copyWith(color: Colors.lightBlue)
        ) ,
        rowHeight: (height<700)?height/200:height/28,
        firstDay: DateTime.utc(2015, 1, 1),
        lastDay: DateTime.utc(2035, 1, 1),
        focusedDay: DateTime.now(),
      ),
    ),);
}

Widget animation_column({
  required double height,
  required double width,
  required List<Widget> children,
  int speed=500,
  double horizontalOffset=200.0
}){
  return AnimationLimiter(
    child: Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: Duration(milliseconds: speed),
        childAnimationBuilder: (widget) => SlideAnimation(
          horizontalOffset:horizontalOffset,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children:children,
      ),
    ),
  );
}


class ChartData {
  final String x;
  final double y;
  final Color color;
  ChartData(this.x, this.y,this.color);
}

Widget financial_chart_container(height,width,{
  required double incoming,
  required double outcoming,
}){
  var max=(incoming>outcoming)?incoming:outcoming;
  return Container(
    clipBehavior: Clip.hardEdge,
    height: height/2.4,width: width/3,
    decoration: CircularBorder_decoration.copyWith(borderRadius: BorderRadius.circular(50)),
    child:  Padding(
      padding:  EdgeInsets.all(height/40),
      child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          title: ChartTitle(text: 'Financial State',
            textStyle: const TextStyle(color:Colors.grey ),
            alignment: ChartAlignment.center,
          ),
          primaryYAxis: NumericAxis(minimum: 0, maximum: max+500, interval: 100),
          legend: Legend(isResponsive: true),
          series: financial_List(incoming: incoming,outcoming: outcoming)),
    ),
  );
}


Widget Welcome_Stack({
  required double height,
  required double width,
}){
  return Stack(
    children: [
      Padding(
        padding:  EdgeInsets.only(top: height/12,bottom: height/16),
        child: Container(
            padding: EdgeInsets.only(top: height/20,left:height/20 ),
            height: height/7,width: width/1.8,
            decoration: CircularBorder_decoration,
            child: Animated_Text(width: width, text: 'Welcome...')),
      ),
      Padding(
        padding: EdgeInsets.only(left: width/3,),
        child: Center(
            child: Lottie.asset('assets/images/data.json',height: height/3.5,width:width/4.5 ,
              fit: BoxFit.fill,
            )),),
    ],);
}

Widget number_container({
  required double height,
  required double width,
  required IconData icon,
  required Color color,
  required String catagory,
  required int number
}){
  return Container(
    height: height/9,width: width/6,
    decoration: CircularBorder_decoration,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: height/30),
      child: Row(
        children: [
          Icon(icon,size: width/30,color:color),
          SizedBox(width: width/30),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(catagory,style: Number_TextStyle(width: width)),
              SizedBox(height: height/70,),
              Text('$number',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: width/90
              ),)
            ],)
        ],
      ),
    ),
  );
}

Widget Newest_articals(context,height,width){
  return Container(
    clipBehavior: Clip.hardEdge,
    height: height/2.18,width: width/5,
    padding:  EdgeInsets.only(top: height/30,left: width/50,right: width/60),
    decoration:CircularBorder_decoration.copyWith(
        borderRadius: BorderRadius.circular(50)
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Newest articals',style: TextStyle(
            fontWeight: FontWeight.bold,fontSize: width*0.014
        ),),
        SizedBox(height: height/50,),
        Container(height: 1, color:const Color.fromARGB(255, 237, 242, 248),),
        SizedBox(height: height/50,),
        Expanded(flex:7,
          child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context,index)=>articals_cell(height,width),
          separatorBuilder: (context,index)=>Container(height: 1, color:const Color.fromARGB(255, 237, 242, 248),),
          itemCount: 3),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding:  EdgeInsets.only(left: width/8),
            child: IconButton(
              onPressed: (){
               Basic_Cubit.get(context).change_Route('/all_articals');
            }, icon: const Icon(Icons.arrow_forward_ios,color: Colors.black,),),
          ),
        ),
      ],),
  );
}

Widget articals_cell(height,width){
  return Row(
    children: [
      Container(
        height: height/18,width: width/30,
        decoration: Circle_BoxDecoration.copyWith(color: Colors.grey),),
      SizedBox(width: width/100,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height/40,),
            Text('sedra baakat',style:  TextStyle(
                fontSize: 15,fontWeight: FontWeight.bold
            ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis ,
            ),
            Text('hello every one its nice to post here  AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
              style:  TextStyle(
                  fontSize: 10
              ),
              overflow: TextOverflow.ellipsis,maxLines: 3,),
            SizedBox(height: height/50,)
          ],),
      )
    ],);
}

Widget female_male_chart({
  required double height,
  required double width,
  required double female,
  required double male,
}){
  return Container(
    clipBehavior: Clip.hardEdge,
    height: height/2.4,width: width/5,
    decoration: CircularBorder_decoration.copyWith(borderRadius: BorderRadius.circular(50)),
    child:  SfCircularChart(
      legend: Legend(isVisible: true),
      series: DoughnutList(female: female,male: male),),
  );}


List<DoughnutSeries> DoughnutList({
  required double female,
  required double male,
}){
  return <DoughnutSeries>[
    DoughnutSeries<ChartData, String>(
        strokeColor:Colors.white,
        dataSource: <ChartData>[
          ChartData('Girls', female,Colors.pinkAccent),
          ChartData('Boys', male,Colors.lightBlueAccent),
        ],
        pointColorMapper: (ChartData data, _) => data.color,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        legendIconType:LegendIconType.circle,
        dataLabelSettings:const DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.outside,
        ),
        animationDuration: 2500
    ),
  ];
}

List <ChartSeries<ChartData, String>> financial_List({
  required double incoming,
  required double outcoming,
}){
  return <ChartSeries<ChartData, String>> [
    ColumnSeries<ChartData, String>(
        pointColorMapper: (ChartData data, _) => data.color,
        dataSource: [
          ChartData("incoming", incoming,Colors.lightBlue,),
          ChartData("outcoming", outcoming,Colors.red.shade500),
        ],
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        color: Colors.blue),
  ];
}