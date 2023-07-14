part of 'students_list_cubit.dart';

@immutable
abstract class StudentsListState {}

class StudentsListInitial extends StudentsListState {}


class StudentsSortingColumn extends StudentsListState {}

class StudentsOnSelectChanged extends StudentsListState {}

class StudentsOnSelectAll extends StudentsListState {}

class StudentsLoadingDataState extends StudentsListState {}

class StudentsSuccessDataState extends StudentsListState {}

class StudentsErrorDataState extends StudentsListState {
  final StudentsModel studentsModel;

  StudentsErrorDataState(this.studentsModel);
}

class StudentsDeletingLoadingDataState extends StudentsListState {}

class StudentsDeletingSuccessDataState extends StudentsListState {}

class StudentsDeletingErrorDataState extends StudentsListState {
  final StudentsModel studentsModel;

  StudentsDeletingErrorDataState(this.studentsModel);

}

class StudentsAbsentLoadingState extends StudentsListState {}

class StudentsAbsentSuccessState extends StudentsListState {}

class StudentsAbsentErrorState extends StudentsListState {}


class StudentsSendNoteLoadingState extends StudentsListState {}

class StudentsSendNoteSuccessState extends StudentsListState {}

class StudentsSendNoteErrorState extends StudentsListState {}


