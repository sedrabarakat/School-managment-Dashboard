import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';

import 'inbox_states.dart';

class inbox_cubit extends Cubit<inbox_states>{

  inbox_cubit():super(init_inbox_state());

  static inbox_cubit get(context)=>BlocProvider.of(context);

  Map<String,dynamic>?inbox;
  List <dynamic>complaints=[];
  Future Get_inbox()async{
    emit(Loading_get_inbox());
    DioHelper.getData(url: 'getComplaint').then((value) {
      inbox=value.data;
      complaints=inbox?['data'];
      print(complaints);
      emit(Success_get_inbox());
    }).
    catchError((error){
              emit(Error_get_inbox(error.toString()));
            });
    
  }
}