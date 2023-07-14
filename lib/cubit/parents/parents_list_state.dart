part of 'parents_list_cubit.dart';

@immutable
abstract class ParentsListState {}

class ParentsListInitial extends ParentsListState {}

class ParentsSortingColumn extends ParentsListState {}

class ParentsOnSelectChanged extends ParentsListState {}

class ParentsOnSelectAll extends ParentsListState {}

class ParentsLoadingDataState extends ParentsListState {}

class ParentsSuccessDataState extends ParentsListState {}

class ParentsErrorDataState extends ParentsListState {
  final ParentsModel parentsModel;

  ParentsErrorDataState(this.parentsModel);
}

class ParentsDeletingLoadingDataState extends ParentsListState {}

class ParentsDeletingSuccessDataState extends ParentsListState {}

class ParentsDeletingErrorDataState extends ParentsListState {
  final ParentsModel parentsModel;

  ParentsDeletingErrorDataState(this.parentsModel);

}