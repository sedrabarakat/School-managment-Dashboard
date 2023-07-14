import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/models/Tables/students_table.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';

part 'students_list_state.dart';

class StudentsListCubit extends Cubit<StudentsListState> {
  StudentsListCubit() : super(StudentsListInitial()) {}

  static StudentsListCubit get(context) => BlocProvider.of(context);

  final StudentsColumns = [
    "Id",
    "Name",
    "Gender",
    "Class",
    "Section",
    "Parent",
    "Editing",
  ];

  int? sortColumnIndex;
  bool isAscending = false;

  StudentsModel? studentsModel;

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      studentsModel!.data!.studentsList!.sort((user1, user2) => compareString(
          ascending,
          user1.student_id!.toString(),
          user2.student_id!.toString()));
    } else if (columnIndex == 1) {
      studentsModel!.data!.studentsList!.sort(
          (user1, user2) => compareString(ascending, user1.name!, user2.name!));
    } else if (columnIndex == 2) {
      studentsModel!.data!.studentsList!.sort((user1, user2) =>
          compareString(ascending, user1.gender!, user2.gender!));
    } else if (columnIndex == 3) {
      studentsModel!.data!.studentsList!.sort((user1, user2) => compareString(
          ascending, user1.grade!.toString(), user2.grade!.toString()));
    } else if (columnIndex == 4) {
      studentsModel!.data!.studentsList!.sort((user1, user2) =>
          compareString(ascending, user1.parent_name!, user2.parent_name!));
    } else if (columnIndex == 5) {
      studentsModel!.data!.studentsList!.sort((user1, user2) => compareString(
          ascending, user1.payment!.toString(), user2.payment!.toString()));
    }

    this.sortColumnIndex = columnIndex;
    this.isAscending = ascending;
    emit(StudentsSortingColumn());
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);


  List<StudentData> selectedStudents = [];

  List<StudentsIds> ids = [];

  void isSelected(isSelected,StudentData st) {

    final isAdding = isSelected != null && isSelected;

    isAdding ? selectedStudents.add(st) : selectedStudents.remove(st);

    isAdding ? ids.add(StudentsIds(st.student_id)) : ids.removeWhere((StudentsIds item) => item.id == st.student_id);

    emit(StudentsOnSelectChanged());

  }

  void onSelectAll(bool isSelectedAll) {
    selectedStudents =
        isSelectedAll! ? List.from(studentsModel!.data!.studentsList!) : []; //array of objects:countries

    //avoid duplicate ids
    ids.clear();

      isSelectedAll! ? studentsModel!.data!.studentsList!.forEach((student) {
        if (student.student_id != null) {
          ids.add(StudentsIds(student.student_id!));
        }
      }): ids.clear();

    emit(StudentsOnSelectAll());
  }


  //////////////////////////////////////////////////////////////////////////////

  // Get Data

  int? paginationNumberSave;

  int currentIndex = 0;

  void getStudentsTableData({
    required String name,
    required String grade,
    required String section,
    required int paginationNumber,
  }) async {

    studentsModel = null;
    currentIndex = paginationNumber;

    emit(StudentsLoadingDataState());
    DioHelper.postData(
      url: 'getStudents',
      data: {
        'name': name,
        'class': grade,
        'section': section,
        'page': paginationNumber,
      },
      token: token
    ).then((value) async {

      print('value.data: ${value.data}');
      studentsModel = StudentsModel.fromJson(value.data);
      paginationNumberSave = studentsModel!.data!.lastPageNumber!;

      emit(StudentsSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      studentsModel = StudentsModel.fromJson(error.response.data);
      emit(StudentsErrorDataState(studentsModel!));
      print(error.toString());
    });
  }

  // Delete Students

  void deleteStudentsData() async {

    emit(StudentsDeletingLoadingDataState());
    DioHelper.postData(
        url: 'deleteStudents',
        data: {
          'ids': ids,
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');

      ids.clear();
      selectedStudents.clear();

      emit(StudentsDeletingSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      studentsModel = StudentsModel.fromJson(error.response.data);
      emit(StudentsDeletingErrorDataState(studentsModel!));
      print(error.toString());
    });
  }

  void deleteOneStudentData({required int id}) async {

    emit(StudentsDeletingLoadingDataState());
    DioHelper.postData(
        url: 'deleteStudents',
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

      emit(StudentsDeletingSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      studentsModel = StudentsModel.fromJson(error.response.data);
      emit(StudentsDeletingErrorDataState(studentsModel!));
      print(error.toString());
    });
  }

  // Send Absent Students

  void sendAbsentStudents (){

    emit(StudentsAbsentLoadingState());
    DioHelper.postData(
        url: 'setAbsent',
        data: {
          'ids': ids,
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');

      ids.clear();
      selectedStudents.clear();

      emit(StudentsAbsentSuccessState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      emit(StudentsAbsentErrorState());
      print(error.toString());
    });

  }

  // Send a notification

  void sendNotificationsToStudents ({required String title,required String message}){

    emit(StudentsSendNoteLoadingState());
    DioHelper.postData(
        url: 'sendNote',
        data: {
          'title' : title,
          'body' : message,
          'ids': ids,
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');

      ids.clear();
      selectedStudents.clear();

      emit(StudentsSendNoteSuccessState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      emit(StudentsSendNoteErrorState());
      print(error.toString());
    });

  }


}


class StudentsIds {
  final dynamic id;

  StudentsIds(this.id);

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}