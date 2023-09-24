
import 'package:school_dashboard/models/error_model.dart';

abstract class Courses_State {}

class CourseInitial extends Courses_State {}

class Loading_get_teacher_for_session extends Courses_State {}

class Success_get_teacher_for_session extends Courses_State {}

class Error_get_teacher_for_session extends Courses_State {
  String error;
  Error_get_teacher_for_session(this.error);
}

class Loading_get_subject_for_session extends Courses_State {}

class Success_get_subject_for_session extends Courses_State {}

class Error_get_subject_for_session extends Courses_State {
  String error;
  Error_get_subject_for_session(this.error);
}

class Loading_Create_Session extends Courses_State {}

class Success_Create_Session extends Courses_State {}

class Error_Create_Session extends Courses_State {
  String error;
  Error_Create_Session(this.error);
}



class Loading_get_sessions extends Courses_State {}

class Success_get_sessions extends Courses_State {}

class Error_get_sessions extends Courses_State {
  ErrorModel? errorModel;

  Error_get_sessions(this.errorModel);
}


class  Loading_delete_session extends Courses_State {}

class  Success_delete_session extends Courses_State {}

class  Error_delete_session extends Courses_State {
  final ErrorModel errorModel;

  Error_delete_session(this.errorModel);
}

class SessionsSortingColumn extends Courses_State {}
class Loading_get_Student_for_session extends Courses_State {}

class Success_get_Student_for_session extends Courses_State {}

class Error_get_Student_for_session extends Courses_State {
  String error;
  Error_get_Student_for_session(this.error);
}

class Loading_Confirm_booking extends Courses_State {}

class Success_Confirm_booking extends Courses_State {}

class Error_Confirm_booking extends Courses_State {
  String error;
  Error_Confirm_booking(this.error);
}

