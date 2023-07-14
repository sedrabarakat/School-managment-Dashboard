part of 'teachers_list_cubit.dart';

@immutable
abstract class TeachersListState {}

class TeachersListInitial extends TeachersListState {}

class TeachersSortingColumn extends TeachersListState {}

class TeachersOnSelectChanged extends TeachersListState {}

class TeachersOnSelectAll extends TeachersListState {}

class TeachersLoadingDataState extends TeachersListState {}

class TeachersSuccessDataState extends TeachersListState {}

class TeachersErrorDataState extends TeachersListState {
  final TeachersModel teachersModel;

  TeachersErrorDataState(this.teachersModel);
}

class TeachersDeletingLoadingDataState extends TeachersListState {}

class TeachersDeletingSuccessDataState extends TeachersListState {}

class TeachersDeletingErrorDataState extends TeachersListState {
  final TeachersModel teachersModel;

  TeachersDeletingErrorDataState(this.teachersModel);

}