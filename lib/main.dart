import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/BlocObserver.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/admins/admins_list_cubit.dart';
import 'package:school_dashboard/cubit/auth/auth_cubit.dart';
import 'package:school_dashboard/cubit/basic/basic_cubit.dart';
import 'package:school_dashboard/cubit/classes/classes_list_cubit.dart';
import 'package:school_dashboard/cubit/home/home_cubit.dart';
import 'package:school_dashboard/cubit/parents/parents_list_cubit.dart';
import 'package:school_dashboard/cubit/students/students_list_cubit.dart';
import 'package:school_dashboard/network/local/cash_helper.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';
import 'package:school_dashboard/routes/web_router.dart';

import 'package:school_dashboard/theme/web_theme.dart';
import 'package:school_dashboard/ui/screens/layout/basic_screen.dart';


import 'cubit/teachers/teachers_list_cubit.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Size size = PlatformDispatcher.instance.views.first.physicalSize;

  heightSize = size.height;

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  await CacheHelper.init();

  token = CacheHelper.getData(key: 'token');

  user_id = CacheHelper.getData(key: 'user_id');

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
        BlocProvider(create: (BuildContext context) => Basic_Cubit()),
        BlocProvider(create: (BuildContext context) => Home_Cubit()),
        BlocProvider(create: (BuildContext context) => StudentsListCubit()..getStudentsTableData(name: '', grade: '', section: '', paginationNumber: 0)),
        BlocProvider(create: (BuildContext context) => ClassesListCubit()..getClassesTableData()),
        BlocProvider(create: (BuildContext context) => ParentsListCubit()..getParentsTableData(name: '', phoneNumber: '', paginationNumber: 0)),
        BlocProvider(create: (BuildContext context) => TeachersListCubit()..getTeachersTableData(name: '', paginationNumber: 0)),
        BlocProvider(create: (BuildContext context) => AdminsListCubit()..getAdminsTableData(paginationNumber: 0)),

      ],
      child: MaterialApp(
        home: Basic_Screen(),
        title: 'School Web',
        theme: WebTheme.lightTheme,
        debugShowCheckedModeBanner: false,
       // initialRoute: token!=null?'/home':'/login',
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}

