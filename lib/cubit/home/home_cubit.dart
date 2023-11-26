import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';

import '../../models/home.dart';
import 'home_states.dart';

class Home_Cubit extends Cubit<Home_State>{

 Home_Cubit():super(init_Home());

 static Home_Cubit get(context)=>BlocProvider.of(context);

 Map<dynamic,dynamic>?Home;
 List<dynamic>articals=[];
 Future Get_Home()async{
  emit(Loading_Get_Home());
  DioHelper.getData(url: 'dashBoardHome',token: token).then((value){
   Home=value.data;
   articals=value.data['data']['Articles'];
   print(Home);
   emit(Success_Get_Home());
  }).
  catchError((error){
   print(error.response.data);
   emit(Error_Get_Home(error.toString()));
  });
 }




}