part of 'admins_list_cubit.dart';

@immutable
abstract class AdminsListState {}

class AdminsListInitial extends AdminsListState {}

class AdminsSortingColumn extends AdminsListState {}

class AdminsOnSelectChanged extends AdminsListState {}

class AdminsOnSelectAll extends AdminsListState {}

class AdminsLoadingDataState extends AdminsListState {}

class AdminsSuccessDataState extends AdminsListState {}

class AdminsErrorDataState extends AdminsListState {
  final AdminsModel adminsModel;

  AdminsErrorDataState(this.adminsModel);
}

class AdminsDeletingLoadingDataState extends AdminsListState {}

class AdminsDeletingSuccessDataState extends AdminsListState {}

class AdminsDeletingErrorDataState extends AdminsListState {
  final AdminsModel adminsModel;

  AdminsDeletingErrorDataState(this.adminsModel);

}