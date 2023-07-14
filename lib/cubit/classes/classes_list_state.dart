part of 'classes_list_cubit.dart';

@immutable
abstract class ClassesListState {}

class ClassesListInitial extends ClassesListState {}

class ClassesSortingColumn extends ClassesListState {}

class ClassesOnSelectChanged extends ClassesListState {}

class ClassesOnSelectAll extends ClassesListState {}

class ClassesLoadingDataState extends ClassesListState {}

class ClassesSuccessDataState extends ClassesListState {}

class ClassesErrorDataState extends ClassesListState {
  final ClassesModel classesModel;

  ClassesErrorDataState(this.classesModel);
}

class ClassesDeletingLoadingDataState extends ClassesListState {}

class ClassesDeletingSuccessDataState extends ClassesListState {}

class ClassesDeletingErrorDataState extends ClassesListState {
  final ClassesModel classesModel;

  ClassesDeletingErrorDataState(this.classesModel);
}