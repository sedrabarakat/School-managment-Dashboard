import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

Size size=PlatformDispatcher.instance.views.first.physicalSize;
double height=size.height;
List<AdminMenuItem> Side_Bar_Menu= const [
  AdminMenuItem(
      title:"Home" , icon: Icons.home,route: '/dashboard_home'
  ),
  AdminMenuItem(
      title:"Parents" ,icon: Icons.people,
      children: [
        AdminMenuItem(
            title:"Add Parent",route: '/add_parent',icon: CupertinoIcons.plus_circle_fill),
      ]),
  AdminMenuItem(title:"Students" ,icon: Icons.boy,
      children:[
        AdminMenuItem(title:"Add Student",route: '/add_student',icon:CupertinoIcons.plus_circle_fill),
        AdminMenuItem(title:"Students List",route: '/students_list',icon:CupertinoIcons.square_list),
      ]),
  AdminMenuItem(title:"Teachers" ,icon: Icons.people,
      children: [
        AdminMenuItem(title:"Add Teacher",route: '/add_teacher',icon: CupertinoIcons.plus_circle_fill),
        AdminMenuItem(title:"Teachers List",route: '/teachers_list',icon:CupertinoIcons.square_list),
      ]),
      AdminMenuItem(title:"Admins" ,icon: Icons.account_circle_rounded,
      children: [
        AdminMenuItem(title:"Add Admin",route: '/add_admin',icon: CupertinoIcons.plus_circle_fill),
        AdminMenuItem(title:"Admins List",route:'/admin_list',icon:CupertinoIcons.square_list ),]
  ),
  AdminMenuItem(
      title:"Classes" ,icon: Icons.business_center_rounded,
      children: [
        AdminMenuItem(title:"Class List",route: '/class_list',icon: CupertinoIcons.square_list),
      ]),
  AdminMenuItem(title:"Library" ,icon: Icons.book,
      children: [
        AdminMenuItem(title:"Add Book",route: '/add_book',icon: CupertinoIcons.plus_circle_fill),
        AdminMenuItem(title:"Books List",route: '/books_list',icon:CupertinoIcons.square_list),
      ]),
  AdminMenuItem(title:"Articals" ,icon: Icons.library_books_rounded,
      children: [
        AdminMenuItem(title:"Add Artical",route: '/add_articals',icon:CupertinoIcons.plus_circle_fill),
        AdminMenuItem(title:"All Articals",route: '/all_articals',icon:CupertinoIcons.square_list),
      ]),
  AdminMenuItem(
    title:"Courses" ,route: '/courses',
    icon: Icons.featured_play_list,
  ),
  AdminMenuItem(
    title:"inbox" ,route: '/inbox', icon: Icons.email_rounded,
  ),
  //label: 'home',icon: Icons.home,
];

final List<String> classes = [
  'First Grade',
  'Second Grade',
  'Third Grade',
  'Fourth Grade',
  'Fifth Grade',
  'Sixth Grade',
  'Seventh Grade',
  'Eighth Grade',
  'Ninth Grade',
  'Tenth Grade',
  'Eleventh Grade',
  'Bachelor Grade',
];

List<String> empty =[];
final Map<String,String>Mapclasses={
  'First Grade':'1',
  'Second Grade':"2",
  'Third Grade':"3",
  'Fourth Grade':"4",
  'Fifth Grade':"5",
  'Sixth Grade':"6",
  'Seventh Grade':"7",
  'Eighth Grade':"8",
  'Ninth Grade':"9",
  'Tenth Grade':"10",
  'Eleventh Grade':"11",
  'Bachelor Grade':"12",
};



class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.unknown
  };
}


/*void signOut(context)
{


  //PublicChatsCubit.get(context).close1();

  CacheHelper.signOut(key: 'token').then((value)
  {
    if(value)
    {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>   LoginScreen(),),
              (route) => false);
    }
  });


}*/

var token;
var user_id;
var heightSize;