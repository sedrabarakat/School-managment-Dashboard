import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/models/Tables/parents_table.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';

part 'parents_list_state.dart';

class ParentsListCubit extends Cubit<ParentsListState> {
  ParentsListCubit() : super(ParentsListInitial());

  static ParentsListCubit get(context) => BlocProvider.of(context);

  final ParentsColumns = [
    "Id",
    "Name",
    "Gender",
    "Phone",
    "Deleting",
  ];


  int? sortColumnIndex;
  bool isAscending = false;

  ParentsModel? parentsModel;


  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      parentsModel!.data!.parentsList!.sort((user1, user2) => compareString(
          ascending,
          user1.parent_id!.toString(),
          user2.parent_id!.toString()));
    } else if (columnIndex == 1) {
      parentsModel!.data!.parentsList!.sort(
              (user1, user2) => compareString(ascending, user1.name!, user2.name!));
    } else if (columnIndex == 2) {
      parentsModel!.data!.parentsList!.sort((user1, user2) =>
          compareString(ascending, user1.gender!, user2.gender!));
    } else if (columnIndex == 3) {
      parentsModel!.data!.parentsList!.sort((user1, user2) =>
          compareString(ascending, user1.phone_number!, user2.phone_number!));
    }

    this.sortColumnIndex = columnIndex;
    this.isAscending = ascending;
    emit(ParentsSortingColumn());
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);


  
  List<ParentData> selectedParents = [];

  List<ParentsIds> ids = [];

  void isSelected(isSelected,ParentData pa) {

    final isAdding = isSelected != null && isSelected;

    isAdding ? selectedParents.add(pa) : selectedParents.remove(pa);

    isAdding ? ids.add(ParentsIds(pa.parent_id)) : ids.removeWhere((ParentsIds item) => item.id == pa.parent_id);

    emit(ParentsOnSelectChanged());

  }

  void onSelectAll(bool isSelectedAll) {
    selectedParents =
    isSelectedAll! ? List.from(parentsModel!.data!.parentsList!) : []; //array of objects:countries

    //avoid duplicate ids
    ids.clear();

    isSelectedAll! ? parentsModel!.data!.parentsList!.forEach((parent) {
      if (parent.parent_id != null) {
        ids.add(ParentsIds(parent.parent_id!));
      }
    }): ids.clear();

    emit(ParentsOnSelectAll());
  }

  //////////////////////////////////////////////////////////////////////////////

  // Get Data

  int? paginationNumberSave;

  int currentIndex = 0;

  void getParentsTableData({
    required String name,
    required String phoneNumber,
    required int paginationNumber,
  }) async {

    parentsModel = null;
    currentIndex = paginationNumber;

    emit(ParentsLoadingDataState());
    DioHelper.postData(
        url: 'getParents',
        data: {
          'name': name,
          'phone_number': phoneNumber,
          'page': paginationNumber,
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');
      parentsModel = ParentsModel.fromJson(value.data);
      paginationNumberSave = parentsModel!.data!.lastPageNumber!;

      emit(ParentsSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      parentsModel = ParentsModel.fromJson(error.response.data);
      emit(ParentsErrorDataState(parentsModel!));
      print(error.toString());
    });
  }



// Delete parents

  void deleteParentsData() async {

    emit(ParentsDeletingLoadingDataState());
    DioHelper.postData(
        url: 'deleteParents',
        data: {
          'ids': ids,
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');

      ids.clear();
      selectedParents.clear();

      emit(ParentsDeletingSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      parentsModel = ParentsModel.fromJson(error.response.data);
      emit(ParentsDeletingErrorDataState(parentsModel!));
      print(error.toString());
    });
  }

  void deleteOneParentData({required int id}) async {

    emit(ParentsDeletingLoadingDataState());
    DioHelper.postData(
        url: 'deleteParents',
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

      emit(ParentsDeletingSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      parentsModel = ParentsModel.fromJson(error.response.data);
      emit(ParentsDeletingErrorDataState(parentsModel!));
      print(error.toString());
    });
  }



// Send a notification
}

class ParentsIds {
  final dynamic id;

  ParentsIds(this.id);

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}