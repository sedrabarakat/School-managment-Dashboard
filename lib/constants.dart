import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

List<AdminMenuItem> Side_Bar_Menu= const [
  AdminMenuItem(
      title:"Home" , icon: Icons.home,route: '/dashboard_home'
  ),
  AdminMenuItem(
      title:"Parents" ,icon: Icons.people,
      children: [
        AdminMenuItem(
            title:"Add Parent",route: '/add_parent',icon: CupertinoIcons.plus_circle_fill),
        AdminMenuItem(
            title:"Parents List",route: '/parents_list',icon: CupertinoIcons.square_list),
      ]),
  AdminMenuItem(title:"Students" ,icon: Icons.boy,
      children:[
        AdminMenuItem(title:"Add class",route: '/add_class',icon: CupertinoIcons.plus_circle_fill),
        AdminMenuItem(title:"Add Student",route: '/add_student',icon:CupertinoIcons.plus_circle_fill),
        AdminMenuItem(title:"Students List",route: '/students_list',icon:CupertinoIcons.square_list),
        AdminMenuItem(title:"Grades",route: '/grades',icon: Icons.grade_outlined),
        AdminMenuItem(title:"Send notification",route: '/send_notification',icon: Icons.notification_add),
      ]),
  AdminMenuItem(title:"Teachers" ,icon: Icons.people,
      children: [
        AdminMenuItem(title:"Add Teacher",route: '/add_teacher',icon: CupertinoIcons.plus_circle_fill),
        AdminMenuItem(title:"Teachers List",route: '/teachers_list',icon:CupertinoIcons.square_list),
        AdminMenuItem(title:"Teachers Schedules",route: '/teachers_schedules',icon:Icons.library_add_check_sharp),
      ]),
  AdminMenuItem(title:"Admins" ,icon: Icons.account_circle_rounded,
      children: [
        AdminMenuItem(title:"Add Admin",route: '/add_admin',icon: CupertinoIcons.plus_circle_fill),
        AdminMenuItem(title:"Admins List",route:'/admin_list',icon:CupertinoIcons.square_list ),]
  ),
  AdminMenuItem(
      title:"Subjects" ,icon: Icons.people,
      children: [
        AdminMenuItem(title:"Add Subject",route: '/add_subject',icon: CupertinoIcons.plus_circle_fill),
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
    title:"inbox" ,route: '/inbox', icon: Icons.email_rounded,
  ),
  AdminMenuItem(
    title:"Courses" ,route: '/courses',
    icon: Icons.featured_play_list,
  ),

  //label: 'home',icon: Icons.home,
];


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