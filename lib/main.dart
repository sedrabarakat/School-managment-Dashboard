
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_dashboard/BlocObserver.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/articles/articles_cubit.dart';
import 'package:school_dashboard/cubit/auth/auth_cubit.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/class_profile/class_profile_cubit.dart';
import 'package:school_dashboard/cubit/class_profile/marks_cubit.dart';
import 'package:school_dashboard/cubit/courses/course_cubit.dart';
import 'package:school_dashboard/cubit/home/home_cubit.dart';
import 'package:school_dashboard/cubit/register/register_cubit.dart';
import 'package:school_dashboard/network/local/cash_helper.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';
import 'package:school_dashboard/routes/web_router.dart';
import 'package:school_dashboard/theme/web_theme.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';

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

  token = CacheHelper.getData(key: 'token');

  user_id = CacheHelper.getData(key: 'user_id');

  print('admin_type=$admin_type');
  print('token=$token');
  print('user_id=$user_id');


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final WebRouter _appRouter = WebRouter();

  @override
  Widget build(BuildContext context) {
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
          designSize: const Size(1920, 934),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              scrollBehavior: MyCustomScrollBehavior(),
              title: 'School Web',
              theme: WebTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              initialRoute: (token != null) ?'/home': '/login',
              onGenerateRoute: _appRouter.onGenerateRoute,
            );
          }),
    );
  }
}
/*(token != null) ? (
                  (admin_type!=2)?'/dashboard_home':
                  (admin_type==2)?'/books_list':'' ): '/login',*/