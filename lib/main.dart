
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:school_dashboard/BlocObserver.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/articles/articles_cubit.dart';
import 'package:school_dashboard/cubit/auth/auth_cubit.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/class_profile/class_profile_cubit.dart';
import 'package:school_dashboard/cubit/class_profile/marks_cubit.dart';
import 'package:school_dashboard/cubit/courses/course_cubit.dart';
import 'package:school_dashboard/cubit/home/home_cubit.dart';
import 'package:school_dashboard/cubit/home/home_states.dart';
import 'package:school_dashboard/cubit/register/register_cubit.dart';
import 'package:school_dashboard/network/local/cash_helper.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';
import 'package:school_dashboard/routes/web_router.dart';
import 'package:school_dashboard/theme/web_theme.dart';
import 'package:school_dashboard/ui/screens/home/dashboard_home.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'package:window_size/window_size.dart';

import 'cubit/admins/admins_list_cubit.dart';
import 'cubit/classes/classes_list_cubit.dart';
import 'cubit/library/library_cubit.dart';
import 'cubit/parents/parents_list_cubit.dart';
import 'cubit/students/students_list_cubit.dart';
import 'cubit/teachers/teachers_list_cubit.dart';

var heightf =1600;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  await CacheHelper.init();

  admin_type = CacheHelper.getData(key: 'admin_type');

  token = "65|qr68Aj4b9AwmManUUKHH5Gr1tacX7PNfkEApSUV7";

  user_id = CacheHelper.getData(key: 'user_id');

  print('admin_type=$admin_type');
  print('token=$token');
  print('user_id=$user_id');

/* try{
   if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
     //https://github.com/google/flutter-desktop-embedding.git
     setWindowMaxSize( Size(800, 800));
     setWindowMinSize( Size(800, 800));
   }
 }
 catch(e){
   if (kIsWeb) {
     setWindowMaxSize( Size(800, 800));
     setWindowMinSize( Size(800, 800));
    }
 }*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final WebRouter _appRouter = WebRouter();


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AuthCubit()),
        BlocProvider(create: (BuildContext context) => ClassesListCubit()..getClassesTableData()),
        BlocProvider(create: (BuildContext context) => Library_cubit()..Get_Books()),
        BlocProvider(create: (BuildContext context) => Basic_Cubit(ScrollController())),
        BlocProvider(create: (BuildContext context) => MarksCubit()),
        BlocProvider(create: (BuildContext context) => Class_Profile_cubit()),
        BlocProvider(create: (BuildContext context) => ArticlesCubit()),

        BlocProvider(create: (BuildContext context) => RegisterCubit()..getClassesRegister()),
        BlocProvider(create: (BuildContext context) => Courses_cubit()..get_teacher_for_session()..get_student_in_course(session_id: 4)),
      ],

      child: ScreenUtilInit(
          // designSize: const Size(934, 1920),
          designSize: (width>800)? Size(1920, 934):Size(1000,200),

          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              scrollBehavior: MyCustomScrollBehavior(),
              title: 'School Web',
              theme: WebTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              routerDelegate: W_Router.router.routerDelegate,
              routeInformationParser: W_Router.router.routeInformationParser,
              routeInformationProvider: W_Router.router.routeInformationProvider,

            );
          }),
    );
  }
}
/*(token != null) ? (
                  (admin_type!=2)?'/dashboard_home':
                  (admin_type==2)?'/books_list':'' ): '/login',*/

/*  if (kIsWeb) {
    // Some web specific code there
  }
  else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
    // Some android/ios specific code
  }
  else if (defaultTargetPlatform == TargetPlatform.linux || defaultTargetPlatform == TargetPlatform.macOS || defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.fuchsia) {
    // Some desktop specific code there
  }*/
