
import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/ui/screens/admins/add_admin.dart';
import 'package:school_dashboard/ui/screens/admins/admin_list.dart';
import 'package:school_dashboard/ui/screens/articals/all_articals.dart';
import 'package:school_dashboard/ui/screens/classes/class_list.dart';
import 'package:school_dashboard/ui/screens/classes/class_profile.dart';
import 'package:school_dashboard/ui/screens/courses/add_courses.dart';
import 'package:school_dashboard/ui/screens/courses/courses.dart';
import 'package:school_dashboard/ui/screens/home/dashboard_home.dart';

import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';
import 'package:school_dashboard/ui/screens/login.dart';
import '../constants.dart';


class WebRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
        break;
      case '/home':
        return MaterialPageRoute(
          builder: (_) => Basic_Screen(),
        );


      default:
        return null;
    }
  }
}
class W_Router{

      static GoRouter router = GoRouter(
        //debugLogDiagnostics: true,//dashboard_home
        initialLocation:(token!=null)?(admin_type==2)?'/books_list':'/dashboard_home':'/login',
        routes: [
          GoRoute(
            path: '/basic_screen',
            name: 'basic_screen',
            pageBuilder: (context, state) {
              Basic_Cubit.get(context).routing(route: '/basic_screen', context: context);
              return  MaterialPage(child: Basic_Screen());
            },
          ),
          GoRoute(
            path: '/login',
            name: 'login',
            pageBuilder: (context, state) {
              Basic_Cubit.get(context).routing(route: '/login', context: context);
              return  MaterialPage(child: LoginScreen());
            },
          ),

          GoRoute(
            path: '/dashboard_home',
            name: 'dashboard_home',
            pageBuilder: (context, state) {
              Basic_Cubit.get(context).routing(route: '/dashboard_home', context: context);
              return  MaterialPage(child: Basic_Screen());
            },
          ),


          GoRoute(
              path: '/students_list',
              name: 'students_list',
              pageBuilder: (context, state) {
                Basic_Cubit.get(context).routing(route: '/students_list', context: context);
                return  MaterialPage(child: Basic_Screen());
              },
            routes: [
              GoRoute(
                path: 'student_profile/:Student_id',
                name: 'student_profile',
                pageBuilder: (context,state){

                  Student_id=int.parse(state.pathParameters['Student_id']!);
                  Basic_Cubit.get(context).routing(route: '/students_list/student_profile/:Student_id', context: context);

                  return MaterialPage(child: Basic_Screen());
                }),]

          ),

          GoRoute(path: '/add_parent',name: "add_parent",
              pageBuilder: (context,state){
                Basic_Cubit.get(context).routing(route: '/add_parent', context: context);
                return MaterialPage(child: Basic_Screen());
              }
          ),

          GoRoute(path: '/parents_list',name: "parents_list",
              pageBuilder: (context,state){
                Basic_Cubit.get(context).routing(route: '/parents_list', context: context);
                return MaterialPage(child: Basic_Screen());
              },
            routes: [
              GoRoute(
                path: ':Parent_id/add_student',
                name: 'add_student',
                pageBuilder: (context, state) {
                  parent_id=int.parse(state.pathParameters['Parent_id']!);
                  Basic_Cubit.get(context).routing(route: '/add_student', context: context);
                  return  MaterialPage(child: Basic_Screen());
                },
              ),
            ]
          ),

          GoRoute(path: '/add_teacher',name: "add_teacher",
              pageBuilder: (context,state){
                Basic_Cubit.get(context).routing(route: '/add_teacher', context: context);
                return MaterialPage(child: Basic_Screen());
              }
          ),
          GoRoute(path: '/teachers_list',name: "teachers_list",
              pageBuilder: (context,state){
                Basic_Cubit.get(context).routing(route: '/teachers_list', context: context);
                return MaterialPage(child: Basic_Screen());
              },
              routes: [
                GoRoute(path: 'teacher_profile/:Teacher_id',name: "teacher_profile",
                    pageBuilder: (context,state){
                      Teacher_id=int.parse(state.pathParameters['Teacher_id']!);
                      Basic_Cubit.get(context).routing(route: '/teachers_list/teacher_profile/:Teacher_id', context: context);
                      return MaterialPage(child: Basic_Screen());
                    }
                ),
              ]
          ),

          GoRoute(path: '/class_list',name: "class_list",
              pageBuilder: (context,state){
                Basic_Cubit.get(context).routing(route: '/class_list', context: context);
                return MaterialPage(child: Basic_Screen());},
              routes: [
                GoRoute(path: 'class_profile/:class_id',name: "class_profile",
                    pageBuilder: (context,state){
                      class_id=int.parse(state.pathParameters['class_id']!);
                      Basic_Cubit.get(context).routing(route: '/class_list/class_profile/:class_id', context: context);
                      return MaterialPage(child: Basic_Screen());
                    }
                ),
              ]
          ),


          GoRoute(path: '/add_admin',name: "add_admin",
            pageBuilder: (context,state){
              Basic_Cubit.get(context).routing(route: '/add_admin', context: context);
              return MaterialPage(child: Basic_Screen());
            },
          ),
          GoRoute(path: '/admin_list',name: "admin_list",
            pageBuilder: (context,state){
              Basic_Cubit.get(context).routing(route: '/admin_list', context: context);
              return MaterialPage(child: Basic_Screen());
            },
          ),

          GoRoute(path: '/add_book',name: "add_book",
            pageBuilder: (context,state){
              Basic_Cubit.get(context).routing(route: '/add_book', context: context);
              return MaterialPage(child: Basic_Screen());
            },
          ),

          GoRoute(path: '/books_list',name: "books_list",
            pageBuilder: (context,state){
              Basic_Cubit.get(context).routing(route: '/books_list', context: context);
              return MaterialPage(child: Basic_Screen());
            },
          ),

          GoRoute(path: '/all_articals',name: "all_articals",
            pageBuilder: (context,state){
            Basic_Cubit.get(context).routing(route: '/all_articals', context: context);
              return MaterialPage(child: Basic_Screen());
            },
          ),
          GoRoute(path: '/add_articals',name: "add_articals",

            pageBuilder: (context,state){
              Basic_Cubit.get(context).routing(route: '/add_articals', context: context);
              return MaterialPage(child: Basic_Screen());
            },
          ),

          GoRoute(path: '/inbox',name: "inbox",
            pageBuilder: (context,state){
              Basic_Cubit.get(context).routing(route: '/inbox', context: context);
              return MaterialPage(child: Basic_Screen());
            },
          ),
          GoRoute(path: '/add_courses',name: "add_courses",
            pageBuilder: (context,state){
              Basic_Cubit.get(context).routing(route: '/add_courses', context: context);
              return MaterialPage(child: Basic_Screen());
            },
          ),

          GoRoute(path: '/courses',name: "courses",
              pageBuilder: (context,state){
                Basic_Cubit.get(context).routing(route: '/courses', context: context);
                return MaterialPage(child: Basic_Screen());
              },

              routes: [
                GoRoute(path: 'course_students_list/:Sessions_id',name: "course_students_list",
                  pageBuilder: (context,state){
                    Sessions_id=int.parse(state.pathParameters['Sessions_id']!);
                   Basic_Cubit.get(context).routing(route: '/courses/course_students_list/:Sessions_id', context: context);
                    return MaterialPage(child: Basic_Screen());
                  },
                ),
              ]
          ),



        ],
      );
}

