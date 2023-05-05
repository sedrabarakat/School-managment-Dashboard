import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/BlocObserver.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/cubit/auth_cubit.dart';
import 'package:school_dashboard/network/local/cash_helper.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';
import 'package:school_dashboard/routes/web_router.dart';
import 'package:school_dashboard/theme/web_theme.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

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

      ],
      child: MaterialApp(
        title: 'School Web',
        theme: WebTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: token!=null?'/home':'/login',
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}

