import 'package:school_dashboard/models/class_profile_model.dart';

abstract class Class_Profile_States{}

class Class_init_Profile_States extends Class_Profile_States{}

class Loading_Add_Section_States extends Class_Profile_States{}

class Success_Add_Section_States extends Class_Profile_States{}

class Error_Add_Section_States extends Class_Profile_States{
  String error;
  Error_Add_Section_States(this.error);
}

class change_selected_class extends Class_Profile_States{}

class Change_Size_States extends Class_Profile_States{}


class Loading_Add_Subject_States extends Class_Profile_States{}

class Success_Add_Subject_States extends Class_Profile_States{}

class Error_Add_Subject_States extends Class_Profile_States{
  String error;
  Error_Add_Subject_States(this.error);
}

class Loading_get_class_States extends Class_Profile_States{}

class Success_get_class_States extends Class_Profile_States{}

class Error_get_class_States extends Class_Profile_States{
  String error;
  Error_get_class_States(this.error);
}

class Loading_get_hessas_State extends Class_Profile_States{}

class Success_get_hessas_State extends Class_Profile_States{}

class Error_get_hessas_State extends Class_Profile_States{
  String error;
  Error_get_hessas_State(this.error);
}

class Loading_Available_teacher_State extends Class_Profile_States{}

class Success_Available_teacher_State extends Class_Profile_States{}

class Error_Available_teacher_State extends Class_Profile_States{
  String error;
  Error_Available_teacher_State(this.error);
}

class Success_all_indexing_teacher_State extends Class_Profile_States{}

class change extends Class_Profile_States{}


class Loading_Update_program_State extends Class_Profile_States{}

class Success_Update_program_State extends Class_Profile_States{}

class Error_Update_program_State extends Class_Profile_States{
  String error;
  Error_Update_program_State(this.error);
}

class Loading_delete_section_State extends Class_Profile_States{}

class Success_delete_section_State extends Class_Profile_States{}

class Error_delete_section_State extends Class_Profile_States{
  String error;
  Error_delete_section_State(this.error);
}

class Loading_delete_subject_State extends Class_Profile_States{}

class Success_delete_subject_State extends Class_Profile_States{}

class Error_delete_subject_State extends Class_Profile_States{
  String error;
  Error_delete_subject_State(this.error);
}

class Add_Exam_File_state extends Class_Profile_States{}


class Loading_Add_exam_photo extends Class_Profile_States{}

class Success_Add_exam_photo extends Class_Profile_States{}

class Error_Add_exam_photo extends Class_Profile_States{
  String error;
  Error_Add_exam_photo(this.error);
}

class Loading extends Class_Profile_States{}




class UploadExcelFileLoadingState extends Class_Profile_States {}

class UploadExcelFileSuccessState extends Class_Profile_States {
  final MarksModel marksModel;

  UploadExcelFileSuccessState(this.marksModel);
}

class UploadExcelFileErrorState extends Class_Profile_States {
  final MarksModel marksModel;

  UploadExcelFileErrorState(this.marksModel);
}


