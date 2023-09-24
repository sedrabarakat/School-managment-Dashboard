
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

