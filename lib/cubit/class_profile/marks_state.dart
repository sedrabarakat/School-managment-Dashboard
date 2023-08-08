part of 'marks_cubit.dart';

@immutable
abstract class MarksState {}

class MarksInitial extends MarksState {}

class DownloadExcelFileLoadingState extends MarksState {}

class DownloadExcelFileSuccessState extends MarksState {}

class DownloadExcelFileErrorState extends MarksState {}


class PickCvsFile extends MarksState {

}


class change_selected_section extends MarksState {}

class change_selected_subject extends MarksState {}

class change_selected_exam_type extends MarksState {}

