import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_dashboard/constants.dart';
import 'package:school_dashboard/models/Tables/admins_table.dart';
import 'package:school_dashboard/network/remote/dio_helper.dart';

part 'admins_list_state.dart';

class AdminsListCubit extends Cubit<AdminsListState> {
  AdminsListCubit() : super(AdminsListInitial());

  static AdminsListCubit get(context) => BlocProvider.of(context);

  final adminsColumns = [
    "Id",
    "Name",
    "Role",
    "Email",
    "Deleting",
  ];


  int? sortColumnIndex;
  bool isAscending = false;

  AdminsModel? adminsModel;

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      adminsModel!.data!.adminsList!.sort((user1, user2) => compareString(
          ascending,
          user1.admin_id!.toString(),
          user2.admin_id!.toString()));
    } else if (columnIndex == 1) {
      adminsModel!.data!.adminsList!.sort(
              (user1, user2) => compareString(ascending, user1.name!, user2.name!));
    } else if (columnIndex == 2) {
      adminsModel!.data!.adminsList!.sort((user1, user2) =>
          compareString(ascending, user1.role!, user2.role!));
    } else if (columnIndex == 3) {
      adminsModel!.data!.adminsList!.sort((user1, user2) =>
          compareString(ascending, user1.email!, user2.email!));
    }

    this.sortColumnIndex = columnIndex;
    this.isAscending = ascending;
    emit(AdminsSortingColumn());
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);


  List selectedAdmins = [];

  List<AdminsIds> ids = [];

  void isSelected(isSelected,AdminData ad) {

    final isAdding = isSelected != null && isSelected;

    isAdding ? selectedAdmins.add(ad) : selectedAdmins.remove(ad);

    isAdding ? ids.add(AdminsIds(ad.admin_id)) : ids.removeWhere((AdminsIds item) => item.id == ad.admin_id);

    emit(AdminsOnSelectChanged());

  }

  void onSelectAll(bool isSelectedAll) {
    selectedAdmins =
    isSelectedAll! ? List.from(adminsModel!.data!.adminsList!) : []; //array of objects:countries

    //avoid duplicate ids
    ids.clear();

    isSelectedAll! ? adminsModel!.data!.adminsList!.forEach((student) {
      if (student.admin_id != null) {
        ids.add(AdminsIds(student.admin_id!));
      }
    }): ids.clear();

    emit(AdminsOnSelectAll());
  }

  //////////////////////////////////////////////////////////////////////////////

  // Get Data

  int? paginationNumberSave;

  int currentIndex = 0;

  void getAdminsTableData({
    required int paginationNumber,
  }) async {

    adminsModel = null;
    currentIndex = paginationNumber;

    emit(AdminsLoadingDataState());
    DioHelper.postData(
        url: 'getAdmins',
        data: {
          'page': paginationNumber,
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');
      adminsModel = AdminsModel.fromJson(value.data);
      paginationNumberSave = adminsModel!.data!.lastPageNumber!;
      print(adminsModel!.data!.lastPageNumber!);
      print(paginationNumberSave);

      emit(AdminsSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      adminsModel = AdminsModel.fromJson(error.response.data);
      emit(AdminsErrorDataState(adminsModel!));
      print(error.toString());
    });
  }

// Delete Admins

  void deleteStudentsData() async {

    emit(AdminsDeletingLoadingDataState());
    DioHelper.postData(
        url: 'deleteAdmins',
        data: {
          'ids': ids,
        },
        token: token
    ).then((value) async {

      print('value.data: ${value.data}');

      ids.clear();
      selectedAdmins.clear();

      emit(AdminsDeletingSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      adminsModel = AdminsModel.fromJson(error.response.data);
      emit(AdminsDeletingErrorDataState(adminsModel!));
      print(error.toString());
    });
  }

  void deleteOneStudentData({required int id}) async {

    emit(AdminsDeletingLoadingDataState());
    DioHelper.postData(
        url: 'deleteAdmins',
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

      emit(AdminsDeletingSuccessDataState());

    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      adminsModel = AdminsModel.fromJson(error.response.data);
      emit(AdminsDeletingErrorDataState(adminsModel!));
      print(error.toString());
    });
  }



// Send a notification
}

class AdminsIds {
  final dynamic id;

  AdminsIds(this.id);

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
