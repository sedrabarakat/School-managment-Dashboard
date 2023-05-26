import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_states.dart';

class Home_Cubit extends Cubit<Home_State>{

 Home_Cubit():super(init_Home());

 static Home_Cubit get(context)=>BlocProvider.of(context);

}