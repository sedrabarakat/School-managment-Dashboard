import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/models/Tables/classes_table.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';

part 'classes_list_state.dart';

class ClassesListCubit extends Cubit<ClassesListState> {
  ClassesListCubit() : super(ClassesListInitial());

  static ClassesListCubit get(context) => BlocProvider.of(context);

  final ClassesColumns = [
    "Id",
    "Class",
    "Sections",
    "Students",
    "Teachers",
    "Subjects",
    "Editing"
  ];

  int? sortColumnIndex;
  bool isAscending = false;

  ClassesModel? classesModel;

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      classesModel!.classesList!.sort((user1, user2) => compareString(
          ascending,
          user1.class_id!.toString(),
          user2.class_id!.toString()));
    } else if (columnIndex == 1) {
      classesModel!.classesList!.sort(
              (user1, user2) => compareString(ascending, user1.grade!.toString(), user2.grade!.toString()));
    } else if (columnIndex == 2) {
      classesModel!.classesList!.sort((user1, user2) =>
          compareString(ascending, user1.sections!.toString(), user2.sections!.toString()));
    } else if (columnIndex == 3) {
      classesModel!.classesList!.sort((user1, user2) =>
          compareString(ascending, user1.students!.toString(), user2.students!.toString()));
    } else if (columnIndex == 4) {
      classesModel!.classesList!.sort((user1, user2) =>
          compareString(ascending, user1.teachers!.toString(), user2.teachers!.toString()));
    } else if (columnIndex == 5) {
      classesModel!.classesList!.sort((user1, user2) =>
          compareString(ascending, user1.subjects!.toString(), user2.subjects!.toString()));
    }

    this.sortColumnIndex = columnIndex;
    this.isAscending = ascending;
    emit(ClassesSortingColumn());
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);



  List<ClassData> selectedClasses = [];

  List<ClassesIds> ids = [];

  void isSelected(isSelected,ClassData cl) {

    final isAdding = isSelected != null && isSelected;

    isAdding ? selectedClasses.add(cl) : selectedClasses.remove(cl);

    isAdding ? ids.add(ClassesIds(cl.class_id)) : ids.removeWhere((ClassesIds item) => item.id == cl.class_id);

    emit(ClassesOnSelectChanged());

  }

  void onSelectAll(bool isSelectedAll) {
    selectedClasses =
    isSelectedAll! ? List.from(classesModel!.classesList!) : []; //array of objects:countries

    //avoid duplicate ids
    ids.clear();

    isSelectedAll! ? classesModel!.classesList!.forEach((student) {
      if (student.class_id != null) {
        ids.add(ClassesIds(student.class_id!));
      }
    }): ids.clear();

    emit(ClassesOnSelectAll());
  }

//////////////////////////////////////////////////////////////////////////////

  // Get Data

  int? paginationNumberSave;

  int currentIndex = 0;

  void getClassesTableData() async {

    classesModel = null;
    emit(ClassesLoadingDataState());
    DioHelper.getData(
      url: 'getClasses',
      token: token
    ).then((value) async {

      print('value.data: ${value.data}');
      classesModel = ClassesModel.fromJson(value.data);

      emit(ClassesSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      classesModel = ClassesModel.fromJson(error.response.data);
      emit(ClassesErrorDataState(classesModel!));
      print(error.toString());
    });
  }

// Delete Classes

  void deleteClassesData() async {

    emit(ClassesDeletingLoadingDataState());
    DioHelper.postData(
        url: 'deleteClasses',
        data: {
          'ids': ids,
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');

      ids.clear();
      selectedClasses.clear();

      emit(ClassesDeletingSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      classesModel = ClassesModel.fromJson(error.response.data);
      emit(ClassesDeletingErrorDataState(classesModel!));
      print(error.toString());
    });
  }

  void deleteOneClassData({required int id}) async {

    emit(ClassesDeletingLoadingDataState());
    DioHelper.postData(
        url: 'deleteClasses',
        data : {
          "ids" : [
            {
              "id" : id
            }
          ]
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');

      emit(ClassesDeletingSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      classesModel = ClassesModel.fromJson(error.response.data);
      emit(ClassesDeletingErrorDataState(classesModel!));
      print(error.toString());
    });
  }

  ////////////

  String ?selected_class;


  void select_class(value){
    selected_class=value;
    emit(change_selected_class());
  }

  Future Add_Class({
    required String number
  }) async {
    emit(Loading_Add_Grade_States());
    print(selected_class);
    await DioHelper.postData(url: 'createClass',
        data: {
          'grade': number
        }
    ).then((value) {
      print(value.data);
      emit(Success_Add_Grade_States());
    }).catchError((error) {
      //print(error.response.data);
      emit(Error_Add_Grade_States(error.toString()));
    });
  }

}

class ClassesIds {
  final dynamic id;

  ClassesIds(this.id);

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}


//////////////////////

