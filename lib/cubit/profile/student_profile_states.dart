abstract class Profiles_states{}

class init_profile_states extends Profiles_states{}


class is_editing_states extends Profiles_states{}

class editing_closed_state extends Profiles_states{}

class Loading_get_teacher_profile extends Profiles_states{}

class Success_get_teacher_profile extends Profiles_states{}

class Error_get_teacher_profile extends Profiles_states{
  String error;
  Error_get_teacher_profile(this.error);
}


class Loading_get_student_profile extends Profiles_states{}

class Success_get_student_profile extends Profiles_states{}

class Error_get_student_profile extends Profiles_states{
  String error;
  Error_get_student_profile(this.error);
}