import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/models/Tables/teachers_table.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';

part 'teachers_list_state.dart';

class TeachersListCubit extends Cubit<TeachersListState> {
  TeachersListCubit() : super(TeachersListInitial());

  static TeachersListCubit get(context) => BlocProvider.of(context);

  final TeachersColumns = [
    "Id",
    "Name",
    "Gender",
    "Salary",
    "Phone",
    "Editing",
  ];


  int? sortColumnIndex;
  bool isAscending = false;

  TeachersModel? teachersModel;


  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      teachersModel!.data!.teachersList!.sort((user1, user2) => compareString(
          ascending,
          user1!.teacher_id.toString(),
          user2.teacher_id!.toString()));
    } else if (columnIndex == 1) {
      teachersModel!.data!.teachersList!.sort(
              (user1, user2) => compareString(ascending, user1.name!, user2.name!));
    } else if (columnIndex == 2) {
      teachersModel!.data!.teachersList!.sort((user1, user2) =>
          compareString(ascending, user1.gender!, user2.gender!));
    } else if (columnIndex == 3) {
      teachersModel!.data!.teachersList!.sort((user1, user2) =>
          compareString(ascending, user1.salary!.toString(), user2.salary!.toString()));
    } else if (columnIndex == 4) {
      teachersModel!.data!.teachersList!.sort((user1, user2) =>
          compareString(ascending, user1.phone_number!, user2.phone_number!));
    }

    this.sortColumnIndex = columnIndex;
    this.isAscending = ascending;
    emit(TeachersSortingColumn());
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);


  List<TeacherData> selectedTeachers = [];

  List<TeachersIds> ids = [];

  void isSelected(isSelected,TeacherData te) {

    final isAdding = isSelected != null && isSelected;

    isAdding ? selectedTeachers.add(te) : selectedTeachers.remove(te);

    isAdding ? ids.add(TeachersIds(te.teacher_id)) : ids.removeWhere((TeachersIds item) => item.id == te.teacher_id);

    emit(TeachersOnSelectChanged());

  }

  void onSelectAll(bool isSelectedAll) {
    selectedTeachers =
    isSelectedAll! ? List.from(teachersModel!.data!.teachersList!) : []; //array of objects:countries

    //avoid duplicate ids
    ids.clear();

    isSelectedAll! ? teachersModel!.data!.teachersList!.forEach((te) {
      if (te.teacher_id != null) {
        ids.add(TeachersIds(te.teacher_id!));
      }
    }): ids.clear();

    emit(TeachersOnSelectAll());
  }

  //////////////////////////////////////////////////////////////////////////////

  // Get Data

  int? paginationNumberSave;

  int currentIndex = 0;

  void getTeachersTableData({
    required String name,
    required int paginationNumber,
  }) async {

    teachersModel = null;
    currentIndex = paginationNumber;

    emit(TeachersLoadingDataState());
    DioHelper.postData(
        url: 'getTeachers',
        data: {
          'name': name,
          'page': paginationNumber+1,
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');
      teachersModel = TeachersModel.fromJson(value.data);
      paginationNumberSave = teachersModel!.data!.lastPageNumber!;

      emit(TeachersSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      teachersModel = TeachersModel.fromJson(error.response.data);
      emit(TeachersErrorDataState(teachersModel!));
      print(error.toString());
    });
  }

  // Delete Teachers

  void deleteTeachersData() async {

    emit(TeachersDeletingSuccessDataState());
    DioHelper.postData(
        url: 'deleteTeachers',
        data: {
          'ids': ids,
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');

      ids.clear();
      selectedTeachers.clear();

      emit(TeachersDeletingSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      teachersModel = TeachersModel.fromJson(error.response.data);
      emit(TeachersErrorDataState(teachersModel!));
      print(error.toString());
    });
  }

  void deleteOneTeacherData({required int id}) async {

    emit(TeachersDeletingLoadingDataState());
    DioHelper.postData(
        url: 'deleteTeachers',
        data: {
          "ids" : [
            {
              "id" : id
            }
          ]
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');

      emit(TeachersDeletingSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      teachersModel = TeachersModel.fromJson(error.response.data);
      emit(TeachersErrorDataState(teachersModel!));
      print(error.toString());
    });
  }



// Send a notification
}

class TeachersIds {
  final dynamic id;

  TeachersIds(this.id);

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}