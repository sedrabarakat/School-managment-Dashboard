import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_dashboard/cubit/students/students_list_cubit.dart';

part 'paginate_state.dart';

class PaginateCubit extends Cubit<PaginateState> {
  PaginateCubit() : super(PaginateInitial());

  static PaginateCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;


/*void changePagination(context,index,){
    currentIndex = index;
    print(currentIndex);
    StudentsListCubit.get(context).getStudentsTableData(name: name, grade: grade, section: section, paginationNumber: paginationNumber)
    //StudentsListCubit.get(context).studentsModel=null;
    emit(ChangePaginationState());
  }*/
}
